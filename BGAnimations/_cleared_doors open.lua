local t = Def.ActorFrame{};

--Hacky way to get the transition.
t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathS("","_select.ogg")) .. {
		OnCommand=cmd(queuecommand,"Play");
		PlayCommand=cmd(play);
	};
	
	
};


--t[#t+1] = LoadActor(THEME:GetPathB("","_door/backdrop"))..{
--	InitCommand=cmd(FullScreen;Center;diffusealpha,1;zoom,3.5);
--	OnCommand=cmd(faderight,0;fadeleft,0;sleep,0.2;linear,0.1;diffusealpha,0;faderight,1;fadeleft,1);
--};

--t[#t+1] = LoadActor(THEME:GetPathB("","_door_Silver/back_silver"))..{
--	InitCommand=cmd(FullScreen;Center;diffusealpha,1;zoom,3.5);
--	OnCommand=cmd(faderight,0;fadeleft,0;sleep,0.2;linear,0.1;diffusealpha,0;faderight,1;fadeleft,1);
--};

t[#t+1] = Def.ActorFrame{
  --Def.Quad{
    --InitCommand=cmd(zoom,1.5;halign,1;x,SCREEN_CENTER_X+80;CenterY;FullScreen;diffuse,color("#00f6ff");diffusealpha,0);
    --OnCommand=cmd(faderight,0.2;sleep,0.2;linear,0.1;diffusealpha,0.75;linear,0.3;addx,-(SCREEN_CENTER_X-150);diffusealpha,0;);
  --};
  --Def.Quad{
    --InitCommand=cmd(zoom,1.5;halign,0;x,SCREEN_CENTER_X-80;CenterY;FullScreen;diffuse,color("#00f6ff");diffusealpha,0);
    --OnCommand=cmd(fadeleft,0.2;sleep,0.2;linear,0.1;diffusealpha,0.75;linear,0.3;addx,(SCREEN_CENTER_X+150);diffusealpha,0;);
  --};
}

--Those Weird Curved Things
t[#t+1] = Def.ActorFrame{
	--InitCommand=cmd(CenterX);
	--LoadActor(THEME:GetPathB("","_door/bluebg"))..{
	--	InitCommand=cmd(y,SCREEN_TOP+99;zoom,1.5);
    --OnCommand=cmd(sleep,0.4;linear,0.2;addy,-99;diffusealpha,0;);
	--};
	--LoadActor(THEME:GetPathB("","_door/bluebg"))..{
	--	InitCommand=cmd(y,SCREEN_BOTTOM-99;zoom,-1.5);
    --OnCommand=cmd(sleep,0.4;linear,0.2;addy,99;diffusealpha,0;);
	--};
}


t[#t+1]=LoadActor( "_door_Silver/back_silver2" )..{
	OnCommand=function(self)
		self:zoom(1);
		self:x(SCREEN_CENTER_X);
		self:y(SCREEN_CENTER_Y);
		self:diffusealpha(1);
		self:sleep(0.1);
		self:accelerate(0.3);
		--self:zoom(2);
		self:diffusealpha(0);
	end;
};


--More Of THose Weird Curved Things
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(Center);
	LoadActor(THEME:GetPathB("","_door_Silver/door_silver_a"))..{
		InitCommand=cmd(zoom,1);
   	 OnCommand=cmd(sleep,0.2;accelerate,0.3;zoom,2.2;diffusealpha,1;);
	};
	--LoadActor(THEME:GetPathB("","_door/bluetopper"))..{
	--	InitCommand=cmd(y,SCREEN_BOTTOM-99;zoom,-1.5);
   	--    OnCommand=cmd(sleep,0.4;linear,0.2;addy,99;diffusealpha,0;);
	--};
}



--Lines
t[#t+1] = Def.ActorFrame{
	--InitCommand=cmd(CenterX);
	--LoadActor(THEME:GetPathB("","_door/lines"))..{
	--	InitCommand=cmd(y,SCREEN_TOP+99;zoom,1.5);
	--	OnCommand=cmd(sleep,0.4;linear,0.2;addy,-99;diffusealpha,0;);
	--};
	--LoadActor(THEME:GetPathB("","_door/lines"))..{
	--	InitCommand=cmd(y,SCREEN_BOTTOM-99;zoom,-1.5);
    --OnCommand=cmd(sleep,0.4;linear,0.2;addy,99;diffusealpha,0;);
	--};
};
--Glow
--t[#t+1] = Def.ActorFrame{
	--InitCommand=cmd(CenterX;queuecommand,"Animate");
	--AnimateCommand=cmd(diffuseshift;effectcolor1,1,1,1,0;effectcolor2,1,1,1,0.9;effectperiod,0.5);
	--LoadActor(THEME:GetPathB("","_door/glow"))..{
	--	InitCommand=cmd(y,SCREEN_TOP+112;zoom,1.5);
	--	OnCommand=cmd(sleep,0.4;linear,0.2;addy,-15;diffusealpha,0;);
	--};
	--LoadActor(THEME:GetPathB("","_door/glow"))..{
	--	InitCommand=cmd(y,SCREEN_BOTTOM-112;zoom,-1.5);
	--	OnCommand=cmd(sleep,0.4;linear,0.2;addy,15;diffusealpha,0;);
	--};
--};

t[#t+1] = LoadActor( "ScreenGameplay out/Stage Cleared BG" )..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,1.5);
	OnCommand=function(self)
	self:diffusealpha(1):zoom(1.5):linear(0.04):zoomx(3):zoomy(0.1):sleep(0.1):zoomy(0):diffusealpha(0);
	end;
	};
	
t[#t+1] = LoadActor( "ScreenGameplay out/cleared" )..{
	InitCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
	OnCommand=cmd(linear,0.08;zoomy,0);
};

t[#t+1] = LoadActor( "ScreenGameplay out/glow_cleared" )..{
	InitCommand=cmd(zoom,1.5;blend,Blend.Add;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;blend,Blend.Add;diffuseshift;effectperiod,0.55;effectcolor1,color("1,1,1,1");effectcolor2,color("0.5,0.5,0.5,1"));
	OnCommand=cmd(linear,0.08;zoomy,0);
};

return t
