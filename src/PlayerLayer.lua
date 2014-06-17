   --create animation
    function CreateAnimation()
        cc.SpriteFrameCache:getInstance():addSpriteFrames(res.runner_plist);
        local animation = cc.Animation:create()
        for i = 1,4 do
            local str = "runner".. (i-1) .. ".png"
           -- cclog(str)
            local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(str)
            animation:addSpriteFrame(frame)
            --   cclog(frame)
        end
        animation:setDelayPerUnit(1.0 / 30.0)
        animation:setRestoreOriginalFrame(true)
        return animation
    end
    
function CreateJump()
    cc.SpriteFrameCache:getInstance():addSpriteFrames(res.runner_plist);
    local animation = cc.Animation:create()
    local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame("jump.png")
    animation:addSpriteFrame(frame)
    local frame2 = cc.SpriteFrameCache:getInstance():getSpriteFrame("fall.png")
    animation:addSpriteFrame(frame2)
    animation:setDelayPerUnit(1/1.4)
    animation:setRestoreOriginalFrame(true)
    return animation
end

    --create player
    function CreatePlayer()
        local animation = CreateAnimation()
        local runningAction = cc.RepeatForever:create(cc.Animate:create(animation));
        runningAction:setTag(tags.tagOfRun)
        local sprite = cc.Sprite:createWithSpriteFrameName("runner0.png")
        --加入物理body
        local body = cc.PhysicsBody:createBox(cc.size(sprite:getContentSize().width*0.5,sprite:getContentSize().height*0.5))
        cclog(bitmasks.bitmaskOfPlayer)
        body:getShape(0):setCategoryBitmask(bitmasks.bitmaskOfPlayer)
        body:getShape(0):setCollisionBitmask(bitmasks.bitmaskOfPlayer)
        body:getShape(0):setContactTestBitmask(bitmasks.bitmaskOfPlayer)
        --body:getShape(0):setGroup(8)
       -- body:setMass(1.0)
      
        body:setGravityEnable(true)        
        sprite:setPhysicsBody(body)
        sprite:setTag(tags.tagOfPlayer)
        sprite:getPhysicsBody():setContactTestBitmask(1)
                cclog("p col is %d",body:getShape(0):getContactTestBitmask())
        sprite:setPosition(0,visibleSize.height/4+sprite:getContentSize().height/4)
        sprite:runAction(cc.MoveTo:create(2,cc.p(100,100)));
        sprite:runAction(runningAction)
        return sprite         
    end