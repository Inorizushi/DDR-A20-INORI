local path = THEME:GetPathB("","_blue doors");

local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathS("","_select.ogg")) .. {
		AnimOnCommand=cmd(queuecommand,"Play");
		AnimOffCommand=cmd(queuecommand,"Play");
		PlayCommand=cmd(play);
	};
};

if ddrgame=="gold_" then
t[#t+1] = Def.ActorFrame{
	AnimOffCommand=cmd(diffusealpha,1;accelerate,0.4;diffusealpha,0);
	Def.Sprite{
		Texture="_blue doors/scsh_background 4x3.png";
		InitCommand=function(self)
			self:FullScreen()
			self:SetAllStateDelays(0.05)
		end;
	};
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,Color.Black;diffusealpha,0.5;);
	};
	Def.Sprite{
		Texture="_blue doors/scsh_back_inter (stretch).png";
		InitCommand=function(self)
			self:FullScreen():diffusealpha(0.5)
			local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
			local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
			self:customtexturerect(2,1.5,w,h);
			self:texcoordvelocity(0,1);
		end;
	};
};
else
  t[#t+1] = Def.ActorFrame{
    AnimOffCommand=cmd(diffusealpha,1;accelerate,0.4;diffusealpha,0);
    Def.Quad{
      InitCommand=function(s) s:FullScreen():diffuse(color("#000f36")) end,
    };
    Def.Sprite{
      Texture="_blue doors/scch_frame_shadow",
      InitCommand=function(s) s:xy(_screen.cx,SCREEN_TOP):valign(0):zoomtowidth(SCREEN_WIDTH) end,
    };
    Def.Sprite{
      Texture="_blue doors/scch_frame_shadow",
      InitCommand=function(s) s:xy(_screen.cx,SCREEN_BOTTOM):valign(0):zoomy(-1):zoomtowidth(SCREEN_WIDTH) end,
    };
  }
end

t[#t+1] = Def.ActorFrame{
  Def.Quad{
		ShowCommand=cmd(diffusealpha,0);
    InitCommand=cmd(CenterY;setsize,SCREEN_WIDTH/2,SCREEN_HEIGHT;x,_screen.cx-320;diffuse,color("#181819");diffusealpha,0);
    AnimOnCommand=cmd(x,_screen.cx-320;diffusealpha,1;sleep,1;linear,0.1;diffuse,Color.White;diffusealpha,0.75;linear,0.1;diffusealpha,0);
		AnimOffCommand=cmd(diffusealpha,1;faderight,0;accelerate,0.4;diffusealpha,0;faderight,1);
  };
	Def.Quad{
		ShowCommand=cmd(diffusealpha,0);
    InitCommand=cmd(CenterY;setsize,SCREEN_WIDTH/2,SCREEN_HEIGHT;x,_screen.cx+320;diffuse,color("#181819");diffusealpha,0);
    AnimOnCommand=cmd(x,_screen.cx+320;diffusealpha,1;sleep,1;linear,0.1;diffuse,Color.White;diffusealpha,0.75;linear,0.1;diffusealpha,0);
		AnimOffCommand=cmd(diffusealpha,1;fadeleft,0;accelerate,0.4;diffusealpha,0;fadeleft,1);
  };
};

--Flashes
t[#t+1] = Def.ActorFrame{
	--Top/Bottom
  LoadActor(path.."/scsh_back03_flash_blue.png")..{
    InitCommand=cmd(rotationz,90;x,SCREEN_CENTER_X;CenterY;diffusealpha,0;blend,Blend.Add;setsize,SCREEN_HEIGHT,SCREEN_WIDTH;);
    AnimOnCommand=cmd(y,_screen.cy-700;accelerate,0.15;diffusealpha,0.5;sleep,0.5;linear,0.3;y,SCREEN_CENTER_Y-240;linear,0.1;diffusealpha,0;);
		AnimOffCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;accelerate,0.2;diffusealpha,0.5;linear,0.4;x,SCREEN_CENTER_X+700;diffusealpha,0;);
  };
  LoadActor(path.."/scsh_back03_flash_blue.png")..{
    InitCommand=cmd(rotationz,-90;x,SCREEN_CENTER_X;CenterY;diffusealpha,0;blend,Blend.Add;setsize,SCREEN_HEIGHT,SCREEN_WIDTH;);
    AnimOnCommand=cmd(y,_screen.cy+700;accelerate,0.15;diffusealpha,0.5;sleep,0.5;linear,0.3;y,SCREEN_CENTER_Y+240;linear,0.1;diffusealpha,0;);
		AnimOffCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;accelerate,0.2;diffusealpha,0.5;linear,0.4;x,SCREEN_CENTER_X-700;diffusealpha,0;);
  };
	--Sides
	LoadActor(path.."/scsh_back03_flash_blue.png")..{
    InitCommand=cmd(x,SCREEN_CENTER_X;CenterY;diffusealpha,0;blend,Blend.Add;setsize,SCREEN_WIDTH,SCREEN_HEIGHT;);
    AnimOnCommand=cmd(x,_screen.cx+700;accelerate,0.15;diffusealpha,0.5;sleep,0.5;linear,0.3;x,SCREEN_CENTER_X-320;linear,0.1;diffusealpha,0;);
		AnimOffCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;accelerate,0.2;diffusealpha,0.5;linear,0.4;x,SCREEN_CENTER_X+700;diffusealpha,0;);
  };
  LoadActor(path.."/scsh_back03_flash_blue.png")..{
    InitCommand=cmd(zoomx,-1;x,SCREEN_CENTER_X;CenterY;diffusealpha,0;blend,Blend.Add;setsize,SCREEN_WIDTH,SCREEN_HEIGHT;);
    AnimOnCommand=cmd(x,_screen.cx-700;accelerate,0.15;diffusealpha,0.5;sleep,0.5;linear,0.3;x,SCREEN_CENTER_X+320;linear,0.1;diffusealpha,0;);
		AnimOffCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;accelerate,0.2;diffusealpha,0.5;linear,0.4;x,SCREEN_CENTER_X-700;diffusealpha,0;);
  };
}

t[#t+1] = Def.ActorFrame{
  InitCommand=cmd(CenterX;y,SCREEN_TOP-6);
  Def.ActorFrame{
		InitCommand=cmd(diffusealpha,0);
		ShowCommand=cmd(diffusealpha,1);
    AnimOnCommand=cmd(diffusealpha,0;addy,-200;sleep,0.25;decelerate,0.2;addy,200;diffusealpha,1;);
		AnimOffCommand=cmd(diffusealpha,1;sleep,0.25;decelerate,0.2;addy,-200;diffusealpha,0;);
    LoadActor(path.."/"..ddrgame.."scsh_back02_blue.png")..{
      InitCommand=cmd(valign,0;x,-321;zoomx,-1);
    };
    LoadActor(path.."/"..ddrgame.."scsh_back02_blue.png")..{
      InitCommand=cmd(valign,0;x,321);
    };
  };
  Def.ActorFrame{
    InitCommand=function(s) s:y(-74) end,
    AnimOnCommand=cmd(diffusealpha,0);
    AnimOffCommand=cmd(diffusealpha,0);
    ShowCommand=function(s) s:sleep(0.25):decelerate(0.2):diffusealpha(1) end,
    OnCommand=cmd(diffuseshift;effectcolor1,1,1,1,0.25;effectcolor2,1,1,1,0.9;effectperiod,3);
    LoadActor(path.."/"..ddrgame.."scsh_back02_light_blue.png")..{
      InitCommand=cmd(valign,0;x,-321;zoomx,-1);
    };
    LoadActor(path.."/"..ddrgame.."scsh_back02_light_blue.png")..{
      InitCommand=cmd(valign,0;x,321);
    };
  };
};

t[#t+1] = Def.ActorFrame{
  InitCommand=cmd(CenterX;y,SCREEN_BOTTOM+6;zoomy,-1);
  Def.ActorFrame{
		InitCommand=cmd(diffusealpha,0);
		ShowCommand=cmd(diffusealpha,1);
    AnimOnCommand=cmd(diffusealpha,0;addy,-200;sleep,0.25;decelerate,0.2;addy,200;diffusealpha,1;);
		AnimOffCommand=cmd(diffusealpha,1;sleep,0.25;decelerate,0.2;addy,-200;diffusealpha,0;);
    LoadActor(path.."/"..ddrgame.."scsh_back02_blue.png")..{
      InitCommand=cmd(valign,0;x,-321;zoomx,-1);
    };
    LoadActor(path.."/"..ddrgame.."scsh_back02_blue.png")..{
      InitCommand=cmd(valign,0;x,321);
    };
  };
  Def.ActorFrame{
    InitCommand=function(s) s:y(-74) end,
		AnimOnCommand=cmd(diffusealpha,0);
    AnimOffCommand=cmd(diffusealpha,0);
    ShowCommand=function(s) s:sleep(0.25):decelerate(0.2):diffusealpha(1) end,
    OnCommand=cmd(diffuseshift;effectcolor1,1,1,1,0.25;effectcolor2,1,1,1,0.9;effectperiod,3);
    LoadActor(path.."/"..ddrgame.."scsh_back02_light_blue.png")..{
      InitCommand=cmd(valign,0;x,-321;zoomx,-1);
    };
    LoadActor(path.."/"..ddrgame.."scsh_back02_light_blue.png")..{
      InitCommand=cmd(valign,0;x,321);
    };
  };
};

t[#t+1] = Def.ActorFrame{
  LoadActor(path.."/scsh_back03_flash_blue.png")..{
    InitCommand=cmd(rotationz,-90;;x,SCREEN_CENTER_X;CenterY;diffusealpha,0;blend,Blend.Add;setsize,SCREEN_HEIGHT,SCREEN_WIDTH;);
    AnimOnCommand=cmd(diffusealpha,0;y,_screen.cy;accelerate,0.1;diffusealpha,0.75;sleep,0.1;linear,0.2;y,SCREEN_CENTER_Y+700;diffusealpha,0;);
		AnimOffCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;accelerate,0.2;diffusealpha,0.5;linear,0.3;x,SCREEN_CENTER_X+700;diffusealpha,0;);
  };
  LoadActor(path.."/scsh_back03_flash_blue.png")..{
    InitCommand=cmd(rotationz,90;x,SCREEN_CENTER_X;CenterY;diffusealpha,0;blend,Blend.Add;setsize,SCREEN_HEIGHT,SCREEN_WIDTH;);
    AnimOnCommand=cmd(diffusealpha,0;y,_screen.cy;accelerate,0.1;diffusealpha,0.75;sleep,0.1;linear,0.2;y,SCREEN_CENTER_Y-700;diffusealpha,0;);
		AnimOffCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;accelerate,0.2;diffusealpha,0.5;linear,0.3;x,SCREEN_CENTER_X-700;diffusealpha,0;);
  };
}

return t;
