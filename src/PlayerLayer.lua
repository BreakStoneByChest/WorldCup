   require"src/GameContants"
   --create animation
    function CreateAnimation()
        cc.SpriteFrameCache:getInstance():addSpriteFrames(res.runner_plist);
        local animation = cc.Animation:create()
        for i = 1,8 do
            local str = "runner".. (i-1) .. ".png"
           -- cclog(str)
            local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(str)
            animation:addSpriteFrame(frame)
            --   cclog(frame)
        end
        animation:setDelayPerUnit(2.8 / 40.0)
        animation:setRestoreOriginalFrame(true)
        return animation
    end
    --create player
    function CreatePlayer()
        local animation = CreateAnimation()
        local runningAction = cc.RepeatForever:create(cc.Animate:create(animation));
        local sprite = cc.Sprite:createWithSpriteFrameName("runner0.png")
        --加入物理body
        local body = cc.PhysicsBody:createBox(cc.size(sprite:getContentSize().width*0.3,sprite:getContentSize().width*0.3))
        cclog(bitmasks.bitmaskOfStand)
        --body:getShape(0):setCategoryBitmask(bitmasks.bitmaskOfStand)
        --body:getShape(0):setCollisionBitmask(bitmasks.bitmaskOfStand)
        --body:getShape(0):setContactTestBitmask(1)
        --body:getShape(0):setGroup(8)
       -- body:setMass(1.0)
      
        
        sprite:setPhysicsBody(body)
        sprite:setTag(tags.tagOfPlayer)
        sprite:getPhysicsBody():setContactTestBitmask(1)
                cclog("p col is %d",body:getShape(0):getContactTestBitmask())
        sprite:setPosition(0,100)
        sprite:setAnchorPoint(0,0.5)
        sprite:runAction(cc.MoveTo:create(2,cc.p(100,100)));
        sprite:runAction(runningAction)
        return sprite         
    end