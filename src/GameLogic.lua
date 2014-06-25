

doubleClicked = false
firstClicked = false
doubleClickIntervels = 0.3
clickIntervel = 0
doubleClickCheckSchedulId = -1
guorenIntervel = 0.8

local function oneClick()
    if  not jumping then
        jumpAction = cc.RepeatForever:create(cc.Animate:create(CreateJumpAnimation()))
           jumpAction:setTag(tags.tagOfJump)
       -- local delayTime = cc.DelayTime:create(2)
        --local animation2 = CreateAnimation()
        --local runningAction = cc.RepeatForever:create(cc.Animate:create(animation2))
        player:stopActionByTag(tags.tagOfRun)
        player:runAction(jumpAction)
        player:getPhysicsBody():setVelocity(cc.p(0, tapV*0.9))
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
                    doubleClicked = false
                    firstClicked = false
                    start_button:runAction(cc.FadeOut:create(0.1))
                    --player:getPhysicsBody():setEnable(true)

--                    local enemy = CreateEnemy(layer)
                   layer = CreateOpponents(layer)
                    local function step(delt)
                        meter  = meter + delt
                        StatusLayer.setMeter(meter)
                        if meter < 100 then
                            minDuration = 3 + 2 * (100 - meter) / 100
                            maxDuration = 3 + 2.5 * (100 - meter) / 100
                        end
                    end
                    layer:scheduleUpdateWithPriorityLua(step,0)
                else
                    if not jumping then
                       -- clickLogic()
                       oneClick()
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
                    
                    cc.Director:getInstance():replaceScene(failedScene.create())
                    meter = 0
                   sched:unscheduleScriptEntry(createOpponentSchid)
                end
               if spriteA:getTag() == tags.tagOfPlayer and spriteB:getTag()== tags.tagOfLayDown then
                    
                    cc.Director:getInstance():replaceScene(failedScene.create())
                    meter = 0
                    sched:unscheduleScriptEntry(createOpponentSchid)
                end
                
                if spriteA:getTag() == tags.tagOfLand and spriteB:getTag() == tags.tagOfPlayer then
                      player:stopActionByTag(tags.tagOfRun)
                     runAction = cc.RepeatForever:create(cc.Animate:create(CreatePlayerAnimation()))
                     runAction:setTag(tags.tagOfRun)
                    player:stopActionByTag(tags.tagOfJump) 
                   player:runAction(runAction)
                   cclog("33333333333333333")
                    jumping = false;
                end
                if spriteA:getTag() == tags.tagOfPlayer and spriteB:getTag() == tags.tagOfLand then
                      player:stopActionByTag(tags.tagOfRun)
                     runAction = cc.RepeatForever:create(cc.Animate:create(CreatePlayerAnimation()))
                     runAction:setTag(tags.tagOfRun)
                     player:stopActionByTag(tags.tagOfJump)
                     cclog("222222222222222")
                   player:runAction(runAction)
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