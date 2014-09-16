--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:63f1080b5d412bce237da72e640093a4:cf5dcd4d25fcb72e9f7ae101f9967ae9:57ed744976abb61d4f202c2b9ba7c55b$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- 0
            x=386,
            y=2,
            width=64,
            height=50
        },
        {
            -- 1
            x=250,
            y=2,
            width=66,
            height=60
        },
        {
            -- 2
            x=2,
            y=2,
            width=122,
            height=74
        },
        {
            -- 3
            x=452,
            y=2,
            width=46,
            height=42
        },
        {
            -- 4
            x=2,
            y=78,
            width=1,
            height=1
        },
        {
            -- 5
            x=452,
            y=46,
            width=46,
            height=42
        },
        {
            -- 6
            x=126,
            y=2,
            width=122,
            height=74
        },
        {
            -- 7
            x=318,
            y=2,
            width=66,
            height=60
        },
    },
    
    sheetContentWidth = 500,
    sheetContentHeight = 90
}

SheetInfo.frameIndex =
{

    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
