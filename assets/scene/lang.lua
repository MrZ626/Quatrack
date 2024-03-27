local langList={
    zh="简体中文",
    zh_full="全简体中文",
    zh_trad="繁體中文",
    en="English",
    en_googled="English Language",
    fr="Français",
    es="　Español\n(Castellano)",
    eo="Esperanto",
    pt="Português",
    id="Bahasa Indonesia",
    ja="日本語",
    ja_kanji="日本語(漢字)",
    ko="한국어",
    zh_grass="简化瓷器",
    zh_grass2="英国人",
    symbol="?????",
    zh_classic="文言",
}
local languages={
    "Language  Langue  Lingua",
    "语言  言語  언어",
    "Idioma  Línguas  Sprache",
    "Язык  Γλώσσα  Bahasa",
}
local curLang=1

local scene={}

function scene.leave()
    saveSettings()
end

function scene.update(dt)
    curLang=curLang+dt*1.26
    if curLang>=#languages+1 then
        curLang=1
    end
end

function scene.draw()
    FONT.set(80)
    love.graphics.setColor(1,1,1,1-curLang%1*2)
    GC.mStr(languages[curLang-curLang%1],640,20)
    love.graphics.setColor(1,1,1,curLang%1*2)
    GC.mStr(languages[curLang-curLang%1+1] or languages[1],640,20)
end

local function _setLang(lid)
    SETTINGS.locale=lid
    TEXT:clear()
    TEXT:add{
        text=langList[lid],
        x=640,
        y=360,
        fontSize=100,
        style='appear',
        duration=1.6,
    }
    collectgarbage()
    --WIDGET.resize()
    if FIRSTLAUNCH then SCN.back() end
end

scene.widgetList={
    WIDGET.new{type='button_fill',x=270,y=210,w=330,h=100,fontSize=40, text=langList.en, color='R', sound_press='check',code=function() _setLang('en') end},
    WIDGET.new{type='button'     ,x=270,y=330,w=330,h=100,fontSize=40, text='',          color='F', sound_press='check'},
    WIDGET.new{type='button'     ,x=270,y=450,w=330,h=100,fontSize=35, text='',          color='O', sound_press='check'},
    WIDGET.new{type='button'     ,x=270,y=570,w=330,h=100,fontSize=35, text='',          color='Y', sound_press='check'},

    WIDGET.new{type='button'     ,x=640,y=210,w=330,h=100,fontSize=40, text='',          color='A', sound_press='check'},
    WIDGET.new{type='button'     ,x=640,y=330,w=330,h=100,fontSize=40, text=langList.symbol,color='K', sound_press='check',code=function() _setLang('symbol') end},
    WIDGET.new{type='button'     ,x=640,y=450,w=330,h=100,fontSize=40, text='',          color='G', sound_press='check'},
    WIDGET.new{type='button'     ,x=640,y=570,w=330,h=100,fontSize=40, text='',          color='J', sound_press='check'},

    WIDGET.new{type='button_fill',x=1000,y=210,w=330,h=100,fontSize=40,text=langList.zh, color='I', sound_press='check',code=function() _setLang('zh') end},
    WIDGET.new{type='button'     ,x=1000,y=330,w=330,h=100,fontSize=40,text='',          color='B', sound_press='check'},
    WIDGET.new{type='button'     ,x=1000,y=450,w=330,h=100,fontSize=40,text='',          color='P', sound_press='check'},

    WIDGET.new{type='button_fill',x=1000,y=570,w=330,h=100,sound_press='back',fontSize=60,text=CHAR.icon.back,code=WIDGET.c_backScn()},
}

return scene
