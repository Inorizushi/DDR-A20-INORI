local mainMaxWidth = 228; -- zoom w/subtitle is 0.75 (multiply by 1.25)
local subMaxWidth = 420; -- zoom is 0.6 (multiply zoom,1 value by 1.4)
local artistMaxWidth = 300/0.8;

--[[
-- The old (cmd(blah))(Actor) syntax is hard to read.
-- This is longer, but much easier to read. - Colby
--]]
function TextBannerAfterSet(self,param)
	local Title = self:GetChild("Title")
	local Subtitle = self:GetChild("Subtitle")
	local Artist = self:GetChild("Artist")
	
	if GAMESTATE:IsCourseMode() then
	
			Title:maxwidth(500)
			Title:zoom(1)
			Title:strokecolor(color("#000000"))
			
			-- hide so that the game skips drawing.
			Subtitle:visible(false)

			Artist:zoom(0.66)
			Artist:maxwidth(artistMaxWidth)
			Artist:y(8)
	else
		if Subtitle:GetText() == "" then
			Title:maxwidth(mainMaxWidth)
			Title:zoom(1)
			Title:strokecolor(color("#000000"))
			
			-- hide so that the game skips drawing.
			Subtitle:visible(false)

			Artist:zoom(0.66)
			Artist:maxwidth(artistMaxWidth)
			Artist:y(8)
		else
			Title:maxwidth(mainMaxWidth*1.25)
			Title:zoom(0.75)
			Title:strokecolor(color("#000000"))
			
			-- subtitle below title
			Subtitle:visible(false)
			Subtitle:zoom(1)
			Subtitle:y(0)
			Subtitle:maxwidth(subMaxWidth)
			
			Artist:zoom(0.66)
			Artist:maxwidth(artistMaxWidth)
			Artist:y(10)
		end
	end
end
