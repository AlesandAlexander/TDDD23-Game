--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:7d48d6afdd60f69aa3abb606398f16a8:affe904e2e07bd42ed0db4c3517b6bac:a79fc0cc85b94ba401fdd08d20e27fa0$
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
            x=2,
            y=2,
            width=98,
            height=198,

            sourceX = 52,
            sourceY = 0,
            sourceWidth = 200,
            sourceHeight = 200
        },
        {
            -- 2
            x=2,
            y=202,
            width=94,
            height=188,

            sourceX = 52,
            sourceY = 2,
            sourceWidth = 200,
            sourceHeight = 200
        },
        {
            -- 3
            x=2,
            y=392,
            width=90,
            height=168,

            sourceX = 51,
            sourceY = 15,
            sourceWidth = 200,
            sourceHeight = 200
        },
    },
    
    sheetContentWidth = 102,
    sheetContentHeight = 562
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
