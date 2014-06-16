require"src/GameContants"
require"src/PlayerScene"


-- cclog
cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
end

local gameListener = nil
local landListener = nil

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    cc.FileUtils:getInstance():addSearchResolutionsOrder("src");
    cc.FileUtils:getInstance():addSearchResolutionsOrder("res");
    cc.FileUtils:getInstance():addSearchResolutionsOrder("res/fonts");
    local schedulerID = 0
    --support debug
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) or 
        (cc.PLATFORM_OS_ANDROID == targetPlatform) or (cc.PLATFORM_OS_WINDOWS == targetPlatform) or
        (cc.PLATFORM_OS_MAC == targetPlatform) then
        cclog("result is ")
        --require('debugger')()

    end
    ---------------

    
--    function onland()
--        jumping = false
--    end
    
     -- play background music, preload effect

    -- uncomment below for the BlackBerry version
    local bgMusicPath = nil 
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("res/background.caf")
    else
        bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("res/background.mp3")
    end
    cc.SimpleAudioEngine:getInstance():playMusic(bgMusicPath, true)
    local effectPath = cc.FileUtils:getInstance():fullPathForFilename("effect1.wav")
    cc.SimpleAudioEngine:getInstance():preloadEffect(effectPath)

    -- run
    local sceneGame = createPlayerScene()
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(sceneGame)
    else
        cc.Director:getInstance():runWithScene(sceneGame)
    end
    
end


xpcall(main, __G__TRACKBACK__)
