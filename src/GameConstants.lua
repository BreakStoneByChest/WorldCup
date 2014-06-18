
visibleSize = cc.Director:getInstance():getVisibleSize()
origin = cc.Director:getInstance():getVisibleOrigin()
sched = cc.Director:getInstance():getScheduler()
winSize = cc.Director:getInstance():getWinSize()

runningAction = 0

opponentDelay = 3   --产生opponent的间隔
minDuration = 5.0   --opponent初始横穿屏幕的最小时间
maxDuration = 6.0
bgWidth = 4252
bgHeight = 1134
playerSize = 62
ready = false    
jumping = false
background_speed = bgWidth/100
enemy_speed = 5
createEnemyFunc = 0
tapV = 360
systemGravity = -900
player = 0

bodyScale = 0.7
createOpponentSchid = -1
       
res = {
    helloBG_png = "helloBG.png",
    PlayBG_png="PlayBG.png",
    runner_png =  "runner.png",
    runner_plist = "runner.plist",
    opponent1_plist = "opponent.plist",
    background_png = "background.png",
    sea_png = "sea.png",
    cloud_png = "cloud.png",
    beach_png = "beach.png",
    background_list = "background.plist"
    
}

tags = {
        tagOfPlayer = 4,
        tagOfStand =5,
        tagOfLayDown = 6,
        tagOfLand = 7,
        tagOfOneClick = 8,
        tagOfRun = 9,
        tagOfJump = 10
        }
        
bitmasks = {
        bitmaskOfPlayer = 1023,
        bitmaskOfStand =3,
        bitmaskOfLayDown =3,
        bitmaskOfLand =255
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