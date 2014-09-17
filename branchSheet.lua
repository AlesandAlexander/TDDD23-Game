--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a02532ffed77600a0ff835500a617d0d:ff54539fe804419254277b54e283bb60:c4ac6a637758d88d82c8ffc4d9ff9b20$
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
            height=50,

            sourceX = 33,
            sourceY = 24,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 1
            x=250,
            y=2,
            width=66,
            height=60,

            sourceX = 64,
            sourceY = 14,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 2
            x=2,
            y=2,
            width=122,
            height=74,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 3
            x=452,
            y=2,
            width=46,
            height=42,

            sourceX = 76,
            sourceY = 32,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 4
            x=2,
            y=78,
            width=1,
            height=1,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 5
            x=452,
            y=46,
            width=46,
            height=42,

            sourceX = 8,
            sourceY = 19,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 6
            x=126,
            y=2,
            width=122,
            height=74,

            sourceX = 8,
            sourceY = 0,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 7
            x=318,
            y=2,
            width=66,
            height=60,

            sourceX = 0,
            sourceY = 14,
            sourceWidth = 130,
            sourceHeight = 74
        },
    },
    
    sheetContentWidth = 500,
    sheetContentHeight = 90
}

SheetInfo.frameIndex =
{

    ["0"] = 1,
    ["1"] = 2,
    ["2"] = 3,
    ["3"] = 4,
    ["4"] = 5,
    ["5"] = 6,
    ["6"] = 7,
    ["7"] = 8,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
