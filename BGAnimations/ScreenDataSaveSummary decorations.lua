local t = LoadFallbackB();

t[#t+1] = Def.ActorFrame {
  LoadActor(THEME:GetPathS("","Profile_start"))..{
		OnCommand=cmd(play);
	};

};

t[#t+1] = Def.ActorFrame {
  LoadActor(THEME:GetPathS("","Profile_In"))..{
		OnCommand=cmd(play);
	};
};

t[#t+1] = LoadActor( THEME:GetPathS("","Profile_start") )..{
			OffCommand=cmd(play);
		};

t[#t+1] = LoadActor("_doors.lua")..{
	OnCommand=function(s) 
		s:queuecommand("AnimOn"):queuecommand("Show")
	end,
  };
return t
