
visibleSize = cc.Director:getInstance():getVisibleSize()
origin = cc.Director:getInstance():getVisibleOrigin()
sched = cc.Director:getInstance():getScheduler()
winSize = cc.Director:getInstance():getWinSize()

runningAction = 0

opponentDelay = 3   --����opponent�ļ��
minDuration = 5.0   --opponent��ʼ�ᴩ��Ļ����Сʱ��
maxDuration = 6.0
bgWidth = 1023
bgHeight = 273
playerSize = 62
ready = false    
jumping = false
background_speed = bgWidth/70
enemy_speed = 5
createEnemyFunc = 0
tapV = 300
systemGravity = -900
player = 0

bodyScale = 0.7
createOpponentSchid = -1
       
res = {
    helloBG_png = "helloBG.png",
    gameover_png = "gameover.png",
    
    PlayBG_png="PlayBG.png",
    runner_png =  "runner.png",
    runner_plist = "runner.plist",
    opponent1_plist = "opponent.plist",
    background_png = "bg0.png",
    sea_png = "bg2.png",
    cloud_png = "bg3.png",
    beach_png = "bg1.png",
    sky_png = "bg4.png",
    background_list = "bg0.plist"
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

        --���������
function createRandomNum(min,max)
        local minNum = min
        local maxNum = max
        local durationNum = maxNum-minNum
        math.randomseed(tostring(os.time()):reverse():sub(1, 6))
        local randomNum = minNum+math.random()*durationNum
        return randomNum
 end