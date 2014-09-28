local pack = {}
local numEntries = 10
function pack:new()
   local scoreManager = {}
   local filename = "scorefile.txt"

   local function compare( a, b )
      return a > b
   end


   local function gethighScore()
      local highscoreList = {}
      local path = system.pathForFile( "highscore.txt", system.DocumentsDirectory )
      local file = io.open( path, "r" )
      if (file ~= nil) then
          while true do
            local score = file:read( "*n" ) 
            if score == nil then break end
            table.insert( highscoreList, score )
         end
         io.close( file )
      end
      file = nil
      table.sort(highscoreList, compare )
      while #highscoreList > numEntries do 
         table.remove( highscoreList, #highscoreList )
      end
      return highscoreList
   end

   function scoreManager:saveScore(score)

      local highscoreList = gethighScore()

      for i=1,numEntries do
         if i > #highscoreList or score > highscoreList[i] then
            table.insert( highscoreList, i, score )
            break
         end
      end

      while #highscoreList > numEntries do 
         table.remove( highscoreList, #highscoreList )
      end

      local saveText = ""
      for i=1,#highscoreList do
         saveText = saveText .. highscoreList[i] .. "\n"
      end

      local path = system.pathForFile( "highscore.txt", system.DocumentsDirectory )
      local file = io.open( path, "w" )
      file:write( saveText )
      io.close( file )
      file = nil

   end

   function scoreManager:loadScore()
      return gethighScore()
   end

   return scoreManager
end

return pack