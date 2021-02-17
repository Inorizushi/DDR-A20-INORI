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
----------------------------------------------------------------------------
return Def.ActorFrame {
	Def.Sprite{
		Texture="_stages/scene_choice_stage_bg",
		InitCommand=function(s) s:Center():blend(Blend.Add):zoom(3):diffusealpha(0) end,
		OnCommand=function(self)
			self:linear(0.164):diffusealpha(1):zoomx(2.5*1.2):zoomy(2.5*0.7):sleep(0.2):linear(0.4):zoomx(2.3*1.2):zoomy(2.3*0.7)
			:sleep(0.2):linear(0.15):zoomx(1.8*1.2):zoomy(1.8*0.7):sleep(1.032):linear(0.04):diffusealpha(0):zoomx(1.8*1.2):zoomy(0)
		end;
	};
	Def.Sprite{
		InitCommand=function(s) s:xy(_screen.cx-700,_screen.cy):zoomy(2.5):blend(Blend.Add) end,
		Texture="_stages/"..ddrgame.."/Stage "..ToEnumShortString(sStage),
		OnCommand=function(self)
			self:diffusealpha(1):zoom(1):linear(0.164):zoom(1):x(_screen.cx):linear(0.25):diffusealpha(0.5):zoom(2):linear(0.25):diffusealpha(0):zoom(4)
		end;
	};
	Def.Sprite{
		InitCommand=function(s) s:xy(_screen.cx+700,_screen.cy):zoom(2.5):blend(Blend.Add) end,
		Texture="_stages/"..ddrgame.."/Stage "..ToEnumShortString(sStage),
		OnCommand=function(self)
			self:diffusealpha(1):zoom(1):linear(0.164):zoom(1):x(_screen.cx):linear(0.25):diffusealpha(0.5):zoom(2):linear(0.25):diffusealpha(0):zoom(4)
		end;
	};
	Def.ActorFrame{
		InitCommand=function(s) s:Center():zoom(0.7) end,
		Def.Sprite{
			Texture="_stages/"..ddrgame.."/Stage "..ToEnumShortString(sStage),
			OnCommand=function(self)
				self:diffusealpha(0):zoom(3):linear(0.164):diffusealpha(1):zoom(2.5):sleep(0.1):linear(0.4)
				:zoom(2.3):sleep(0.2):linear(0.15):zoomx(1.8*0.85):zoomy(1.8*0.82):sleep(1.032):linear(0.04)
				:diffusealpha(0.2):zoomx(1.8*1.2):zoomy(0)
			end;
		};
	};
};