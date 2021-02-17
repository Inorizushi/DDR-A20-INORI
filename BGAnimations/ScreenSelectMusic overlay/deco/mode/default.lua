local t = Def.ActorFrame{};

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


t[#t+1] = Def.ActorFrame{
  InitCommand=cmd(xy,SCREEN_LEFT+127,SCREEN_TOP+56);
  Def.ActorFrame{
	  OnCommand=function(s) s:zoomy(0):sleep(0.3):linear(0.1):zoomy(1) end,
	LoadActor(ddrgame.."mode_nm_bs_mult.png");
	LoadActor(ddrgame.."mode_name_musicselect.png")..{
	  InitCommand=cmd(xy,-52,-10);
	};
  };
  
  Def.Sprite{
		InitCommand=cmd(xy,6,16);
		OnCommand=function(self)
			if GAMESTATE:GetPlayMode() == 'PlayMode_Regular' then
				self:Load(THEME:GetPathB("", "ScreenSelectMusic overlay/deco/mode/"..ddrgame.."Stage/Stage " .. ToEnumShortString(sStage) ));
				self:diffusealpha(0):sleep(0.2):linear(0.2):diffusealpha(1);
			end;
		end;
	};
};

return t;
