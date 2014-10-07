--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:cae5353d39e15256f1946f7d6bf90c89:77cfe82a414f341b4193eb989a6c787c:9f6b32d45b4a9407899d793eec0a3350$
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
            x=72,
            y=2,
            width=66,
            height=100,

            sourceX = 15,
            sourceY = 0,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- 2
            x=140,
            y=2,
            width=66,
            height=100,

            sourceX = 15,
            sourceY = 0,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- 3
            x=2,
            y=2,
            width=68,
            height=100,

            sourceX = 13,
            sourceY = 0,
            sourceWidth = 100,
            sourceHeight = 100
        },
    },
    
    sheetContentWidth = 208,
    sheetContentHeight = 104
}

SheetInfo.frameIndex =
{

    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
