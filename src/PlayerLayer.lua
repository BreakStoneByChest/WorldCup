--create player
function CreatePlayer()
    local animation = CreatePlayerAnimation()
    local runningAction = cc.RepeatForever:create(cc.Animate:create(animation));
    runningAction:setTag(tags.tagOfRun)
    local sprite = cc.Sprite:createWithSpriteFrameName("runner0.png")
    --��������body
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
    sprite:getPhysicsBody():setEnable(false)
    sprite:setPosition(0,visibleSize.height/4+sprite:getContentSize().height/4)
    sprite:runAction(cc.MoveTo:create(2,cc.p(100,100)));
    sprite:runAction(runningAction)
    
    return sprite         
end