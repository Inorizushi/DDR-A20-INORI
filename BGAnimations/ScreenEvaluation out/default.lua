local t = Def.ActorFrame {};
	t[#t+1] =  Def.ActorFrame {
		OnCommand=cmd(sleep,1);
		LoadActor("../_evalOut")..{
			OffCommand=cmd(play);
		};
}

return t;