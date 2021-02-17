return LoadActor("_doors.lua")..{
	OnCommand=function(s) 
		s:queuecommand("AnimOn"):sleep(2)
	end,
  };
  