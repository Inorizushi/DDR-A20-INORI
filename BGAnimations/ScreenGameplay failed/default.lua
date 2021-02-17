return Def.ActorFrame {



--Sound
LoadActor("close") .. {
	OnCommand=cmd(sleep,0.083;queuecommand,"Play");
	PlayCommand=cmd(play);
};

--Sound
LoadActor("../_failed") .. {
	OnCommand=cmd(queuecommand,"Play");
	PlayCommand=cmd(play);
};

--Sound
--LoadActor("../__swooshDDRA") .. {
--	OnCommand=cmd(sleep,0.083;queuecommand,"Play");
--	PlayCommand=cmd(play);
--};

--Black BG
Def.Quad{
	OnCommand=cmd(Center;FullScreen;diffusecolor,Color.Black;diffusealpha,0;sleep,0.434;linear,0.033;diffusealpha,1;);
};

--White flash
LoadActor( "../_door/whiteflash" )..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomx,0;sleep,0.3;linear,0.134;zoomx,1;linear,0.199;zoom,4);
};

--Up side
--BG
--LoadActor( "../_door/graybg" )..{
--	InitCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP-99;linear,0.183;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
--	OnCommand=cmd();
--};
LoadActor( "../_door/grayshdw" )..{
	InitCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP-99;linear,0.183;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
	OnCommand=cmd();
};
--LoadActor( "../_door/lines" )..{
--	InitCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP-99;linear,0.183;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
--	OnCommand=cmd();
--};

--Down Side
--BG
--LoadActor( "../_door/graybg" )..{
--	InitCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+99;zoomy,-1.5;linear,0.183;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-99;);
--	OnCommand=cmd();
--};
LoadActor( "../_door/grayshdw" )..{
	InitCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+99;zoomy,-1.5;linear,0.183;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-99;);
	OnCommand=cmd();
};
--LoadActor( "../_door/lines" )..{
--	InitCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+99;zoomy,-1.5;linear,0.183;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-99;);
--	OnCommand=cmd();
--};

LoadActor( "fback_arrow" )..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,1.1);
	OnCommand=function(self)
	self:diffusealpha(0)
	:linear(0.364):diffusealpha(1);
	end;
};


	
	LoadActor( "../_door_Silver/back_silver2" )..{
			--OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
			OnCommand = function(self)
			
				self:zoom(1.3);
				self:x(SCREEN_CENTER_X);
				self:y(SCREEN_CENTER_Y);
				self:diffusealpha(0);
				
			--self:sleep(dt);
			self:linear(0.2);
				
				self:zoom(1.2);
				self:diffusealpha(1);
				
			--self:sleep(dt);
			self:decelerate(1);
				
				self:zoom(1);
			end;
};
		
LoadActor( "../_door_Silver/door_silver_b" )..{
			--OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
			OnCommand = function(self)
				self:zoom(2.3);
				self:x(SCREEN_CENTER_X);
				self:y(SCREEN_CENTER_Y);
				--self:sleep(dt);
				self:decelerate(1);
				self:zoom(1);
			end;
};
	
LoadActor( "Stage Red BG" )..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,1.5);
	OnCommand=function(self)
	self:diffusealpha(0):zoom(3)
	:linear(0.164):diffusealpha(0.6):zoomy(1.7):zoomx(2.8):blend('BlendMode_Add');
	end;
	};

LoadActor( "glow_failed" )..{
	OnCommand=cmd(zoom,1.5;blend,Blend.Add;diffuseshift;effectperiod,0.55;effectcolor1,color("1,1,1,1");effectcolor2,color("1,1,1,1");
	diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,0;sleep,0.283;linear,0.217;diffusealpha,1;sleep,1;);
};




--Left
LoadActor( "failed" )..{
	InitCommand=cmd(zoom,1.72;x,SCREEN_LEFT-452;y,SCREEN_CENTER_Y;linear,0.134;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+5;blend,('BlendMode_Add'));
	OnCommand=cmd();
};
--Right
LoadActor( "failed" )..{
	InitCommand=cmd(zoom,1.72;x,SCREEN_RIGHT+452;y,SCREEN_CENTER_Y;linear,0.134;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+5;blend,('BlendMode_Add'));
	OnCommand=cmd();
};
--Glow
LoadActor( "failed" )..{
	InitCommand=cmd(zoom,1.72;diffusealpha,0;sleep,0.201;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+5;diffusealpha,1;zoomx,1.14;linear,0.016;zoomy,1.14;zoomx,1;linear,0.017;diffusealpha,0.25;linear,0.199;diffusealpha,0);
	OnCommand=cmd();
};

LoadActor( "failed" )..{
	InitCommand=cmd(zoom,1.72;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+5;linear,0.134;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+5);
	OnCommand=cmd();
};






}