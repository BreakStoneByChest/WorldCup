require"src/GameContants"
require"src/PlayerLayer" 
require"src/OpponentsLayer"
require"src/StatusLayer"    
require"src/FailedLayer" 
require"src/BackGroundLayer"
require"src/GameLogic"
 function  createPlayerScene()
        layerBg, land_1, land_2 = BackgroundLayer()

        
        player = CreatePlayer()
        --player:setPhysicsBody(cc.PhysicsBody:createCircle(player:getContentSize().width/2))
        player:getPhysicsBody():setEnable(true)
        --player:getPhyi
        

        local sc = cc.Scene:createWithPhysics()
        sc:getPhysicsWorld():setGravity(cc.p(0, systemGravity))
        sc:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
       --  sc:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
        --create EdgeBox        
        local ground = cc.PhysicsBody:createEdgeBox(visibleSize, cc.PHYSICSBODY_MATERIAL_DEFAULT, 3)
        ground:setDynamic(false)
        local edgeNode = cc.Node:create()
        edgeNode:setPosition(visibleSize.width/2,100 - playerSize / 2 - visibleSize.height/2)
        edgeNode:setPhysicsBody(ground)

        --edgeNode:getPhysicsBody():setCollisionBitmask(10)
        sc:addChild(edgeNode)
        
        sc:addChild(layerBg)
        sc:addChild(logicLayer())
        sc:addChild(start_button)
        sc:addChild(StatusLayer.create());
        cclog("is ok")
        
        -- run

        
        return sc
    end
    