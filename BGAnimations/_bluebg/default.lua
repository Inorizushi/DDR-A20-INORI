local t = Def.ActorFrame {};

t[#t+1] = LoadActor( "../ScreenWithMenuElements background/entry_bga" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomto,SCREEN_WIDTH*1.01,SCREEN_HEIGHT*1.01);
	
}

t[#t+1] = LoadActor("black_stereo")..{
	InitCommand = cmd(Center;diffusealpha,0.6);
}

--Those Weird Curved Things
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(CenterX);
	LoadActor(THEME:GetPathB("","_door/bluebg (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_TOP+99;zoom,1.5);
	};
	LoadActor(THEME:GetPathB("","_door/bluebg (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_BOTTOM-99;zoomy,-1;zoom,-1.5);
	};
}
--More Of THose Weird Curved Things
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(CenterX);
	LoadActor(THEME:GetPathB("","_door/bluetopper (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_TOP+99;zoom,1.5);
	};
	LoadActor(THEME:GetPathB("","_door/bluetopper (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_BOTTOM-99;zoomy,-1;zoom,-1.5);
	};
}

--Lines
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(CenterX);
	LoadActor(THEME:GetPathB("","_door/lines (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_TOP+99;zoom,1.5);
	};
	LoadActor(THEME:GetPathB("","_door/lines (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_BOTTOM-99;zoomy,-1;zoom,-1.5);
	};
};
--Glow
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(CenterX);
	OnCommand=cmd(queuecommand,"Animate");
	AnimateCommand=cmd(diffuseshift;effectcolor1,1,1,1,0;effectcolor2,1,1,1,0.9;effectperiod,2.5);
	LoadActor(THEME:GetPathB("","_door/glow (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_TOP+133;zoom,1.5;diffusealpha,0;linear,2.5;diffusealpha,1;);
	};
	LoadActor(THEME:GetPathB("","_door/glow (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_BOTTOM-135;zoomy,-1;zoom,-1.5;diffusealpha,0;linear,2.5;diffusealpha,1;);
	};
};

return t;
