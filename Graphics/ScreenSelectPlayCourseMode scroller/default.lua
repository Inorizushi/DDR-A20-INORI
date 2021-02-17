local gc = Var("GameCommand");
local colors = {
	Easy		= color("#00ff00"),
	Normal		= color("#feee00"),
	Hard		= color("#feee00"),
	Rave		= color("#c44dff"),
	Extended	= color("#00ffff"),
	Oni		= color("#d70b8c"),
	Endless		= color("748392"),
};
local t = Def.ActorFrame {};
-- Background!
t[#t+1] = Def.ActorFrame {
-- 	GainFocusCommand=cmd(visible,true);
-- 	LoseFocusCommand=cmd(visible,false);
 	-- LoadActor("_HighlightFrame") .. {
		-- InitCommand=cmd(diffuse,colors[gc:GetName()];diffusealpha,0);
		-- GainFocusCommand=cmd(stoptweening;linear,0.125;diffusealpha,1);
		-- LoseFocusCommand=cmd(stoptweening;linear,0.125;diffusealpha,0);
		-- OffFocusedCommand=cmd(finishtweening;glow,Color("White");decelerate,1.5;glow,Color("Invisible"));
	-- };
};
-- Emblem Frame
t[#t+1] = Def.ActorFrame {
	FOV=90;
	InitCommand=cmd(x,0;zoom,1);
	OffCommand=cmd(linear,0.2;cropleft,0;cropright,0);
	-- Main Shadow
	LoadActor( gc:GetName()) .. {
		OffCommand=cmd(linear,0.2;cropleft,0;cropright,0);
	};
	-- Main Emblem
	LoadActor( gc:GetName() ) .. {
	OffCommand=cmd(linear,0.2;cropleft,0;cropright,0);	
	};
};
-- Text Frame
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,0;y,0);
	Def.Quad {
		InitCommand=cmd(cropleft,0.5;cropright,0.5;zoomto,1000,2;diffuse,Color("Black"));
		OnCommand=cmd(linear,0.2;cropleft,0;cropright,0);
		OffFocusCommand=cmd(stoptweening;linear,0.2;cropleft,0.5;cropright,0.5;);
	};
	-- LoadActor("COURSEPLAYbody.png" ) .. {
		-- InitCommand=cmd(diffusealpha,0;zoomy,0);
		-- OnCommand=cmd(linear,0.2;diffusealpha,1;zoomy,1);
		-- GainFocusCommand=cmd(stoptweening;stopeffect;smooth,0.125;diffusealpha,1;);
		-- LoseFocusCommand=cmd(stoptweening;stopeffect;);
		-- OffCommand=cmd(finishtweening;stopeffect;linear,0.2;zoomy,0;diffusealpha,0);
	-- };
	
	-- LoadActor("COURSEPLAYmirror.png" ) .. {
		-- InitCommand=cmd(diffusealpha,0;zoomy,0;y,125);
		-- OnCommand=cmd(linear,0.2;diffusealpha,0.5;zoomy,-1);
		-- GainFocusCommand=cmd(stoptweening;stopeffect;smooth,0.125;diffusealpha,0.5;);
		-- LoseFocusCommand=cmd(stoptweening;stopeffect;);
		-- OffCommand=cmd(finishtweening;stopeffect;linear,0.2;zoomy,0;diffusealpha,0);
	-- };
	-- Def.Quad {
		-- InitCommand=cmd(horizalign,left;y,20;zoomto,320,2;diffuse,colors[gc:GetName()];diffusealpha,0;fadeleft,0.35;faderight,0.35);
		-- GainFocusCommand=cmd(stoptweening;linear,0.2;diffusealpha,1);
		-- LoseFocusCommand=cmd(stoptweening;linear,0.2;diffusealpha,0);
	-- };
	-- LoadFont("_helveticaneuelt std extblk cn 42px") .. {
		-- Text=gc:GetName();
		-- InitCommand=cmd(horizalign,left;diffuse,colors[gc:GetName()];shadowcolor,ColorDarkTone(colors[gc:GetName()]);shadowlength,2;diffusealpha,0;skewx,-0.125);
		-- GainFocusCommand=cmd(stoptweening;x,-16;decelerate,0.25;diffusealpha,1;x,0);
		-- LoseFocusCommand=cmd(stoptweening;x,0;accelerate,0.25;diffusealpha,0;x,16;diffusealpha,0);
	-- };
	-- LoadFont("_helveticaneuelt std extblk cn 42px") .. {
		-- Text=THEME:GetString(Var "LoadingScreen", gc:GetName() .. "Explanation");
		-- InitCommand=cmd(horizalign,right;x,320;y,30;shadowlength,1;diffusealpha,0;skewx,-0.125;zoom,0.5);
		-- GainFocusCommand=cmd(stoptweening;x,320-16;decelerate,0.25;diffusealpha,1;x,320);
		-- LoseFocusCommand=cmd(stoptweening;x,320;accelerate,0.25;diffusealpha,0;x,320+16;diffusealpha,0);
	-- };
};
-- t.GainFocusCommand=cmd(visible,true);
-- t.LoseFocusCommand=cmd(visible,false);
return t