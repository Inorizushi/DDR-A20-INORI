local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	Def.Quad{
		InitCommand=function(s) s:FullScreen():diffuse(Alpha(Color.Black,0)) end,
	};
	LoadActor(THEME:GetPathS("","_swoosh in.ogg"))..{
		OnCommand=function(s) s:sleep(0.2):queuecommand("Play") end,
		PlayCommand=function(s) s:play() end,
	};
};

return t;
