local playMode = GAMESTATE:GetPlayMode()
if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
	curStage = playMode;
end;
local sStage = GAMESTATE:GetCurrentStage();
local tRemap = {
	Stage_1st		= 1,
	Stage_2nd		= 2,
	Stage_3rd		= 3,
	Stage_4th		= 4,
	Stage_5th		= 5,
	Stage_6th		= 6,
};

if tRemap[sStage] == PREFSMAN:GetPreference("SongsPerPlay") then
	sStage = "Stage_Final";
else
	sStage = sStage;
end;

local t = Def.ActorFrame{};
local song = GAMESTATE:GetCurrentSong();

local arrow_st=1.2;
local dt = 0.1;

if GoldenLeague == false or ddrgame=="blue_" then
	t[#t+1] = Def.Sprite{
		Texture="lights.png",
		InitCommand=function(s) s:Center():diffusealpha(0) end,
		OnCommand=function(s) s:diffusealpha(0):sleep(1):diffusealpha(0):sleep(0.033):linear(0.133):accelerate(0.3):diffusealpha(1):queuecommand("Animate") end,
		AnimateCommand=function(s) s:diffuseshift():effectcolor1(Color.White):effectcolor2(Alpha(Color.White,0.9)):effectperiod(0.2) end,
	};
end

local s = Def.ActorFrame{};
if ddrgame=="gold_" and GoldenLeague == true then
	s[#s+1] = loadfile(THEME:GetPathB("ScreenStageInformation","decorations/Silver"))();
end

return Def.ActorFrame{
	Def.Sound{
		File=THEME:GetPathS("","_Door"),
		OnCommand=function(s) s:play() end,
	};
	loadfile(THEME:GetPathB("ScreenStageInformation","decorations/SoundStage"))();
	s;
	Def.ActorFrame{
		Def.Sprite{
			Texture="scanlines",
			InitCommand=function(s) s:Center():diffusealpha(0.5) end,
			OnCommand=function(s)
				s:zoom(1.8):sleep(0.033):linear(0.083):zoom(1)
			end,
		};
		Def.Sprite{
			Texture="scanlines",
			InitCommand=function(s) s:Center():diffusealpha(0.5) end,
			OnCommand=function(s)
				s:zoom(2):sleep(0.033):linear(0.083):zoom(1)
			end,
		};
	};
	Def.ActorFrame{
		InitCommand=function(s) s:Center():rotationz(0):zoom(0.3):blend(Blend.Add) end,
		OnCommand=function(s)
			s:sleep(arrow_st-0.3):decelerate(0.2):zoom(1.02);
		end,
		Def.Sprite{
			Texture="coch_hud",
			InitCommand=function(s) s:halign(1) end
		};
		Def.Sprite{
			Texture="coch_hud",
			InitCommand=function(s) s:halign(1):zoomx(-1) end,
		};
	};
	Def.ActorFrame{
		InitCommand=function(s) s:zoom(1):diffusealpha(0):xy(_screen.cx,SCREEN_TOP-126) end,
		OnCommand=function(s) s:sleep(1):diffusealpha(1):sleep(0.033):linear(0.133):zoom(1):y(SCREEN_TOP+126) end,
		Def.Sprite{
			Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_frame"),
			InitCommand=function(s) s:halign(1) end,
		};
		Def.Sprite{
			Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_frame"),
			InitCommand=function(s) s:halign(1):zoomx(-1) end,
		};
		Def.ActorFrame{
			OnCommand=function(s) s:diffusealpha(0):sleep(1):diffusealpha(0):sleep(0.033):linear(0.133):accelerate(0.3):diffusealpha(1) end,
			Def.Sprite{
				Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_edge_flash"),
				InitCommand=function(s) s:halign(1) end,
			};
			Def.Sprite{
				Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_edge_flash"),
				InitCommand=function(s) s:halign(1):zoomx(-1) end,
			};
		};
	};
	Def.ActorFrame{
		InitCommand=function(s) s:zoom(1):diffusealpha(0):xy(_screen.cx,SCREEN_BOTTOM+126):rotationx(180) end,
		OnCommand=function(s) s:sleep(1):diffusealpha(1):sleep(0.033):linear(0.133):zoom(1):y(SCREEN_BOTTOM-126) end,
		Def.Sprite{
			Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_frame"),
			InitCommand=function(s) s:halign(1) end,
		};
		Def.Sprite{
			Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_frame"),
			InitCommand=function(s) s:halign(1):zoomx(-1) end,
		};
		Def.ActorFrame{
			OnCommand=function(s) s:diffusealpha(0):sleep(1):diffusealpha(0):sleep(0.033):linear(0.133):accelerate(0.3):diffusealpha(1) end,
			Def.Sprite{
				Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_edge_flash"),
				InitCommand=function(s) s:halign(1) end,
			};
			Def.Sprite{
				Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_edge_flash"),
				InitCommand=function(s) s:halign(1):zoomx(-1) end,
			};
		};
	};
	t;
	Def.ActorFrame{
		Name="Jacket",
		Def.ActorFrame{
			InitCommand=function(s) s:xy(_screen.cx,_screen.cy+166):zoom(1.7) end,
			Def.Sprite{
				Texture="jacket-bg",
				
				--What in the unholy fuck is this animation holy shit
				OnCommand=function(s) s:zoomy(0.0129):zoomx(1.3):diffusealpha(0):sleep(1.267+0.5):diffusealpha(1)
					:sleep(0.017):diffusealpha(0):zoomy(0.0645):addy(-8):sleep(0.017):diffusealpha(1)
					:sleep(0.017):diffusealpha(0):zoomy(0.1741):addy(-17):sleep(0.033):diffusealpha(1)
					:sleep(0.017):diffusealpha(0):zoomy(0.2806):addy(-17):zoomx(1.265):sleep(0.017):diffusealpha(1)
					:sleep(0.017):diffusealpha(0):zoomy(0.407):zoomx(1.245):addy(-17):sleep(0.017):diffusealpha(1)
					:sleep(0.017):diffusealpha(0):zoomy(0.527):addy(-18):zoomx(1.201):sleep(0.017):diffusealpha(1)
					:sleep(0.017):diffusealpha(0):zoomy(0.7):zoomx(1.126):addy(-25):sleep(0.017):diffusealpha(1)
					:sleep(0.017):diffusealpha(0):zoomy(0.790):zoomx(1.116):addy(-18):sleep(0.017):diffusealpha(1)
					:sleep(0.017):diffusealpha(0):zoomy(0.952):zoomx(1.066):addy(-25):sleep(0.017):diffusealpha(1)
					:sleep(0.017):diffusealpha(0)
				end,
			};
		};
		Def.ActorFrame{
			InitCommand=function(s) s:xy(_screen.cx,_screen.cy+19):zoom(1.7) end,
			Def.Sprite{
				Texture="jacket-bg",
				--Oh my god another one
				OnCommand=function(s) s:diffusealpha(0):sleep(1.617+0.5):zoomy(1.033):zoomx(1.033):addy(-3):sleep(0.034):diffusealpha(1)
					:sleep(0.017):diffusealpha(0):sleep(0.016):diffusealpha(1):sleep(0.018):diffusealpha(0)
					:sleep(0.017):diffusealpha(1):sleep(0.016):diffusealpha(0):sleep(0.018):diffusealpha(1)
					:sleep(0.017):diffusealpha(0):sleep(0.016):diffusealpha(1):sleep(0.018):diffusealpha(0)
					:sleep(0.150):zoomx(1.72):zoomy(0.335):addy(98):diffusealpha(1)
					:sleep(0.017):diffusealpha(0):sleep(0.017)
				end,
			};
		};
	};
	Def.ActorFrame{
		InitCommand=function(s) s:Center():diffusealpha(0) end,
		OnCommand=function(s) 
			s:queuecommand('Set'):diffusealpha(0):zoom(1):sleep(1.9+0.5)
			:linear(0.2):diffusealpha(1):zoom(1):sleep(3):diffusealpha(1)
		end,
		Def.Sprite{
			SetCommand=function(s)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if song then
					s:_LoadSCJacket(song)
				elseif course then
					s:Load(course:GetBannerPath())
				else
					s:Load(THEME:GetPathG("","Common fallback jacket"))
				end
				s:setsize(480,480)
			end,
		};
	};
	Def.Sprite{
		Texture="jacket-wbg2",
		InitCommand=function(s) s:Center():blend(Blend.Add):diffusealpha(0) end,
		OnCommand=function(s)
			s:zoom(1.55*2):sleep(1.6+0.7):linear(0.01)
			:diffusealpha(1):zoom(1.55*2):sleep(0.03):diffusealpha(1):zoom(1.85*2):sleep(0.1)
			:accelerate(0.04):diffusealpha(0):zoom(2.55*2)
		end,
	};
	Def.ActorFrame{
		InitCommand=function(s) s:xy(_screen.cx,SCREEN_BOTTOM-74) end,
		OnCommand=function(s)
			s:sleep(1.25):linear(0.401):zoom(0.8):addy(4):sleep(0.216):linear(0.033):zoomx(3):zoomy(0)
		end,
		Def.Sprite{
			Texture="con_label",
			InitCommand=function(s) s:y(-22) end,
		};
		Def.Sprite{
			Texture="prog_bg",
		};
		Def.Sprite{
			Texture="progbar",
			InitCommand=function(s) s:cropright(1) end,
			OnCommand=function(s) s:sleep(1.25):linear(0.401):cropright(0) end,
		};
	};
	Def.Quad{
		InitCommand=function(s) s:FullScreen():diffuse(Alpha(Color.White,0)):draworder(1) end,
		OnCommand=function(s) s:sleep(0.164):diffusealpha(1):linear(0.3):diffusealpha(0) end,
	};
	Def.Sprite{
		Texture=THEME:GetPathB("","_door/whiteflash"),
		InitCommand=function(s) s:Center():zoom(0) end,
		OnCommand=function(s) s:sleep(0.164):zoom(1.5):linear(0.134):linear(0.299):zoom(5) end,
	};
	loadfile(THEME:GetPathB("ScreenStageInformation","decorations/StageDisplay"))();
	--loadfile(THEME:GetPathB("ScreenStageInformation","decorations/Record/default.lua"))();
};