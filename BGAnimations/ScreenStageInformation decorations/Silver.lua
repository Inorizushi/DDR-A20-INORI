local arrow_st=1.2;
local dt = 0.1;

--rotationz,addx,addy
local AR = {
    {0,0,-155},
    {90,490,0},
    {180,0,155},
    {270,-490,0}
};

local t = Def.ActorFrame{}
for i,v in ipairs(AR) do
    t[#t+1] = Def.Sprite{
        Texture=THEME:GetPathB("","_door_Silver/arrow"),
        InitCommand=function(s) s:xy(_screen.cx,_screen.cy):valign(1):rotationz(v[1]):zoom(0.7):blend(Blend.Add) end,
        OnCommand=function(s)
            s:sleep(arrow_st-0.6):decelerate(0.6):rotationz(v[1]+720)
            :sleep(0.06):diffusealpha(0):sleep(0.06):diffusealpha(1):sleep(0.06):diffusealpha(0)
            :sleep(0.06):diffusealpha(1):sleep(0.06):diffusealpha(0):sleep(0.06):diffusealpha(1)
            :decelerate(0.2):addx(v[2]):addy(v[3]):zoom(1)
     end,
    };
end

return Def.ActorFrame{
    Def.Quad{
		InitCommand=function(s)
			s:diffuse(color("#1f2e45")):FullScreen():diffusealpha(0):linear(0.1):diffusealpha(1)
		end,
	};
	Def.ActorFrame{
		Def.Sprite{
			Texture=THEME:GetPathB("","_door_Silver/scsh_stair_silv"),
			InitCommand=function(s)
				s:Center():setsize(1280,720)
			end,
			OnCommand=function(s)
				s:zoom(1.3):diffusealpha(0):sleep(dt):linear(0.2)
				:zoom(1.2):diffusealpha(1):decelerate(1):zoom(1)
			end,
		};
		Def.Sprite{
			Texture=THEME:GetPathB("","_door_Silver/scsh_stair_silv"),
			InitCommand=function(s) s:Center():setsize(1280,720):MaskSource() end,
			OnCommand=function(s)
				s:zoom(1.3):diffusealpha(0):sleep(dt):linear(0.2)
				:zoom(1.2):diffusealpha(1):decelerate(1):zoom(1)
			end,
		};
		Def.Quad{
			InitCommand=function(s)
				s:Center():MaskDest():setsize(1280,720):blend(Blend.Add):ztestmode('ZTestMode_WriteOnFail')
			end,
			OnCommand=function(s)
				s:zoom(1.3):diffusealpha(0):sleep(dt):linear(0.2):zoom(1.2)
				:diffusealpha(0.4):decelerate(1):zoom(1):diffusealpha(0)
			end,
		};
	};
	Def.Sprite{
		Texture=THEME:GetPathB("","_door/whiteflash"),
		InitCommand=function(s) s:Center() end,
		OnCommand=function(s) s:zoomx(0):sleep(dt):sleep(0.3):linear(0.134)
			:zoomx(1):linear(0.099):zoom(3)
		end,
	};
	Def.Sprite{
		Texture=THEME:GetPathB("","_door_Silver/scsh_flare1_silv"),
		InitCommand=function(s)
			s:xy(_screen.cx,_screen.cy-200):blend(Blend.Add)
		end,
		OnCommand=function(s)
			s:diffusealpha(0):zoom(3):sleep(dt):linear(0.264):diffusealpha(0.15):zoom(2.5):blend('BlendMode_Add')
			:linear(5):rotationz(-100);
		end;
	};
	Def.Sprite{
		Texture=THEME:GetPathB("","_door_Silver/particle"),
		InitCommand=function(s)
			s:Center():blend(Blend.Add):zoom(0.2)
		end,
		OnCommand=function(s)
			s:diffusealpha(0):sleep(dt):linear(0.7):addx(100):addy(-60):diffusealpha(0.6)
			:linear(0.7):addx(100):addy(-60):diffusealpha(0)
		end,
	};
	Def.Sprite{
		Texture=THEME:GetPathB("","_door_Silver/particle"),
		InitCommand=function(s)
			s:Center():blend(Blend.Add):zoom(0.2)
		end,
		OnCommand=function(s)
			s:diffusealpha(0):sleep(dt):linear(0.7):addx(-60):addy(-100):diffusealpha(0.6)
			:linear(0.7):addx(-60):addy(-100):diffusealpha(0)
		end,
	};
	Def.Sprite{
		Texture=THEME:GetPathB("","_door_Silver/particle"),
		InitCommand=function(s)
			s:Center():blend(Blend.Add):zoom(0.2)
		end,
		OnCommand=function(s)
			s:diffusealpha(0):sleep(dt):linear(0.7):addx(100):addy(100):diffusealpha(0.6)
			:linear(0.7):addx(100):addy(100):diffusealpha(0)
		end,
	};
	Def.ActorFrame{
		InitCommand=function(s) s:xy(_screen.cx,SCREEN_BOTTOM):zoom(2.3) end,
		OnCommand=function(s) s:diffuse(Color.Black):sleep(dt):decelerate(0.8):zoom(1):diffuse(Color.White):decelerate(0.4):addy(-20) end,
		Def.Sprite{
			Texture=THEME:GetPathB("","_door_Silver/scsh_frame_silv_01"),
			InitCommand=function(s) s:align(0,1) end,
		};
		Def.Sprite{
			Texture=THEME:GetPathB("","_door_Silver/scsh_frame_silv_01"),
			InitCommand=function(s) s:align(0,1):zoomx(-1) end,
		};
	};
	Def.ActorFrame{
		InitCommand=function(s) s:xy(_screen.cx,SCREEN_TOP):zoom(-2.3) end,
		OnCommand=function(s) s:diffuse(Color.Black):sleep(dt):decelerate(0.8):zoom(-1):diffuse(Color.White):decelerate(0.4):addy(20) end,
		Def.Sprite{
			Texture=THEME:GetPathB("","_door_Silver/scsh_frame_silv_01"),
			InitCommand=function(s) s:align(0,1) end,
		};
		Def.Sprite{
			Texture=THEME:GetPathB("","_door_Silver/scsh_frame_silv_01"),
			InitCommand=function(s) s:align(0,1):zoomx(-1) end,
		};
    };
    t;
};