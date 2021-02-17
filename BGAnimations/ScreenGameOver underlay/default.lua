local t = Def.ActorFrame{}

t[#t+1] = LoadActor("gameover") .. {
	OnCommand=function(self)
			self:play();
	end;
};

t[#t+1] = Def.ActorFrame {

	LoadActor( "../ScreenWithMenuElements background/background" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomto,SCREEN_WIDTH*1.01,SCREEN_HEIGHT*1.01);
	};
	LoadActor( "black" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomto,SCREEN_WIDTH*1.01,SCREEN_HEIGHT*1.01;diffusealpha,0.6;sleep,1.7;linear,0.8;diffusealpha,0);
	};
	LoadActor( "white" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomto,SCREEN_WIDTH*1.01,SCREEN_HEIGHT*1.01;diffusealpha,0;sleep,1.8;linear,1.4;diffusealpha,1);
	};
	LoadActor( "konami" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+200;zoom,1.5;sleep,3.3;linear,3;diffusealpha,0);
	};

	LoadActor( "white" )..{
		InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,0.9;diffusealpha,0);
	};
	LoadActor( "thank_you" )..{
		InitCommand=cmd(diffusealpha,0.35;zoom,2.2;x,SCREEN_CENTER_X-4000;y,SCREEN_CENTER_Y-60;linear,0.933;diffusealpha,0;zoom,2.2;x,SCREEN_CENTER_X+2000;y,SCREEN_CENTER_Y-60);
	};
	LoadActor( "for_playing" )..{
		InitCommand=cmd(diffusealpha,0.35;zoom,2.2;x,SCREEN_CENTER_X+4000;y,SCREEN_CENTER_Y+60;sleep,0.400;linear,0.933;diffusealpha,0;zoom,2.2;x,SCREEN_CENTER_X-2000;y,SCREEN_CENTER_Y+60);
	};


	
	LoadActor( "thank_you" )..{
		InitCommand=cmd(zoom,1.1;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-80;diffusealpha,0;sleep,0.95;linear,0.05;diffusealpha,1;linear,0.4;zoom,0.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-70;linear,0.01;diffusealpha,0);
	};
	LoadActor( "for_playing" )..{
		InitCommand=cmd(zoom,1.1;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+80;diffusealpha,0;sleep,0.95;linear,0.05;diffusealpha,1;linear,0.4;zoom,0.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+70;linear,0.01;diffusealpha,0);
	};
	LoadActor( "white" )..{
		InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffusealpha,0;sleep,0.9;linear,0.05;diffusealpha,1;linear,0.35;diffusealpha,0);
	};



	LoadActor( "thank_you" )..{
		InitCommand=cmd(zoom,0.8;x,SCREEN_CENTER_X-1100;y,SCREEN_CENTER_Y-80;sleep,1.42;linear,0.05;linear,0.4;zoom,0.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-70;sleep,0.4;linear,0.6;diffusealpha,0.7;linear,0.5;diffusealpha,1;linear,3;diffusealpha,0);
	};
	LoadActor( "for_playing" )..{
		InitCommand=cmd(zoom,0.8;x,SCREEN_CENTER_X+1100;y,SCREEN_CENTER_Y+80;sleep,1.42;linear,0.05;linear,0.4;zoom,0.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+70;sleep,0.4;linear,0.6;diffusealpha,0.7;linear,0.5;diffusealpha,1;linear,3;diffusealpha,0);
	};
	LoadActor( "thank_you" )..{
		InitCommand=cmd(zoom,0.8;x,SCREEN_CENTER_X-1100;y,SCREEN_CENTER_Y-80;sleep,1.42;linear,0.05;linear,0.4;zoom,0.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-70;linear,1;zoom,1.6;diffusealpha,0);
	};
	LoadActor( "for_playing" )..{
		InitCommand=cmd(zoom,0.8;x,SCREEN_CENTER_X+1100;y,SCREEN_CENTER_Y+80;sleep,1.42;linear,0.05;linear,0.4;zoom,0.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+70;linear,1;zoom,1.6;diffusealpha,0);
	};

	--LoadActor( "konami" )..{
	--	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-217;blend,'BlendMode_NoEffect';zwrite,true;clearzbuffer,false;);
	--};
	--Def.Quad{
	--	InitCommand=cmd(Center;FullScreen;diffusecolor,color("#FFFFFF");ztest,true);
	--};
	--Def.Quad{
	--	InitCommand=cmd(Center;FullScreen;diffusecolor,color("#FFFFFF");diffusealpha,0;sleep,3.5;linear,0.233;diffusealpha,1;);
	--};
};


t[#t+1] = Def.ActorFrame {
	--SOUND:PlayAnnouncer("game over")
};

return t;