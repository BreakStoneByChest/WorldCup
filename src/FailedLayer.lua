require"src/GameContants"
 failedScene = {}
            
            function failedScene.create()
                local failedSc = cc.Scene:create()
                local failedLayer = cc.Layer:create()
                local str = string.format("Final!   %d meter",meter)
                local label = cc.LabelBMFont:create(str, "bitmapFont.fnt")
                label:setPosition( cc.p(visibleSize.width/2, visibleSize.height/2) )
                label:setAnchorPoint( cc.p(0.5, 0.5) )
                failedLayer:addChild(label)
                failedSc:addChild(failedLayer)
                local scaleBig = cc.ScaleBy:create(1.0,0.5,0.5)
                local rotate = cc.RotateBy:create(1.0,360)
                local actions = cc.Spawn:create(scaleBig,rotate)
                label:runAction(actions)
                return failedSc
            end