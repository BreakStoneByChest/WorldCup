        meter = 0
        --create StatusLayer
        StatusLayer = {}
        StatusLayer.labelCoin = nil
        StatusLayer.labelMeter = nil
        StatusLayer.labelPause = nil
        StatusLayer.index = true

        function StatusLayer.create() 
            local layer = cc.Layer:create();

            StatusLayer.labelCoin = cc.LabelTTF:create("Coins:0", "Abduction.ttf", 20)
            StatusLayer.labelCoin:setColor(cc.c3b(0,0,0))

            StatusLayer.labelCoin:setPosition(cc.p(70, visibleSize.height - 20))
            --layer:addChild(StatusLayer.labelCoin)

            StatusLayer.labelMeter = cc.LabelTTF:create("Meters:0", "Abduction.ttf", 20)
            StatusLayer.labelMeter:setColor(cc.c3b(0,0,0))
            StatusLayer.labelMeter:setPosition(cc.p(visibleSize.width/4, visibleSize.height-40))
            layer:addChild(StatusLayer.labelMeter)
            
            local function menuCallback()
                if StatusLayer.index then
                    StatusLayer.labelPause:setString("Resume")
                    cc.Director:getInstance():pause()
                    StatusLayer.index = false
                else 
                StatusLayer.labelPause:setString("Pause")
                    cc.Director:getInstance():resume()
                    StatusLayer.index = true
                end
            end
            StatusLayer.labelPause = cc.LabelTTF:create("Pause", "Abduction.ttf", 20)
            StatusLayer.labelPause:setColor(cc.c3b(0,0,0))
            local  pauseItem = cc.MenuItemLabel:create(StatusLayer.labelPause)
            
            pauseItem:registerScriptTapHandler(menuCallback)
            
            local menu = cc.Menu:create()
            menu:addChild(pauseItem)
            menu:setPosition( cc.p(visibleSize.width - 70, visibleSize.height - 40) )
            layer:addChild(menu,1000)

            return layer
        end
        
        function StatusLayer.setCoin(num)
           local str = string.format("Coins:%d",num)
            StatusLayer.labelCoin:setString(str)
            StatusLayer.labelCoin:setColor(cc.c3b(0,0,0))
       
        end
        function StatusLayer.setMeter(num)
         local str = string.format("Meters:%0.3f",num)
         StatusLayer.labelMeter:setString(str)
         StatusLayer.labelMeter:setColor(cc.c3b(0,0,0))
        end
        