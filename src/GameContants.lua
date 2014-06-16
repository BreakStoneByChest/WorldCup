
visibleSize = cc.Director:getInstance():getVisibleSize()
origin = cc.Director:getInstance():getVisibleOrigin()
sched = cc.Director:getInstance():getScheduler()

minDuration = 2.0
maxDuration = 4.0
bgSize = 7654
playerSize = 62
ready = false    
jumping = false
background_speed = 10
enemy_speed = 5
createEnemyFunc = 0
tapV = 310
systemGravity = -900
runningAction = 0
player = 0
enemies = 0
enemy = {}
bodyScale = 0.7
createOpponentSchid = -1
       
res = {
    helloBG_png = "helloBG.png",
    start_n_png = "start_n.png",
    start_s_png="start_s.png",
    PlayBG_png="Beijing.jpg",
    runner_png =  "running.png",
    runner_plist = "running.plist"}

g_resources = {
    --image
    res.helloBG_png,
    res.start_n_png,
    res.start_s_png,
    res.PlayBG_png,
    res.runner_png,
    res.runner_plist,
    res.runner_png
}

tags = {
        tagOfPlayer = 4,
        tagOfStand =5,
        tagOfLayDown = 6,
        tagOfLand = 7
        }
        
bitmasks = {
        bitmaskOfPlayer = 3,
        bitmaskOfStand =3,
        bitmaskOfLayDown =3
    } 

        --产生随机数
function createRandomNum(min,max)
        local minNum = min
        local maxNum = max
        local durationNum = maxNum-minNum
        math.randomseed(tostring(os.time()):reverse():sub(1, 6))
        local randomNum = minNum+math.random()*durationNum
        return randomNum
 end