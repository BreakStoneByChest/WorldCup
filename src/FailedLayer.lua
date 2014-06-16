--PlayerScene = PlayerScene or require"src/PlayerScene"
--require"src/GameLogic"
failedScene = failedScene or {}
            
    --reset
    function failedScene.onTouchBegan(touch, event)
        local sceneGame = PlayerScene.create()
        if cc.Director:getInstance():getRunningScene() then
            cc.Director:getInstance():replaceScene(sceneGame)
        else
            cc.Director:getInstance():runWithScene(sceneGame)
        end
        return true
    end
     
    function failedScene.create()
        local failedSc = cc.Scene:create()
        local failedLayer = cc.Layer:create()
        local str = string.format("Final!   %d meter",meter)
        local label = cc.LabelTTF:create(str, "Abduction.ttf", 20)
        label:setPosition( cc.p(visibleSize.width/2, visibleSize.height/2+40) )
--        label:setAnchorPoint( cc.p(0.5, 0.5) )
        failedLayer:addChild(label)
        local label2 = cc.LabelTTF:create("Tap to Restart", "Abduction.ttf", 20)
        label2:setPosition( cc.p(visibleSize.width/2, visibleSize.height/2) )
        failedLayer:addChild(label2)
        
        failedSc:addChild(failedLayer)
        
--        local scaleBig = cc.ScaleBy:create(1.0,0.5,0.5)
--        local rotate = cc.RotateBy:create(1.0,360)
--        local actions = cc.Spawn:create(scaleBig,rotate)
--        label:runAction(actions)
        
        --¼àÌý
        local gameListener = cc.EventListenerTouchOneByOne:create()
        gameListener:registerScriptHandler(failedScene.onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
        local eventDispatcher = failedLayer:getEventDispatcher()
        eventDispatcher:addEventListenerWithSceneGraphPriority(gameListener, failedLayer)
    
        ready = false
        jumping = false
        meter = 0
        return failedSc
        
    end
return failedScene                   
