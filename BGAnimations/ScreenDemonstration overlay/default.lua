local t = Def.ActorFrame {};

	--Title
	t[#t+1] = LoadActor("title")..{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+34;draworder,1;zoom,1.5);
		OffCommand=cmd();
	};


	t[#t+1] = LoadActor( THEME:GetPathB("_Arcade","decorations")) ..{
		OnCommand=cmd(zoom,1);
		OffCommand=cmd();
		};
return t