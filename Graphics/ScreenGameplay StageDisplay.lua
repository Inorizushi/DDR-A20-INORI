local curScreen = Var "LoadingScreen";
local curStageIndex = GAMESTATE:GetCurrentStageIndex() + 1;
local playMode = GAMESTATE:GetPlayMode();

local t = Def.ActorFrame {
	LoadFont("_silta 20px") .. {
		InitCommand=cmd(y,-1;shadowlength,0;playcommand,"Set");
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTraiP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTraiP2ChangedMessageCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
			local curStage = GAMESTATE:GetCurrentStage();
			if GAMESTATE:IsCourseMode() then
				local stats = STATSMAN:GetCurStageStats()
				if not stats then
					return
				end
				local mpStats = stats:GetPlayerStageStats( GAMESTATE:GetMasterPlayerNumber() )
				local songsPlayed = mpStats:GetSongsPassed() + 1
				self:settextf("%i / %i", songsPlayed, GAMESTATE:GetCurrentCourse():GetEstimatedNumStages());
			else
				if GAMESTATE:IsEventMode() then
					self:settextf("EVENT", curStageIndex);
				else
					local thed_stage= thified_curstage_index(false)
					
					if THEME:GetMetric(curScreen,"StageDisplayUseShortString") then
						if thed_stage == "Extra1" then
							thed_stage = "EXTRA";
						elseif thed_stage == "Extra2" then
							thed_stage = "ENCORE EXTRA"
						end
						if string.len(thed_stage) >= 5 then
							thed_stage=string.upper(thed_stage);
						end
						self:settextf(thed_stage)
					else
						self:settextf("%s Stage", thed_stage)
					end
				end
			end;
			
			self:zoomx(0.9);
			self:zoomy(1.2);
			self:maxwidth(95);
		end;
	};
};
return t

