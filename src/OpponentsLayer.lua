local OpponentCount = 3
local opponents = {}
opponents.stand = {}
opponents.laydown = {}

--create opponents
function CreateOpponents(layer)
    local function initOpponent()
    	for i = 1,OpponentCount do
    	    opponents.stand[i] = nil
            local animation = CreateOpponent1Animation()
            runningAction = cc.RepeatForever:create(cc.Animate:create(animation))
            local opponentStand = cc.Sprite:createWithSpriteFrameName("opp1.png")
            --opponentStand:setColor(cc.c3b(255,255,0))
            local body = cc.PhysicsBody:createBox(cc.size(opponentStand:getContentSize().width*0.15,opponentStand:getContentSize().height*0.3))
            body:getShape(0):setCategoryBitmask(1)
            body:getShape(0):setCollisionBitmask(math.pow(2,i))
            body:getShape(0):setContactTestBitmask(math.pow(2,i))
            --body:getShape(0):setGroup(8)
            cclog("opponentStand  bitmask is %d ",body:getShape(0):getContactTestBitmask())
            body:setGravityEnable(true)
            opponentStand:setPhysicsBody(body)
            opponentStand:setTag(tags.tagOfStand)
            opponentStand:getPhysicsBody():setEnable(true)
            opponentStand:runAction(runningAction)
            opponentStand:setPosition(visibleSize.width + 100,visibleSize.height/4+opponentStand:getContentSize().height/4)
            opponents.stand[i] = opponentStand
            layer:addChild(opponents.stand[i])
    	end
    	
        for i = 1,OpponentCount do
            opponents.laydown[i] = nil
            local animation = CreateOpponent1Animation()
--            runningAction = cc.RepeatForever:create(cc.Animate:create(animation))
            local opponentLayDown = cc.Sprite:createWithSpriteFrameName("opp1.png")
            local body = cc.PhysicsBody:createBox(cc.size(opponentLayDown:getContentSize().width*0.5,opponentLayDown:getContentSize().height*0.25))
            body:getShape(0):setCategoryBitmask(1)
            body:getShape(0):setCollisionBitmask(math.pow(2,i + OpponentCount))
            body:getShape(0):setContactTestBitmask(math.pow(2,i + OpponentCount))
            body:setPositionOffset(cc.p(0,-opponentLayDown:getContentSize().height*0.125))
            --body:getShape(0):setGroup(8)
            cclog("opponentLayDown bitmask is %d",body:getShape(0):getContactTestBitmask())
            body:setGravityEnable(true)
            opponentLayDown:setPhysicsBody(body)
            opponentLayDown:setTag(tags.tagOfLayDown)
            opponentLayDown:getPhysicsBody():setEnable(true)
--            runningAction:setTag(tags.tagOfRun)
--            opponentLayDown:runAction(runningAction)
            opponentLayDown:setPosition(visibleSize.width + 100,visibleSize.height/4+opponentLayDown:getContentSize().height/4)
            opponents.laydown[i] = opponentLayDown
            layer:addChild(opponents.laydown[i])
        end 
    end

    local function getOpponent(type)
        --        cclog("Opponent is %d", table.maxn(enemy))
        for i = 1,OpponentCount do

            if type == "L" then
                if opponents.laydown[i]:getPositionX() < -50 or opponents.laydown[i]:getPositionX() == visibleSize.width + 100 then
--                    opponents.laydown[i]:getPhysicsBody():setEnable(false)

                    opponents.laydown[i]:stopActionByTag(tags.tagOfLayDown)
                    local animation = CreateOpponent1Animation()
                    runningAction = cc.RepeatForever:create(cc.Animate:create(animation))
                    runningAction:setTag(tags.tagOfRun)
                    opponents.laydown[i]:runAction(runningAction)
                    return opponents.laydown[i]
                end
            elseif type == "S" then
                if opponents.stand[i]:getPositionX() < -50 or opponents.stand[i]:getPositionX() == visibleSize.width + 100 then
--                    opponents.stand[i]:getPhysicsBody():setEnable(false)
                    return opponents.stand[i]
                end
            end
        end
    end
    
    --crate opponent 
    local function createOpponentStand(character, actionDuration)
        cclog("stand")
        local opponentStand = character
        opponentStand:getPhysicsBody():setEnable(true)
        opponentStand:setPosition(visibleSize.width + 100,visibleSize.height/4+opponentStand:getContentSize().height/4)
        opponentStand:runAction(cc.MoveTo:create(actionDuration,cc.p(-100,visibleSize.height/4+opponentStand:getContentSize().height/4)))
    
    end

    local function createOpponentLaydown(character, actionDuration)
        cclog("Laydown")
        local opponentLaydown = character
        opponentLaydown:getPhysicsBody():setEnable(true)
        opponentLaydown:setPosition(visibleSize.width + 100,visibleSize.height/4+opponentLaydown:getContentSize().height/4)
        local function moveToMiddle()
        local len = math.random(-20,20)
        cclog(len)
            opponentLaydown:runAction(cc.MoveTo:create(actionDuration/2,cc.p(visibleSize.width /1.5+len,visibleSize.height/4+opponentLaydown:getContentSize().height/4)))
        end
        local function moveToLeft()
            opponentLaydown:stopActionByTag(tags.tagOfRun)
            LayDownAction = cc.RepeatForever:create(cc.Animate:create(CreateLayDownAnimation()))
            LayDownAction:setTag(tags.tagOfLayDown)
            opponentLaydown:runAction(LayDownAction)
            opponentLaydown:runAction(cc.MoveTo:create(actionDuration/3.5,cc.p(-100,visibleSize.height/4+opponentLaydown:getContentSize().height/4)))
        end
        local moveToMiddle = cc.CallFunc:create(moveToMiddle)
        local delay = cc.DelayTime:create(actionDuration/2)
        local moveToLeft = cc.CallFunc:create(moveToLeft)
        opponentLaydown:runAction(cc.Sequence:create(moveToMiddle,delay,moveToLeft,delay))
    end

    
    local function createOpponent()
        local actionDuration = createRandomNum(minDuration,maxDuration)
        p = math.random()*10
        if p>5 then
            local type = "L"
            local opponent = getOpponent(type)
            createOpponentLaydown(opponent, actionDuration)
        else
            local type = "S"
            local opponent = getOpponent(type)
            createOpponentStand(opponent, actionDuration)
        end
        
    end

    
    initOpponent()
    createOpponentSchid = sched:scheduleScriptFunc(createOpponent,opponentDelay,false)
    cclog("createOpponentSchid is %d",createOpponentSchid)
   -- sched:scheduleScriptFunc(manage,1,false)
return layer
end