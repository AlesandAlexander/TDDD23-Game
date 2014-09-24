--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:f2729ff18cc24245d1b84401ff78b2cb:384ad8403e8c01e7678a4a50ad385073:c58bfa7cdde0932d951cc27922a27c19$
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
            x=250,
            y=70,
            width=74,
            height=56,

            sourceX = 55,
            sourceY = 18,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 1
            x=558,
            y=64,
            width=64,
            height=50,

            sourceX = 33,
            sourceY = 24,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 2
            x=326,
            y=70,
            width=74,
            height=56,

            sourceX = 0,
            sourceY = 18,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 3
            x=490,
            y=64,
            width=66,
            height=60,

            sourceX = 64,
            sourceY = 14,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 4
            x=352,
            y=2,
            width=100,
            height=66,

            sourceX = 26,
            sourceY = 5,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 5
            x=126,
            y=2,
            width=122,
            height=74,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 6
            x=402,
            y=70,
            width=86,
            height=54,

            sourceX = 36,
            sourceY = 9,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 7
            x=50,
            y=78,
            width=46,
            height=42,

            sourceX = 76,
            sourceY = 32,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 8
            x=610,
            y=2,
            width=14,
            height=40,

            sourceX = 108,
            sourceY = 20,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 9
            x=2,
            y=122,
            width=1,
            height=1,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 130,
            sourceHeight = 74
        },
                {
            -- 10
            x=98,
            y=78,
            width=14,
            height=40,

            sourceX = 8,
            sourceY = 20,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 11
            x=2,
            y=78,
            width=46,
            height=42,

            sourceX = 8,
            sourceY = 19,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 12
            x=454,
            y=2,
            width=86,
            height=54,

            sourceX = 7,
            sourceY = 9,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 13
            x=2,
            y=2,
            width=122,
            height=74,

            sourceX = 8,
            sourceY = 0,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 14
            x=250,
            y=2,
            width=100,
            height=66,

            sourceX = 3,
            sourceY = 5,
            sourceWidth = 130,
            sourceHeight = 74
        },
        {
            -- 15
            x=542,
            y=2,
            width=66,
            height=60,

            sourceX = 0,
            sourceY = 14,
            sourceWidth = 130,
            sourceHeight = 74
        },

    },
    
    sheetContentWidth = 627,
    sheetContentHeight = 128
}

SheetInfo.frameIndex =
{

    ["0"] = 1,
    ["1"] = 2,
    ["10"] = 3,
    ["11"] = 4,
    ["12"] = 5,
    ["13"] = 6,
    ["14"] = 7,
    ["15"] = 8,
    ["2"] = 9,
    ["3"] = 10,
    ["4"] = 11,
    ["5"] = 12,
    ["6"] = 13,
    ["7"] = 14,
    ["8"] = 15,
    ["9"] = 16,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
