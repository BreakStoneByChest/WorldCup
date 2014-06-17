 --create BackgroundLayer
BackgroundLayer = BackgroundLayer or {}

    function BackgroundLayer.create()
        local layerBg = cc.Layer:create()
       -- local bg = cc.Sprite:create(res.PlayBG_png)
       -- bg:setPosition(cc.p(visibleSize.width * 2, visibleSize.height / 2))
        --layerBg:addChild(bg)
        --layerBg:setScale(0.2)

        -- first moving land
        local land_1 = cc.Sprite:create(res.PlayBG_png)
        land_1:setPosition(visibleSize.width / 2, visibleSize.height / 2)
        layerBg:addChild(land_1, 100)
        local move1 = cc.MoveTo:create((visibleSize.width+bgSize)/background_speed/2, cc.p(- bgSize/2, visibleSize.height / 2))
        local reset1 = cc.Place:create(cc.p(bgSize / 2 +visibleSize.width, visibleSize.height / 2))
        land_1:runAction(cc.RepeatForever:create(cc.Sequence:create(move1, reset1)))
        cclog("ddddd"..background_speed)
        -- second moving land
        local land_2 = cc.Sprite:create(res.PlayBG_png)
        land_2:setPosition(bgSize / 2 +visibleSize.width, visibleSize.height / 2)
        layerBg:addChild(land_2, 100)
        local move2 = cc.MoveTo:create((visibleSize.width+bgSize)/background_speed, cc.p(-bgSize / 2, visibleSize.height / 2))
        local reset2 = cc.Place:create(cc.p(bgSize  / 2 + visibleSize.width , visibleSize.height / 2))
        land_2:runAction(cc.RepeatForever:create(cc.Sequence:create(move2, reset2)))

        return layerBg, land_1, land_2
    end

    return BackgroundLayer