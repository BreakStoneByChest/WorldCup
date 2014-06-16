require"src/GameContants"       
        meter = 0
        --create StatusLayer
        StatusLayer = {}
        StatusLayer.labelCoin = nil
        StatusLayer.labelMeter = nil

        function StatusLayer.create() 
            local layer = cc.Layer:create();

            StatusLayer.labelCoin = cc.LabelTTF:create("Coins:0", "Abduction.ttf", 20)
            --            StatusLayer.labelCoin:setColor(cc.c3b(0,0,0))

            StatusLayer.labelCoin:setPosition(cc.p(70, visibleSize.height - 20))
            layer:addChild(StatusLayer.labelCoin)

            StatusLayer.labelMeter = cc.LabelTTF:create("0M", "Abduction.ttf", 20)
            StatusLayer.labelMeter:setPosition(cc.p(visibleSize.width - 70, visibleSize.height - 20))
            layer:addChild(StatusLayer.labelMeter)

            return layer
        end
        
        function StatusLayer.setCoin(num)
           local str = string.format("Coins:%d",num)
            StatusLayer.labelCoin:setString(str)
       
        end
        function StatusLayer.setMeter(num)
         local str = string.format("Coins:%d",num)
         StatusLayer.labelMeter:setString(str)
        end
        