
local lang = "en";
if THEME:GetCurLanguage() == "ja" then
	lang = "jp";
end;

local t = Def.ActorFrame {
  Def.ActorFrame{
		GainFocusCommand=cmd(diffuse,color("1,1,1,1"));
		LoseFocusCommand=cmd(diffuse,color("0.5,0.5,0.5,1"));
		LoadActor( "Box/mid" )..{
	  	InitCommand=cmd(;x,44;y,228);
			OnCommand=cmd(diffusealpha,0;zoomy,0;sleep,0.2;smooth,0.2;zoomy,1;diffusealpha,1);
		};
    LoadActor( "Box/top" )..{
	  	InitCommand=cmd(;x,44;y,215);
			OnCommand=cmd(diffusealpha,0;y,215;sleep,0.2;smooth,0.2;y,156;diffusealpha,1);
		};
		LoadActor( "Box/bottom" )..{
	  	InitCommand=cmd(;x,44;y,215);
			OnCommand=cmd(diffusealpha,0;y,215;sleep,0.2;smooth,0.2;y,280;diffusealpha,1);
		};
	};
  Def.Sprite{
    Texture= ("Box/text/"..lang.."_course 1x2");
    InitCommand=cmd(pause,setstate,1;x,10;y,230);
    OnCommand=cmd(diffusealpha,0;zoomy,0;sleep,0.2;smooth,0.2;zoomy,1;diffusealpha,1);
    GainFocusCommand=cmd(setstate,0);
    LoseFocusCommand=cmd(setstate,1);
  };
	Def.ActorFrame{
    Def.Sprite{
			Texture="Box/course 1x7.png";
      InitCommand=cmd(pause;SetAllStateDelays,0.2;x,-151;y,156;diffusealpha,0);
      GainFocusCommand=cmd(play;diffusealpha,1);
      LoseFocusCommand=cmd(pause;setstate,0;diffusealpha,0);
    };
    LoadActor("Box/course icon off.png")..{
      InitCommand=cmd(x,-151;y,215;diffusealpha,1);
      OnCommand=cmd(diffusealpha,0;y,215;sleep,0.2;smooth,0.2;y,156;diffusealpha,1);
      GainFocusCommand=cmd(diffusealpha,0);
      LoseFocusCommand=cmd(diffusealpha,1);
    };
	};
};
t[#t+1] = Def.ActorFrame{
-- Load of Music play frame --
  LoadActor( "bgback" )..{
    OnCommand=cmd(x,46;y,-31;ztest,0);
    GainFocusCommand=cmd(diffuse,color("1,1,1,1"));
    LoseFocusCommand=cmd(diffuse,color("0.5,0.5,0.5,1"));
  };
  Def.Sprite{
    Texture="Course Play/bgframe";
    InitCommand=cmd(pause;setstate,0;x,40;y,-36);
    OnCommand=cmd(diffusealpha,1);
    GainFocusCommand=function(self)
      self:Load(THEME:GetPathG("","ScreenSelectPlayMode icon/Course Play/bgframe"))
    end;
    LoseFocusCommand=function(self)
      self:Load(THEME:GetPathG("","ScreenSelectPlayMode icon/Course Play/bg dark"))
    end;
  };
  Def.Sprite{
    Texture="Course Play/bgframe";
    InitCommand=cmd(pause;setstate,0;x,42;y,-45);
    OnCommand=cmd(diffusealpha,1;sleep,1.2);
    GainFocusCommand=function(self)
      self:Load(THEME:GetPathG("","ScreenSelectPlayMode icon/Course Play/char.png"))
    end;
    LoseFocusCommand=function(self)
      self:Load(THEME:GetPathG("","ScreenSelectPlayMode icon/Course Play/char dark.png"))
    end;
  };
  Def.ActorFrame{
		InitCommand=cmd(;x,-300;y,240;zoomx,1);
		OnCommand=cmd(zoomy,0;sleep,0.2;linear,0.2;zoomy,1;queuecommand,"Animate");
		AnimateCommand=cmd(bob;effectmagnitude,10,0,0;effectperiod,0.7);
		GainFocusCommand=cmd(finishtweening;linear,0.2;zoomx,1;zoomy,1;queuecommand,"Animate");
		LoseFocusCommand=cmd(stoptweening;linear,0.1;zoom,0);
		OffCommand=cmd(diffusealpha,0);
		LoadActor( THEME:GetPathG("","_sharedX3/_selectarrowg") );
		LoadActor( THEME:GetPathG("","_sharedX3/_selectarrowr") )..{
			InitCommand=cmd(diffusealpha,0;draworder,100);
			GainFocusCommand=cmd(diffusealpha,0);
			LoseFocusCommand=cmd(diffusealpha,1;sleep,0.4;diffusealpha,0);
		};
	};
  Def.Sprite{
    Texture="Box/title 1x3";
    InitCommand=cmd(pause;setstate,1;x,56;y,215);
    OnCommand=cmd(diffusealpha,0;y,215;sleep,0.2;smooth,0.2;y,156;diffusealpha,1);
    GainFocusCommand=function(self)
      self:Load(THEME:GetPathG("","ScreenSelectPlayMode icon/Box/title 1x3"))
      self:setstate(1)
    end;
    LoseFocusCommand=function(self)
      self:Load(THEME:GetPathG("","ScreenSelectPlayMode icon/Box/title shad 1x3"))
      self:setstate(1)
    end;
  };
  LoadActor( "Box/"..lang.."_course shad" )..{
    InitCommand=cmd(x,44;y,370);
    OnCommand=cmd(diffusealpha,0;zoomy,0;sleep,0.2;smooth,0.2;zoomy,1;diffusealpha,0.5);
    GainFocusCommand=cmd(diffusealpha,0);
    LoseFocusCommand=cmd(diffusealpha,0.5);
  };
}

return t;
