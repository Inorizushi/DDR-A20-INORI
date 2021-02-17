local t = Def.ActorFrame{};

local function setGradeP1(self,param)
	local ClearedRank = 0;
	local pn = PLAYER_2;
  local st = GAMESTATE:GetCurrentStyle():GetStepsType()

  if self.ParamCourse then
    local trails = GAMESTATE:GetCurrentTrail(PLAYER_2)
    if trails then
		local sDiff = trails:GetDifficulty()
		
		local diffname = GAMESTATE:GetCurrentTrail(PLAYER_2):GetDifficulty()
	  
		if GAMESTATE:GetCurrentStyle():GetStyleType() == "StyleType_TwoPlayersTwoSides" then
			self:cropleft(0.5);
		end;
		if PROFILEMAN:IsPersistentProfile(pn) then 
			profile = PROFILEMAN:GetProfile(pn); --player profile
		else 
			profile = PROFILEMAN:GetMachineProfile(); --machine profile
		end;
		
		scorelist = profile:GetHighScoreList( self.ParamCourse, trails);
		local scores = scorelist:GetHighScores();
		local topscore=0;
		if scores[1] then
			topscore = scores[1]:GetScore();
		end;
		local topgrade;
		local temp=#scores;
		
		
		if scores[1] then   -- 7=Failed  6=D  5=C  4=B  3=A  2=AA  1=AAA
			for i=1,temp do 
				topgrade = scores[1]:GetGrade();
				curgrade = scores[i]:GetGrade();
				if scores[1]:GetScore()>1  then
					if scores[1]:GetScore()==100000000 and topgrade=="Grade_Tier07" then --AutoPlayHack
						ClearedRank = 7;
						break;
					else --Normal
						if ToEnumShortString(curgrade) ~= "Failed"  then --not failed
							local gradenum = tonumber(string.sub(curgrade,-2,-1));
							ClearedRank = gradenum;
							break;
						else --failed
							if i == temp then
								ClearedRank = 7;
								break;
							end;
						end;
					end;
				else
					ClearedRank = 0;
				end;
			end;
		

			local scoresHasUsedBatteryAndCleared = false;
			for i=1,temp do  -- Check FC Rank  -- 1=MFC 2=PFC 3=GreatFC 4=GreatOldFC 5=GoodFC 6=GoodOldFC 7=NoFCWithBatteryLives 8=NoFCWithLifeBar 9=Failed 0=NoPlayed
				if scores[i] then
					topscore = scores[i];
					assert(topscore);
					local misses = topscore:GetTapNoteScore("TapNoteScore_Miss")+topscore:GetTapNoteScore("TapNoteScore_CheckpointMiss")
							+topscore:GetTapNoteScore("TapNoteScore_HitMine")+topscore:GetHoldNoteScore("HoldNoteScore_LetGo")
					local boos = topscore:GetTapNoteScore("TapNoteScore_W5")
					local goods = topscore:GetTapNoteScore("TapNoteScore_W4")
					local greats = topscore:GetTapNoteScore("TapNoteScore_W3")
					local perfects = topscore:GetTapNoteScore("TapNoteScore_W2")
					local marvelous = topscore:GetTapNoteScore("TapNoteScore_W1")
					local hasUsedLittle = string.find(topscore:GetModifiers(),"Little")
					local hasUsedBattery = string.find(topscore:GetModifiers(),"Lives")

					if (misses+boos) == 0 and scores[1]:GetScore() > 0 and (marvelous+perfects)>0 and (not hasUsedLittle) and topscore:GetGrade()~="Grade_Failed"  then
							if (goods+greats+perfects) == 0 then
									FullComboRank = 1;
									break;
							elseif goods+greats == 0 then
									FullComboRank = 2;
									break;
							elseif (misses+boos+goods) == 0 then
									FullComboRank = 4;
									if i==1 then
										FullComboRank = 3;
									end;
									break;
							elseif (misses+boos) == 0 then
									FullComboRank = 6;
									if i==1 then
										FullComboRank = 5;
									end;
									break;
							end;
					else
						-- if hasUsedBattery then
							-- if i==temp then
								-- FullComboRank = 7;
								-- break;
							-- end;
						-- else
							-- FullComboRank = 8;
						-- end
						if topscore:GetGrade()~="Grade_Failed" then
							if hasUsedBattery  then
								scoresHasUsedBatteryAndCleared = true;
								FullComboRank = 7;
							else 
								scoresHasUsedBatteryAndCleared = scoresHasUsedBatteryAndCleared or false;
								FullComboRank = 8;
							end
						end
					end;
				end
			end;
			
			if scoresHasUsedBatteryAndCleared and FullComboRank == 8 then
				FullComboRank = 7;
			end
		end
		if ClearedRank == 0 then --NoPlayed
			self:LoadBackground(THEME:GetPathG("MusicWheelItem Song NormalPart/ClearedMark","MFC"));
			(cmd(diffuseshift;effectcolor1,1,1,1,0;effectcolor2,1,1,1,0;effectperiod,0.1))(self);
		elseif ClearedRank == 7 then --E
			self:LoadBackground(THEME:GetPathG("MusicWheelItem Song NormalPart/ClearedMark","Failed"));
			(cmd(diffuseshift;effectcolor1,0,0,0,0.65;effectcolor2,0,0,0,1;effectperiod,1.1))(self);
		elseif FullComboRank == 8 then -- 8=NoFCWithLifeBar
			self:LoadBackground(THEME:GetPathG("MusicWheelItem Song NormalPart/ClearedMark","NoFCWithLifeBar"));
			(cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,1;effectperiod,0.1))(self);
		elseif FullComboRank == 7 then --7=NoFCWithBatteryLives
			self:LoadBackground(THEME:GetPathG("MusicWheelItem Song NormalPart/ClearedMark","NoFCWithBatteryLives"));
			(cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,1;effectperiod,0.1))(self);
		elseif FullComboRank == 6 then --6=GoodOldFC
			self:LoadBackground(THEME:GetPathG("MusicWheelItem Song NormalPart/ClearedMark","GoodOldFC"));
			(cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.7;effectperiod,0.1))(self);
		elseif FullComboRank == 5 then -- 5=GoodFC
			self:LoadBackground(THEME:GetPathG("MusicWheelItem Song NormalPart/ClearedMark","GoodFC"));
			(cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.7;effectperiod,0.1))(self);
		elseif FullComboRank == 4 then -- 4=GreatOldFC
			self:LoadBackground(THEME:GetPathG("MusicWheelItem Song NormalPart/ClearedMark","GreatOldFC"));
			(cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.7;effectperiod,0.1))(self);
		elseif FullComboRank == 3 then --3=GreatFC
			self:LoadBackground(THEME:GetPathG("MusicWheelItem Song NormalPart/ClearedMark","GreatFC"));
			(cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.7;effectperiod,0.1))(self);
		elseif FullComboRank == 2 then --2=PFC
			self:LoadBackground(THEME:GetPathG("MusicWheelItem Song NormalPart/ClearedMark","PFC"));
			(cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.8;effectperiod,0.1))(self);
		elseif FullComboRank == 1 then --1=MFC
			self:LoadBackground(THEME:GetPathG("MusicWheelItem Song NormalPart/ClearedMark","MFC"));
			(cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.8;effectperiod,0.1))(self);

		end
		
		-- if ClearedRank == 7 then --E
			-- (cmd(diffuseshift;effectcolor1,0,0,0,0.65;effectcolor2,0,0,0,1;effectperiod,1.1))(self);
		-- elseif ClearedRank == 6 then --D
			-- (cmd(diffuseshift;effectcolor1,0.6,0,0,0.65;effectcolor2,0.8,0,0,1;effectperiod,0.5))(self);
		-- elseif ClearedRank == 5 then --C
			-- (cmd(diffuseshift;effectcolor1,1,0,1,0.65;effectcolor2,1,0,1,0.35;effectperiod,0.5))(self);
		-- elseif ClearedRank == 4 then --B
			-- (cmd(diffuseshift;effectcolor1,0,0.3,1,0.65;effectcolor2,0,0.5,1,0.9;effectperiod,0.1))(self);
		-- elseif ClearedRank == 3 then --A
			-- (cmd(diffuseshift;effectcolor1,1,1,0.2,0.65;effectcolor2,1,1,0.2,0.35;effectperiod,0.1))(self);
		-- elseif ClearedRank == 2 then --AA
			-- (cmd(diffuseshift;effectcolor1,1,1,0.6,0.65;effectcolor2,1,1,0.7,1;effectperiod,0.1))(self);
		-- elseif ClearedRank == 1 then --AAA
			-- (cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.8;effectperiod,0.1))(self);
		-- elseif ClearedRank == 0 then
			-- (cmd(diffuseshift;effectcolor1,1,1,1,0;effectcolor2,1,1,1,0;effectperiod,0.1))(self);
		-- end
	  

  	else
		self:LoadBackground(THEME:GetPathG("MusicWheelItem Song NormalPart/ClearedMark","MFC"));
  		(cmd(diffuseshift;effectcolor1,1,1,1,0;effectcolor2,1,1,1,0;effectperiod,0.1))(self);
  	end;
  end;
  return ClearedRank
end;




t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:x(0)
		self:y(0)
	end;
	Def.ActorFrame{
		InitCommand=cmd(draworder,0);
		LoadActor("AllCleared_All")..{
			SetCommand=function(self,param)
				self.ParamCourse = param.Course
				setGradeP1(self)
				self:zoom(1)
			end;
			CurrentStepsP2ChangedMessageCommand=function(self) setGradeP1(self) end;
			CurrentSongChangedMessageCommand=function(self) setGradeP1(self) end;
			CurrentTrailP2ChangedMessageCommand=function(self) setGradeP1(self) end;
			CurrentCourseChangedMessageCommand=function(self) setGradeP1(self) end;
		};
	};
};

-- t[#t+1] = Def.ActorFrame{
	-- InitCommand=cmd(zoomx,2.2;zoomy,1.0;draworder,2;y,-12);
	-- Def.BitmapText{
		-- InitCommand=cmd(diffuse,color("#FFFFFF");strokecolor,color("#000000"));
		-- Font="_itc machine std 20px";
		-- SetCommand=function(self,param)
			-- self.ParamCourse = param.Song
			-- self:settext(setGradeP1(self))
			
		-- end;
		-- CurrentStepsP1ChangedMessageCommand=function(self) self:settext(setGradeP1(self)) end;
		-- CurrentSongChangedMessageCommand=function(self) self:settext(setGradeP1(self)) end;
	-- };
-- };
return t;
