require"src/GameContants"
require"src/PlayerLayer" 
require"src/OpponentsLayer"
require"src/StatusLayer"    
require"src/FailedLayer"

start_button = cc.LabelTTF:create("Tap to Start", "Abduction.ttf", 20)
start_button:setPosition(cc.p(visibleSize.width/2,visibleSize.height/2))

function logicLayer()
            local layer = cc.Layer:create()
            layer:addChild(player)
            local function onTouchBegan()
                if not ready then
                    ready = true
                    start_button:runAction(cc.FadeOut:create(0.1))
                    --player:getPhysicsBody():setEnable(true)

--                    local enemy = CreateEnemy(layer)
                    layer = CreateOpponents(layer)
                    local function step(delt)
                         meter  = meter + delt
                         StatusLayer.setMeter(meter)
                    end
                    layer:scheduleUpdateWithPriorityLua(step,0)
                else
                    if not jumping then
                        player:getPhysicsBody():setVelocity(cc.p(0, tapV))
                        --jumping = true
                    --  cc.Director:getInstance():getScheduler():unscheduleScriptEntry(createEnemyFunc)
                    --  land_1:stopAllActions()
                    --  land_2:stopAllActions()
                    end
                end
            end
            -- landListener = cc.EventListenerPhysicsContactWithBodies:create(1,2)
            local listener = cc.EventListenerPhysicsContact:create()
            local function oncontact( contact)
                local spriteA = contact:getShapeA():getBody():getNode();
                local spriteB =contact:getShapeB():getBody():getNode();
                cclog("a is %d, b is %d",spriteA:getTag(),spriteB:getTag())
                if spriteA:getTag() == tags.tagOfPlayer and spriteB:getTag()== tags.tagOfStand then
                    cc.Director:getInstance():replaceScene(failedScene.create())
                    sched:unscheduleScriptEntry(createOpponentSchid)
                    cclog("test1")
                end
            
                if spriteA:getTag() == tags.tagOfStand and spriteB:getTag()== tags.tagOfPlayer then
                    cc.Director:getInstance():replaceScene(failedScene.create())
                    sched:unscheduleScriptEntry(createOpponentSchid)
                end
                if spriteA:getTag() == tags.tagOfLayDown and spriteB:getTag()== tags.tagOfPlayer then
                    cc.Director:getInstance():replaceScene(failedScene.create())
                   sched:unscheduleScriptEntry(createOpponentSchid)
                end
               if spriteA:getTag() == tags.tagOfPlayer and spriteB:getTag()== tags.tagOfLayDown then
                    cc.Director:getInstance():replaceScene(failedScene.create())
                    sched:unscheduleScriptEntry(createOpponentSchid)
                end
                return true;
            end
                  listener:registerScriptHandler(oncontact,cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
            gameListener = cc.EventListenerTouchOneByOne:create()
            gameListener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
            
            layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(gameListener, layer)
            layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)
            return layer;
        end                 