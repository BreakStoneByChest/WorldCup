 --create BackgroundLayer
BackgroundLayer = BackgroundLayer or {}

    function BackgroundLayer.create()
    
        local scaleFactor = winSize.height / bgHeight
        local bgScaledWidth = scaleFactor * bgWidth
        local position1 = cc.p( bgScaledWidth / 2, visibleSize.height / 2)
        local position2 = cc.p( bgScaledWidth*3/ 2, visibleSize.height / 2)
        local destination = cc.p( - bgScaledWidth / 2, visibleSize.height / 2)
        -- 利用SpriteFrameCache做纹理缓存
        local cache = cc.SpriteFrameCache:getInstance()
        cache:addSpriteFrames(res.background_list)
        local spritebatch = cc.SpriteBatchNode:create(res.background_png)
        
        local reset1 = cc.Place:create(position1)
        local reset2 = cc.Place:create(position2)
        local movecloud1 = cc.MoveTo:create(background_speed, destination)
        local movecloud2 = cc.MoveTo:create(background_speed, position1)
        local movesea1 = cc.MoveTo:create(background_speed/2, destination)
        local movesea2 = cc.MoveTo:create(background_speed/2, position1)
        local movecbeach1 = cc.MoveTo:create(background_speed/4, destination)
        local movecbeach2 = cc.MoveTo:create(background_speed/4, position1)
        
        -- cloud first moving
        local sprite_cloud = cc.Sprite:createWithSpriteFrameName(res.cloud_png)
        sprite_cloud:setPosition( position1 )
        sprite_cloud:setScale(scaleFactor)
        sprite_cloud:runAction(cc.RepeatForever:create(cc.Sequence:create(movecloud1, reset1)))
        -- second moving
        local sprite_cloud2 = cc.Sprite:createWithSpriteFrameName(res.cloud_png)
        sprite_cloud2:setPosition( position2 )
        sprite_cloud2:setScale(scaleFactor)
        sprite_cloud2:runAction(cc.RepeatForever:create(cc.Sequence:create(movecloud2, reset2)))
        
        -- sea first moving
        local sprite_sea = cc.Sprite:createWithSpriteFrameName(res.sea_png)
        sprite_sea:setPosition( position1 )
        sprite_sea:setScale(scaleFactor)
        sprite_sea:runAction(cc.RepeatForever:create(cc.Sequence:create(movesea1, reset1)))
        -- second moving
        local sprite_sea2 = cc.Sprite:createWithSpriteFrameName(res.sea_png)
        sprite_sea2:setPosition( position2 )
        sprite_sea2:setScale(scaleFactor)
        sprite_sea2:runAction(cc.RepeatForever:create(cc.Sequence:create(movesea2, reset2)))

        -- beach first moving
        local sprite_beach = cc.Sprite:createWithSpriteFrameName(res.beach_png)
        sprite_beach:setPosition( position1 )
        sprite_beach:setScale(scaleFactor)
        sprite_beach:runAction(cc.RepeatForever:create(cc.Sequence:create(movecbeach1, reset1)))
        -- second moving
        local sprite_beach2 = cc.Sprite:createWithSpriteFrameName(res.beach_png)
        sprite_beach2:setPosition( position2 )
        sprite_beach2:setScale(scaleFactor)
        sprite_beach2:runAction(cc.RepeatForever:create(cc.Sequence:create(movecbeach2, reset2)))
        cclog("ddddd"..background_speed)

        local sprite_sky = cc.Sprite:createWithSpriteFrameName(res.sky_png)
        sprite_sky:setPosition( position1 )
        sprite_sky:setScale(scaleFactor)
        
        spritebatch:addChild(sprite_sky, -200)
        spritebatch:addChild(sprite_cloud, -100)
        spritebatch:addChild(sprite_sea, -50)
        spritebatch:addChild(sprite_beach, 0)
        spritebatch:addChild(sprite_cloud2, -100)
        spritebatch:addChild(sprite_sea2, -50)
        spritebatch:addChild(sprite_beach2, 0)
        local layerBg = cc.Layer:create()
        layerBg:addChild(spritebatch)
        
        return layerBg
    end

    return BackgroundLayer