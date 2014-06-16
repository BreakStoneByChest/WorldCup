 --create BackgroundLayer
BackgroundLayer = BackgroundLayer or {}

    function BackgroundLayer.create()
        local layerBg = cc.Layer:create()
        local bg = cc.Sprite:create(res.PlayBG_png)
        bg:setPosition(cc.p(bgSize / 2 - visibleSize.width * 2, visibleSize.height / 2))
        layerBg:addChild(bg)
        layerBg:setScale(0.2)

        -- first moving land
        local land_1 = cc.Sprite:create(res.PlayBG_png)
        land_1:setPosition(bgSize / 2 - visibleSize.width * 2, visibleSize.height / 2)
        layerBg:addChild(land_1, 100)
        local move1 = cc.MoveTo:create(background_speed, cc.p(- bgSize / 2 - visibleSize.width * 2, visibleSize.height / 2))
        local reset1 = cc.Place:create(cc.p(bgSize / 2 - visibleSize.width * 2, visibleSize.height / 2))
        land_1:runAction(cc.RepeatForever:create(cc.Sequence:create(move1, reset1)))

        -- second moving land
        local land_2 = cc.Sprite:create(res.PlayBG_png)
        land_2:setPosition(bgSize * 3 / 2 - visibleSize.width * 2, visibleSize.height / 2)
        layerBg:addChild(land_2, 100)
        local move2 = cc.MoveTo:create(background_speed, cc.p(bgSize / 2 - visibleSize.width * 2, visibleSize.height / 2))
        local reset2 = cc.Place:create(cc.p(bgSize * 3 / 2 - visibleSize.width * 2, visibleSize.height / 2))
        land_2:runAction(cc.RepeatForever:create(cc.Sequence:create(move2, reset2)))

        return layerBg, land_1, land_2
    end

    return BackgroundLayer