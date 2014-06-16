

doubleClicked = false
firstClicked = false
doubleClickIntervels = 3
clickIntervel = 0
doubleClickCheckSchedulId = -1

function logicLayer()
            local layer = cc.Layer:create()
            layer:addChild(player)
            
            --检查逻辑
            local function clickLogic()
            
                if not firstClicked then
                	firstClicked = true
                else
                    doubleClicked = true
                 end
            end
            
            --双击检查
            local function doubleClickCheck()
                clickIntervel = clickIntervel + 1
                if clickIntervel <= doubleClickIntervels and doubleClicked then
                    cclog("shuangji")
                    --执行双击的动作
                    player:getPhysicsBody():setVelocity(cc.p(0, tapV*1.2))
                     jumping = true
                    --重置
                    doubleClicked = false
                    firstClicked = false
                    clickIntervel=0
                elseif clickIntervel == doubleClickIntervels and firstClicked then
                    cclog("danji")
                    --执行单击动作
                     player:getPhysicsBody():setVelocity(cc.p(0, tapV))
                     jumping = true
                    --重置
                    doubleClicked = false
                    firstClicked = false
                    clickIntervel=0
                elseif clickIntervel >= doubleClickIntervels then
                    clickIntervel=0
                end
            end
            
           doubleClickCheckSchedulId = sched:scheduleScriptFunc(doubleClickCheck,0.2,false)
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
                        clickLogic()

                       -- player:getPhysicsBody():setVelocity(cc.p(0, tapV))
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
                
                if spriteA:getTag() == tags.tagOfLand and spriteB:getTag() == tags.tagOfPlayer then
                    jumping = false;
                end
                if spriteA:getTag() == tags.tagOfPlayer and spriteB:getTag() == tags.tagOfLand then
                    jumping = false;
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