

doubleClicked = false
firstClicked = false
doubleClickIntervels = 0.2
clickIntervel = 0
doubleClickCheckSchedulId = -1
guorenIntervel = 0.5
local function oneClick()
      if  not jumping then
         player:getPhysicsBody():setVelocity(cc.p(0, tapV*1.2))
         jumping = true
     end
     --÷ÿ÷√
     doubleClicked = false
     firstClicked = false
end
local function doubleClick()
    
    if  not jumping then
         player:getPhysicsBody():setEnable(false);--setVelocity(cc.p(0, tapV))
         local doclick = cc.Sequence:create(cc.DelayTime:create(guorenIntervel),cc.CallFunc:create(function() player:getPhysicsBody():setEnable(true) end))
         player:runAction(doclick)
         
     end
    
    
     --÷ÿ÷√
     doubleClicked = false
     firstClicked = false
end

function logicLayer()
            local layer = cc.Layer:create()
            layer:addChild(player)
            
            --ºÏ≤È¬ﬂº≠
            local function clickLogic()
                            
                if not firstClicked then
--                    clickIntervel = 0
                    cclog("danji")
                	firstClicked = true
                	local doclick = cc.Sequence:create(cc.DelayTime:create(doubleClickIntervels),cc.CallFunc:create(oneClick))
                    doclick:setTag(tags.tagOfOneClick)
                    player:runAction(doclick)
                elseif not doubleClicked then
                    firstClicked = false
                    cclog("shuangji")
                    player:stopActionByTag(tags.tagOfOneClick)
                    doubleClick()
                    --doubleClicked = true
                 end
            end
            
            local function onTouchBegan(keyCode, event)--)

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
                    meter = 0
                   -- sched:unscheduleScriptEntry(doubleClickCheckSchedulId)
                    cclog("test1")
                end
            
                if spriteA:getTag() == tags.tagOfStand and spriteB:getTag()== tags.tagOfPlayer then
                    cc.Director:getInstance():replaceScene(failedScene.create())
                    meter = 0
                    sched:unscheduleScriptEntry(createOpponentSchid)
                end
                if spriteA:getTag() == tags.tagOfLayDown and spriteB:getTag()== tags.tagOfPlayer then
                    meter = 0
                    cc.Director:getInstance():replaceScene(failedScene.create())
                   sched:unscheduleScriptEntry(createOpponentSchid)
                end
               if spriteA:getTag() == tags.tagOfPlayer and spriteB:getTag()== tags.tagOfLayDown then
                    meter = 0
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
            local zhijian = cc.EventListenerKeyboard:create()
            zhijian:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_KEYBOARD_PRESSED)
           layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(gameListener, layer)
           layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(zhijian, layer)
            layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)
            return layer;
        end                 