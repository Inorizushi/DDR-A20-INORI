local t = Def.ActorFrame{
	Def.Sprite{
		Texture="base.png",
		InitCommand=function(s) s:FullScreen():diffusealpha(0) end,
	};
}

local customscore=GetCustomScoreMode();
local cscore="A20";
if not GAMESTATE:IsCourseMode() then
 local stepcnt={0,0}
 t[#t+1] = Def.Actor{
     JudgmentMessageCommand = function(self, params)
		if STATSMAN:GetCurStageStats():GetPlayerStageStats(params.Player):GetFailed() == false then
         if params.TapNoteScore and
          params.TapNoteScore ~= 'TapNoteScore_AvoidMine' and
          params.TapNoteScore ~= 'TapNoteScore_HitMine' and
          params.TapNoteScore ~= 'TapNoteScore_CheckpointMiss' and
          params.TapNoteScore ~= 'TapNoteScore_CheckpointHit' and
          params.TapNoteScore ~= 'TapNoteScore_None'
         then
             if customscore=="old" then
                 Scoring[scoreType](params, 
                     STATSMAN:GetCurStageStats():GetPlayerStageStats(params.Player))
             elseif customscore=="5b2" then
                 local pn=((params.Player==PLAYER_1) and 1 or 2);
                 stepcnt[pn]=stepcnt[pn]+1;
                 CustomScore_SM5b2(params,cscore,GAMESTATE:GetCurrentSteps(params.Player),stepcnt[pn]);
             elseif customscore=="5b1" then
                 local pn=((params.Player==PLAYER_1) and 1 or 2);
                 stepcnt[pn]=stepcnt[pn]+1;
                 CustomScore_SM5b1(params,cscore,GAMESTATE:GetCurrentSteps(params.Player),stepcnt[pn]);
             else
                 local pn=((params.Player==PLAYER_1) and 1 or 2);
                 stepcnt[pn]=stepcnt[pn]+1;
                 CustomScore_SM5a2(params,cscore,GAMESTATE:GetCurrentSteps(params.Player),stepcnt[pn]);
             end;
         end
		 end
     end;
     InitCommand=function(self)
         if customscore=="non" then
             CustomScore_SM5a2_Init();
         end;
     end;
     OffCommand=function(self)
         if customscore=="non" then
             CustomScore_SM5a2_Out();
         end;
     end;
 };
 end;

if ReadPrefFromFile("UserPrefGameplayShowFastSlow") ~= nil then
	if GetUserPrefB("UserPrefGameplayShowFastSlow") then
		t[#t+1] = LoadActor("TimingJudgements.lua")..{
			InitCommand=cmd(draworder,1);
		};
	end
end


--[[t[#t+1] = LoadActor("OptionsHack.lua")..{
	InitCommand=cmd(draworder,1);
};]]

t[#t+1] = Def.ActorFrame{
	Def.Sprite{
		Name="StageFrame",
		Texture="stageframe/"..ddrgame.."stage_frame0000_normal",
		InitCommand=function(s)
			s:xy(_screen.cx,SCREEN_TOP+36):visible(not GAMESTATE:IsDemonstration())
		end,
	};
	
}
if not GAMESTATE:IsDemonstration() then
	t[#t+1] = StandardDecorationFromFile("StageDisplay","StageDisplay")
	end

for _,pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	t[#t+1] = LoadActor("lifeframe",pn);
end

t[#t+1] = StandardDecorationFromFile("ScoreFrame","ScoreFrame");

return t