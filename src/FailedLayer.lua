
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
    
        local sprite_gameover = cc.Sprite:createWithSpriteFrameName(res.gameover_png)
        sprite_gameover:setPosition(visibleSize.width/2, visibleSize.height/2)
        sprite_gameover:setScale(winSize.height / sprite_gameover:getContentSize().height)
        local failedSc = cc.Scene:create()
        local failedLayer = cc.Layer:create()
        failedLayer:addChild(sprite_gameover)
        
        local score =  cc.UserDefault:getInstance():getDoubleForKey("highestScore")
        local say = nil
        if score == nil or score <= meter then
        	say = string.format("new highest score :%0.3f",meter)
        	cc.UserDefault:getInstance():setDoubleForKey("highestScore",meter)
        else
            
            say = string.format("Final!   %0.3f meter,highest score %0.3f",meter,score)
        end
        
      --  local highScore = cc.LabelTTF:create(str, "Abduction.ttf", 20)
        
        
        --local str = string.format("Final!   %d meter",meter)
        local label = cc.LabelTTF:create(say, "Abduction.ttf", 20)
        label:setColor(cc.c3b(0,0,0))
        label:setPosition( cc.p(visibleSize.width/2, visibleSize.height/2+40) )
        failedLayer:addChild(label)
        local label2 = cc.LabelTTF:create("Tap to Restart", "Abduction.ttf", 20)
        label2:setPosition( cc.p(visibleSize.width/2, visibleSize.height/2) )
        label2:setColor(cc.c3b(0,0,0))
        failedLayer:addChild(label2)
        --exit button
        local function menuCallback()
            cc.Director:getInstance():endToLua()
        end
--        local closeItem = cc.LabelTTF:create("Exit", "Abduction.ttf", 20)
--        closeItem:setPosition( cc.p(visibleSize.width/2, visibleSize.height/3) )
--        closeItem:registerScriptTapHandler(menuCallback)
--        failedLayer:addChild(closeItem)

        local exitLabel = cc.LabelTTF:create("Press to Exit", "Abduction.ttf", 20)
        exitLabel:setColor(cc.c3b(0,0,0))
        local  exitItem = cc.MenuItemLabel:create(exitLabel)
        exitItem:registerScriptTapHandler(menuCallback)
        local menu = cc.Menu:create()
        menu:addChild(exitItem)
        menu:setPosition( cc.p(visibleSize.width/2, visibleSize.height/3) )
        failedLayer:addChild(menu)
    
        failedSc:addChild(failedLayer)
        
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


----PlayerScene = PlayerScene or require"src/PlayerScene"
----require"src/GameLogic"
--failedScene = failedScene or {}
--            
--     function failedScene.create()
--                local failedSc = cc.Scene:create()
--                local failedLayer = cc.Layer:create()
--                local str = string.format("Final!   %d meter",meter)
--                local label = cc.LabelBMFont:create(str, "bitmapFont.fnt")
--                label:setPosition( cc.p(visibleSize.width/2, visibleSize.height/2) )
--                label:setAnchorPoint( cc.p(0.5, 0.5) )
--                failedLayer:addChild(label)
--                failedSc:addChild(failedLayer)
--                local scaleBig = cc.ScaleBy:create(1.0,0.5,0.5)
--                local rotate = cc.RotateBy:create(1.0,360)
--                local actions = cc.Spawn:create(scaleBig,rotate)
--                label:runAction(actions)
--                
--                local againLabel = cc.LabelBMFont:create("again!", "bitmapFont.fnt")
--                
--                againLabel:setAnchorPoint( cc.p(0.5, 0.5) )
--                --againLabel:setScale(0.6)
--                
--                local  item = cc.MenuItemLabel:create(againLabel)
--                
--                local function againCall(sender)
--                       -- run
--                     --againLabel:setString("shit")
--                     cclog("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh")
--                    local sceneGame = PlayerScene.create()
--                    if cc.Director:getInstance():getRunningScene() then
--                        cc.Director:getInstance():replaceScene(sceneGame)
--                    else
--                        cc.Director:getInstance():runWithScene(sceneGame)
--                    end
--                end
--                
--                item:registerScriptTapHandler(againCall)
--                local menu = cc.Menu:create()
--                menu:addChild(item)
--                menu:setPosition( cc.p(visibleSize.width/2, visibleSize.height/3) )
--                failedLayer:addChild(menu)
--                ready = false
--                jumping = false
--                return failedSc
--                
--            end
--    return failedScene                   
