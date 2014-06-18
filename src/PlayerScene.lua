
PlayerScene = PlayerScene or {}
 function  PlayerScene.create()
        start_button = cc.LabelTTF:create("Tap to Start", "Abduction.ttf", 20)
        start_button:setPosition(cc.p(visibleSize.width/2,visibleSize.height/2))
        start_button:setColor(cc.c3b(0,0,0))
        layerBg = BackgroundLayer.create()

        
        player = CreatePlayer()
        --player:setPhysicsBody(cc.PhysicsBody:createCircle(player:getContentSize().width/2))
        player:getPhysicsBody():setEnable(true)
        --player:getPhyi
        

        local sc = cc.Scene:createWithPhysics()
        sc:getPhysicsWorld():setGravity(cc.p(0, systemGravity))
        sc:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
       --  sc:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
        --create EdgeBox        
        local ground = cc.PhysicsBody:createEdgeBox(cc.size(visibleSize.width * 3,visibleSize.height/4), cc.PHYSICSBODY_MATERIAL_DEFAULT, 7)
        ground:setDynamic(false)
        local edgeNode = cc.Node:create()
        edgeNode:setPosition(visibleSize.width / 2, visibleSize.height/8)
        ground:getShape(0):setRestitution(0);
        ground:getShape(0):setFriction(0);
        
        edgeNode:setPhysicsBody(ground)
        edgeNode:getPhysicsBody():setContactTestBitmask(1)
        edgeNode:setTag(tags.tagOfLand)
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
    
    return PlayerScene
