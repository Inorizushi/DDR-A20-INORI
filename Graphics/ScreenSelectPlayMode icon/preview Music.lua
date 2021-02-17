local max_stages = PREFSMAN:GetPreference( "SongsPerPlay" );

if GAMESTATE:IsEventMode() then
	max_stages = "Unlimited";
end;

local lang = "en";
if THEME:GetCurLanguage() == "ja" then
	lang = "jp";
end;

local t = Def.ActorFrame {
-- Load of Music play frame --
	Def.ActorFrame{
		GainFocusCommand=cmd(diffuse,color("1,1,1,1"));
		LoseFocusCommand=cmd(diffuse,color("0.5,0.5,0.5,1"));
		LoadActor( "Box/mid" )..{
	  	InitCommand=cmd(;x,-44;y,228);
			OnCommand=cmd(diffusealpha,0;zoomy,0;sleep,0.2;smooth,0.2;zoomy,1;diffusealpha,1);
		};
    LoadActor( "Box/top" )..{
	  	InitCommand=cmd(;x,-44;y,215);
			OnCommand=cmd(diffusealpha,0;y,215;sleep,0.2;smooth,0.2;y,156;diffusealpha,1);
		};
		LoadActor( "Box/bottom" )..{
	  	InitCommand=cmd(;x,-44;y,215);
			OnCommand=cmd(diffusealpha,0;y,215;sleep,0.2;smooth,0.2;y,280;diffusealpha,1);
		};
	};
	Def.Sprite{
		Texture= ("Box/text/"..lang.."_music 1x2");
		InitCommand=cmd(pause,setstate,0;x,-60;y,230);
		OnCommand=cmd(diffusealpha,0;zoomy,0;sleep,0.2;smooth,0.2;zoomy,1;diffusealpha,1);
		GainFocusCommand=cmd(setstate,0);
		LoseFocusCommand=cmd(setstate,1);
	};
	Def.ActorFrame{
		LoadActor( "Box/disc" )..{
	  	InitCommand=cmd(;x,-244;y,215);
			OnCommand=cmd(diffusealpha,0;y,215;sleep,0.2;smooth,0.2;y,160;diffusealpha,1;queuecommand,"Animate");
			AnimateCommand=cmd(linear,0.4;addy,2;linear,0.4;addx,-2;linear,0.4;addy,-2;linear,0.4;addx,2;queuecommand,"Animate");
			GainFocusCommand=cmd(diffusealpha,1;queuecommand,"Animate");
			LoseFocusCommand=cmd(diffusealpha,0;finishtweening;);
		};
		LoadActor( "Box/music icon off" )..{
	  	InitCommand=cmd(;x,-244;y,215);
			OnCommand=cmd(diffusealpha,0;y,215;sleep,0.2;smooth,0.2;y,156;diffusealpha,0);
			GainFocusCommand=cmd(diffusealpha,0);
			LoseFocusCommand=cmd(diffusealpha,1;);
		};
		LoadActor("Box/note")..{
			InitCommand=cmd(;x,-238;y,215;shadowlength,2;shadowcolor,color("#01215c"));
			OnCommand=cmd(diffusealpha,0;y,215;sleep,0.2;smooth,0.2;y,150;diffusealpha,1;queuecommand,"Animate");
			AnimateCommand=cmd(linear,0.5;addy,-2;linear,0.5;addy,2;queuecommand,"Animate");
			GainFocusCommand=cmd(diffusealpha,1;queuecommand,"Animate");
			LoseFocusCommand=cmd(diffusealpha,0;finishtweening;);
		};
		Def.Sprite{
			Texture="Box/title 1x3";
			InitCommand=cmd(pause;setstate,0;x,-32;y,215);
			OnCommand=cmd(diffusealpha,0;y,215;sleep,0.2;smooth,0.2;y,156;diffusealpha,1);
			GainFocusCommand=function(self)
				self:Load(THEME:GetPathG("","ScreenSelectPlayMode icon/Box/title 1x3"))
			end;
			LoseFocusCommand=function(self)
				self:Load(THEME:GetPathG("","ScreenSelectPlayMode icon/Box/title shad 1x3"))
			end;
		};
	};
};

t[#t+1] = Def.ActorFrame{
	LoadActor( "bgback" )..{
		OnCommand=cmd(x,-42;y,-30;ztest,0);
		GainFocusCommand=cmd(diffuse,color("1,1,1,1"));
		LoseFocusCommand=cmd(diffuse,color("0.5,0.5,0.5,1"));
	};
	--[[LoadActor( "Normal Play/bgframe" )..{
	    InitCommand=cmd(blend,'BlendMode_Add';diffusealpha,0;x,-45;y,-35;);
		OnCommand=cmd(diffusealpha,1;sleep,1.2);
		AnimateCommand=cmd(diffuseshift;effectperiod,2);
		GainFocusCommand=cmd(stoptweening;diffusealpha,1;playcommand,"Animate");
		LoseFocusCommand=cmd(stoptweening;diffusealpha,0);
		OffCommand=cmd(sleep,0.2;linear,0.07;addx,-2000;diffusealpha,0);
	};]]--
	Def.Sprite{
		Texture="Normal Play/bgframe";
		InitCommand=cmd(pause;setstate,0;x,-48;y,-35);
		OnCommand=cmd(diffusealpha,1;sleep,1.2);
		GainFocusCommand=function(self)
			self:Load(THEME:GetPathG("","ScreenSelectPlayMode icon/Normal Play/bgframe"))
		end;
		LoseFocusCommand=function(self)
			self:Load(THEME:GetPathG("","ScreenSelectPlayMode icon/Normal Play/bg dark"))
		end;
	};
	LoadActor( "Normal Play/char.png" )..{
		InitCommand=cmd(diffusealpha,0;x,-42;y,-45);
		OnCommand=cmd(diffusealpha,1);
		GainFocusCommand=cmd(diffusealpha,1);
    LoseFocusCommand=cmd(diffusealpha,0);
	};
	LoadActor( "Normal Play/chardark.png" )..{
		InitCommand=cmd(diffusealpha,0;x,-42;y,-45);
		OnCommand=cmd(diffusealpha,0);
    GainFocusCommand=cmd(diffusealpha,0);
    LoseFocusCommand=cmd(diffusealpha,1);
	};
  LoadActor( "MaxStage_"..max_stages )..{
	  InitCommand=cmd(x,135;y,156;zoom,1.5);
		OnCommand=cmd(diffusealpha,0;y,215;sleep,0.2;smooth,0.2;y,156;diffusealpha,1);
		GainFocusCommand=cmd(diffuse,color("1,1,1,1"));
		LoseFocusCommand=cmd(diffuse,color("0.5,0.5,0.5,1"));
	};
	Def.ActorFrame{
		InitCommand=cmd(;x,300;y,240;zoomx,-1.0);
		OnCommand=cmd(zoomy,0;sleep,0.2;linear,0.2;zoomy,1;queuecommand,"Animate");
		AnimateCommand=cmd(bob;effectmagnitude,10,0,0;effectperiod,0.7);
		GainFocusCommand=cmd(finishtweening;linear,0.2;zoomx,-1;zoomy,1;queuecommand,"Animate");
		LoseFocusCommand=cmd(stoptweening;linear,0.1;zoom,0);
		OffCommand=cmd(diffusealpha,0);
		LoadActor( THEME:GetPathG("","_sharedX3/_selectarrowg") );
		LoadActor( THEME:GetPathG("","_sharedX3/_selectarrowr") )..{
			InitCommand=cmd(diffusealpha,0;draworder,100);
			GainFocusCommand=cmd(diffusealpha,0);
			LoseFocusCommand=cmd(diffusealpha,1;sleep,0.4;diffusealpha,0);
		};
	};
	LoadActor( "Box/"..lang.."_music shad" )..{
    InitCommand=cmd(x,-44;y,370);
    OnCommand=cmd(diffusealpha,0;zoomy,0;sleep,0.2;smooth,0.2;zoomy,1;diffusealpha,0);
    GainFocusCommand=cmd(diffusealpha,0);
    LoseFocusCommand=cmd(diffusealpha,0.5);
  };
}

return t;
