--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:706076e49f77deb797553773e6439184:8b469eac1b87478ce8e2eae6bb5e7b4d:ab53c0937f41bb2487347d8c04ab9d24$
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
            -- 1
            x=452,
            y=2,
            width=46,
            height=42,

            sourceX = 245,
            sourceY = 38,
            sourceWidth = 370,
            sourceHeight = 80
        },
        {
            -- 2
            x=2,
            y=2,
            width=122,
            height=74,

            sourceX = 245,
            sourceY = 5,
            sourceWidth = 370,
            sourceHeight = 80
        },
        {
            -- 3
            x=250,
            y=2,
            width=66,
            height=60,

            sourceX = 220,
            sourceY = 19,
            sourceWidth = 370,
            sourceHeight = 80
        },
        {
            -- 4
            x=386,
            y=2,
            width=64,
            height=50,

            sourceX = 161,
            sourceY = 29,
            sourceWidth = 370,
            sourceHeight = 80
        },
        {
            -- 5
            x=318,
            y=2,
            width=66,
            height=60,

            sourceX = 84,
            sourceY = 19,
            sourceWidth = 370,
            sourceHeight = 80
        },
        {
            -- 6
            x=126,
            y=2,
            width=122,
            height=74,

            sourceX = 4,
            sourceY = 4,
            sourceWidth = 370,
            sourceHeight = 80
        },
        {
            -- 7
            x=452,
            y=46,
            width=46,
            height=42,

            sourceX = 80,
            sourceY = 37,
            sourceWidth = 370,
            sourceHeight = 80
        },
        {
            -- 8
            x=2,
            y=78,
            width=1,
            height=1,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 370,
            sourceHeight = 80
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
