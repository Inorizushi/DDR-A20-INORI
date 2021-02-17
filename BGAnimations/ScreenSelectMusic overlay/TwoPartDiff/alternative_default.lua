local player = ...

--[[
I know what you're thinking. "Another one of these stupid item_scrollers? Can't you write
your own scroller?"
I was going to, but songs can have infinite EDIT difficulties. So I decided "fuck it,
I'll just use the item_scroller again and save myself the trouble of figuring out how
to pool shit"
Yes I know I could have made it so the screen displays on top, yes I know I'm probably
going to have to rewrite this shit to be more efficient later anyway since these item scrollers
have massive overhead
]]
local item_mt= {
  __index= {
	-- create_actors must return an actor.  The name field is a convenience.
	create_actors= function(self, params)
	  self.name= params.name
		return Def.ActorFrame{		
			InitCommand= function(subself)
				-- Setting self.container to point to the actor gives a convenient
				-- handle for manipulating the actor.
		  		self.container= subself
			end;
			Def.Sprite{
				Texture="dummy";
			};
			--[[Def.BitmapText{
				Name= "text",
				Font= "Common Normal",
				InitCommand=cmd(y,-2);
			};]]
		};
	end,
	-- item_index is the index in the list, ranging from 1 to num_items.
	-- is_focus is only useful if the disable_wrapping flag in the groupScroller is
	-- set to false.
	transform= function(self, item_index, num_items, is_focus)
		local offsetFromCenter = item_index-math.floor(numWheelItems/2)
		--PrimeWheel(self.container,offsetFromCenter,item_index,numWheelItems)
		--self.container:GetChild("bright"):visible(is_focus)
		--self.container:visible(item_index>1 and item_index<num_items)
		self.container:stoptweening();
		self.container:xy(-math.abs(offsetFromCenter)*10,offsetFromCenter*100)
		--self.container:decelerate(.1):x((offsetFromCenter*30)):y( offsetFromCenter*70 ):z(1-math.abs(offsetFromCenter))
		
	end,
	-- info is one entry in the info set that is passed to the groupScroller.
	set= function(self, info)
		--self.container:GetChild("text"):settext(string.gsub(info,"^%d%d? ?%- ?", ""))
		--self.container:GetChild("text"):settext("Aaaaaaaaaaaaaaaaaaaaaaaaa");
	end
}}
local difficultyScroller = setmetatable({disable_wrapping= true}, item_scroller_mt)

local function inputs(event)
	local pn= event.PlayerNumber
	local button = event.button
	-- If the PlayerNumber isn't set, the button isn't mapped.  Ignore it.
	--Also we only want it to activate when they're NOT selecting the difficulty.
	if not pn then return end
	-- If it's a release, ignore it.
	if event.type == "InputEventType_Release" then return end
	
	SOUND:PlayOnce(THEME:GetPathS("_MusicWheel","Change"),true)
	if button == "Up" or button == "Left" then
		difficultyScroller:scroll_by_amount(-1);
	elseif button == "Down" or button == "Right" then
		difficultyScroller:scroll_by_amount(1);
	elseif button == "Select" then
		--SCREENMAN:SystemMessage("column ".. songScroller:get_ddra_focus().. " | "..songScroller:get_current_index().. "/"..#songScroller.info_set)
	else
		SCREENMAN:SystemMessage("Unknown button: "..button)
	end;

end;

local f =  Def.ActorFrame{
	OnCommand=function(self)
		
	end;
};
--Allocate 7 in case of EDIT difficulties...
f[#f+1] = difficultyScroller:create_actors("foo", 7, item_mt, SCREEN_CENTER_X, SCREEN_CENTER_Y);

return f;