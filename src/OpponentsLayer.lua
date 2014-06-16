require"src/GameContants" 
   --create opponents
    function CreateOpponents(layer)
        
        --crate opponent 
        local function createOpponentStand(actionDuration)
        cclog("stand")
            local opponents = cc.SpriteBatchNode:create(res.runner_png);
            opponents:setScaleX(-1)
            local animation = CreateAnimation()
            runningAction = cc.RepeatForever:create(cc.Animate:create(animation))
            local opponentStand = cc.Sprite:createWithSpriteFrameName("runner0.png")
            
             local body = cc.PhysicsBody:createCircle(opponentStand:getContentSize().width/2* bodyScale)
            --body:getShape(0):setCategoryBitmask(bitmasks.bitmaskOfStand)
           -- body:getShape(0):setCollisionBitmask(bitmasks.bitmaskOfStand)
            body:getShape(0):setContactTestBitmask(1)
            --body:getShape(0):setGroup(8)
            cclog("s col is %d",body:getShape(0):getContactTestBitmask())
            body:setGravityEnable(false)
            opponentStand:setPhysicsBody(body)
            opponentStand:setTag(tags.tagOfStand)
            opponentStand:setPosition(-visibleSize.width,100)
            opponents:addChild(opponentStand)
            opponentStand:runAction(cc.MoveTo:create(actionDuration,cc.p(100,100)))
            opponentStand:runAction(runningAction)   
            table.insert(enemy,1,opponentStand)
          --   enemy          
            return opponents
        end

        local function createOpponentLaydown(actionDuration)
                cclog("Laydown")
            local opponents = cc.SpriteBatchNode:create(res.runner_png);
            opponents:setScaleX(-1)
            opponents:setRotation(-90)
            local animation = CreateAnimation()
            runningAction = cc.RepeatForever:create(cc.Animate:create(animation))
            local opponentLaydown = cc.Sprite:createWithSpriteFrameName("runner0.png")
            
             local body = cc.PhysicsBody:createCircle(opponentLaydown:getContentSize().width/2*bodyScale)
              -- body:getShape(0):setCategoryBitmask(bitmasks.bitmaskOfStand)
                -- body:getShape(0):setCollisionBitmask(bitmasks.bitmaskOfStand)
                 body:getShape(0):setContactTestBitmask(1)
                 --body:getShape(0):setGroup(8)
                 cclog(" l col is %d",body:getShape(0):getContactTestBitmask())
                body:setGravityEnable(false)
             opponentLaydown:setPhysicsBody(body)
            opponentLaydown:setTag(tags.tagOfLayDown)
            
            opponentLaydown:setPosition(-visibleSize.width,100)
            opponents:addChild(opponentLaydown)
            opponentLaydown:runAction(cc.MoveTo:create(actionDuration,cc.p(100,100)))
            opponentLaydown:runAction(runningAction)
            
            table.insert(enemy,1,opponentLaydown)
            
            return opponents
        end

        
        local function createOpponent()
            local opponent = {}
            opponent.character = nil
            opponent.charID = nil
            local actDuration = createRandomNum(2.0,4.0)
            local actionDuration = createRandomNum(minDuration,maxDuration)
            math.randomseed(tostring(os.time()):reverse():sub(1, 6))
            p = math.random()*10
            if p>6 then
                opponent.character= createOpponentLaydown(actionDuration)
                opponent.ID = "L"
            else
                opponent.character = createOpponentStand(actionDuration)  
                opponent.ID = "S"
            end
            layer:addChild(opponent.character)
            
        end
        
        local function manage()
             cclog("enemies is %d", table.maxn(enemy))
             for i,enemy1 in pairs(enemy) do
                 local posx,posy = enemy1:getPosition()
                 local place = cc.rect(origin.x,origin.y,visibleSize.width,visibleSize.height)
       
                 if not cc.rectContainsPoint(place,cc.p(posx,posy)) then
                 cclog("removeFromParent")
                 enemy1:removeFromParent(true)
                 enemy[i]= nil
                 end
             end
        end
        
        
        createOpponentSchid = sched:scheduleScriptFunc(createOpponent,1,false)
        cclog("createOpponentSchid is %d",createOpponentSchid)
       -- sched:scheduleScriptFunc(manage,1,false)
    return layer
    end