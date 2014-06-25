--create animation
function CreatePlayerAnimation()
    cc.SpriteFrameCache:getInstance():addSpriteFrames(res.runner_plist);
    local animation = cc.Animation:create()
    for i = 1,4 do
        local str = "runner".. (i-1) .. ".png"
        -- cclog(str)
        local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(str)
        animation:addSpriteFrame(frame)
        --   cclog(frame)
    end
    animation:setDelayPerUnit(1.0 /10.0)
    animation:setRestoreOriginalFrame(true)
    return animation
end

function CreateJumpAnimation()
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

function CreateOpponent1Animation()
    cc.SpriteFrameCache:getInstance():addSpriteFrames(res.opponent1_plist)
    local animation = cc.Animation:create()
    for i = 1,2 do
        local str = "opp".. i .. ".png"
        -- cclog(str)
        local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(str)
        animation:addSpriteFrame(frame)
        --   cclog(frame)
    end
    animation:setDelayPerUnit(1.0 /10.0)
    animation:setRestoreOriginalFrame(true)
    return animation
end

function CreateLayDownAnimation()
    cc.SpriteFrameCache:getInstance():addSpriteFrames(res.opponent1_plist)
    local animation = cc.Animation:create()
    local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame("oppchan.png")
    animation:addSpriteFrame(frame)
    animation:setDelayPerUnit(1.0)
    animation:setRestoreOriginalFrame(true)
    return animation
end