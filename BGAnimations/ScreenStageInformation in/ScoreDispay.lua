local t = Def.ActorFrame{};
local OffsetX = 192;
local SleepOffset = 0.3;

function StageTopRecord(pn) --�^�ǳ̰��������Ӭ���
	local SongOrCourse, StepsOrTrail;
	local myScoreSet = {
		["HasScore"] = 0;
		["SongOrCourse"] =0;
		["topscore"] = 0;
		["topW1"]=0;
		["topW2"]=0;
		["topW3"]=0;
		["topW4"]=0;
		["topW5"]=0;
		["topMiss"]=0;
		["topOK"]=0;
		["topEXScore"]=0;
		["topMAXCombo"]=0;
		["topDate"]=0;
		};
		
	if GAMESTATE:IsCourseMode() then
		SongOrCourse = GAMESTATE:GetCurrentCourse();
		StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
	else
		SongOrCourse = GAMESTATE:GetCurrentSong();
		StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
	end;

	local profile, scorelist;
	
	if SongOrCourse and StepsOrTrail then
		local st = StepsOrTrail:GetStepsType();
		local diff = StepsOrTrail:GetDifficulty();
		local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;

		if PROFILEMAN:IsPersistentProfile(pn) then
			-- player profile
			profile = PROFILEMAN:GetProfile(pn);
		else
			-- machine profile
			profile = PROFILEMAN:GetMachineProfile();
		end;

		scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
		assert(scorelist);
		local scores = scorelist:GetHighScores();
		assert(scores);
		if scores[1] then
			myScoreSet["SongOrCourse"]=1;
			myScoreSet["HasScore"] = 1;
			myScoreSet["topscore"] = scores[1]:GetScore();
			myScoreSet["topW1"]  = scores[1]:GetTapNoteScore("TapNoteScore_W1");
			myScoreSet["topW2"]  = scores[1]:GetTapNoteScore("TapNoteScore_W2");
			myScoreSet["topW3"]  = scores[1]:GetTapNoteScore("TapNoteScore_W3");
			myScoreSet["topW4"]  = scores[1]:GetTapNoteScore("TapNoteScore_W4");
			myScoreSet["topW5"]  = scores[1]:GetTapNoteScore("TapNoteScore_W5");
			myScoreSet["topMiss"]  = scores[1]:GetTapNoteScore("TapNoteScore_W5")+scores[1]:GetTapNoteScore("TapNoteScore_Miss");
			myScoreSet["topOK"]  = scores[1]:GetHoldNoteScore("HoldNoteScore_Held");
			--myScoreSet["topEXScore"]  = scores[1]:GetTapNoteScore("TapNoteScore_W1")*3+scores[1]:GetTapNoteScore("TapNoteScore_W2")*2+scores[1]:GetTapNoteScore("TapNoteScore_W3")+scores[1]:GetHoldNoteScore("HoldNoteScore_Held")*3;
			if (StepsOrTrail:GetRadarValues( pn ):GetValue( "RadarCategory_TapsAndHolds" ) >=0) then --If it is not a random course
				if scores[1]:GetGrade() ~= "Grade_Failed" then
					myScoreSet["topEXScore"] = scores[1]:GetTapNoteScore("TapNoteScore_W1")*3+scores[1]:GetTapNoteScore("TapNoteScore_W2")*2+scores[1]:GetTapNoteScore("TapNoteScore_W3")+scores[1]:GetHoldNoteScore("HoldNoteScore_Held")*3;
				else
					myScoreSet["topEXScore"] = (StepsOrTrail:GetRadarValues( pn ):GetValue( "RadarCategory_TapsAndHolds" )*3+StepsOrTrail:GetRadarValues( pn ):GetValue( "RadarCategory_Holds" )*3)*scores[1]:GetPercentDP();
				end
			else --If it is Random Course then the scores[1]:GetPercentDP() value will be -1
				if scores[1]:GetGrade() ~= "Grade_Failed" then
					myScoreSet["topEXScore"]  = scores[1]:GetTapNoteScore("TapNoteScore_W1")*3+scores[1]:GetTapNoteScore("TapNoteScore_W2")*2+scores[1]:GetTapNoteScore("TapNoteScore_W3")+scores[1]:GetHoldNoteScore("HoldNoteScore_Held")*3;
				else
					myScoreSet["topEXScore"]  = 0;
				end
			end
			myScoreSet["topMAXCombo"]  = scores[1]:GetMaxCombo();
			myScoreSet["topDate"]  = scores[1]:GetDate() ;
		else
			myScoreSet["SongOrCourse"]=1;
			myScoreSet["HasScore"] = 0;
		end;
	else
		myScoreSet["HasScore"] = 0;
		myScoreSet["SongOrCourse"]=0;
		
	end
	return myScoreSet;

end;


function ReadHSPlayerOfSongP1( PlayerUID )
	local file = RageFileUtil:CreateRageFile();
	if file:Open("Save/LastPlayedSong/"..currentdir.."_hsplayer.txt",1) then
		local str = file:Read();
		hiscoreplayer = str;
	else
		hiscoreplayer = "";
	end;
	file:Close();
end;


if GAMESTATE:IsPlayerEnabled(PLAYER_1) then



--target score

--[[

local currentdir = GAMESTATE:GetCurrentSong():GetDisplayFullTitle();
local PlayerUID = PROFILEMAN:GetProfile(PLAYER_1):GetGUID();
local mHiScore = 0;
local hiscoreplayer = "- - -";

function ReadHiScoreOfSongP1( PlayerUID )
	local file = RageFileUtil:CreateRageFile();
	if file:Open("Save/LastPlayedSong/"..currentdir..".txt",1) then
		local str = file:Read();
		mHiScore = tonumber(str);
	else
		mHiScore = 0;
	end;
	file:Close();
end;

function ReadHSPlayerOfSongP1( PlayerUID )
	local file = RageFileUtil:CreateRageFile();
	if file:Open("Save/LastPlayedSong/"..currentdir.."_hsplayer.txt",1) then
		local str = file:Read();
		hiscoreplayer = str;
	else
		hiscoreplayer = "- - -";
	end;
	file:Close();
end;

ReadHiScoreOfSongP1(PlayerUID);
ReadHSPlayerOfSongP1(PlayerUID);

local targetMovingY = 82;
t[#t+1]=Def.ActorFrame{
	LoadActor("Score_Back_t")..{
		InitCommand=cmd(x,SCREEN_LEFT-OffsetX;y,SCREEN_CENTER_Y+200+targetMovingY;zoom,1.5);
		OnCommand=cmd(sleep,SleepOffset+1.9;linear,0.05;x,SCREEN_LEFT+OffsetX);
	};
	--FC Ring
	LoadActor(THEME:GetPathG("StageIn","Spin FullCombo"))..{
		InitCommand=cmd(player,PLAYER_1;zoom,0.25;shadowlength,1;x,SCREEN_LEFT+167-OffsetX;y,SCREEN_CENTER_Y+190+targetMovingY;horizalign,center;draworder,2;);
		OnCommand=function(self)
			local profile, scorelist;
			local text = "";
			self:diffuse(GameColor.Judgment["JudgmentLine_W1"]);
			self:glowblink();
			self:effectperiod(0.20);
			self:zoom(0.25);
			--self:diffusealpha(0.8);
			self:diffusealpha(0);
			(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_LEFT+OffsetX+167))(self);
		end;
	};

	--AAA display
	Def.Quad{
		InitCommand=cmd(player,PLAYER_1;zoom,0.35;shadowlength,1;x,SCREEN_LEFT+135-OffsetX;y,SCREEN_CENTER_Y+188+targetMovingY;horizalign,center;draworder,2;);
		OnCommand=function(self)
			self:LoadBackground(THEME:GetPathG("myMusicWheel","Tier01"));
			--self:diffusealpha(1);
			self:diffusealpha(0);
			(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_LEFT+OffsetX+135))(self);
		end;
	};

	--Score
	Def.RollingNumbers { -- Topscore
		File = THEME:GetPathF("_helveticaneuelt pro 65 md","24px");
		InitCommand=cmd(shadowlength,0;zoomy,0.80;zoomx,1.85;maxwidth,240;x,SCREEN_LEFT-OffsetX-40;y,SCREEN_CENTER_Y+194+targetMovingY;horizalign,center;);
		OnCommand=function(self)
			if GAMESTATE:IsCourseMode() then
				--self:Load("RollingNumbersCourseData");
				self:Load("RollingNumbersStageInScore");
			else
				--self:Load("RollingNumbersSongData");
				self:Load("RollingNumbersStageInScore");
			end
			self:diffuse(color("1,1,0.28,1"));
			self:strokecolor(color("0.0,0.0,0.0,1"));
			self:diffusealpha(1);
			self:targetnumber(mHiScore);
			

			(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_LEFT+OffsetX-40))(self);
		end;
	};

	--Targetscore displayName
	LoadFont("_helveticaneuelt pro 65 md 24px") .. {
		Text = hiscoreplayer;
		InitCommand=cmd(maxwidth,200;zoomy,0.8;zoomx,1.4;x,SCREEN_LEFT-OffsetX;y,SCREEN_CENTER_Y+222+targetMovingY;horizalign,left;strokecolor,Color("Outline"));
		OnCommand=function(self)
			self:sleep(SleepOffset+1.8);
			self:linear(0.05);
			self:x(SCREEN_LEFT+OffsetX-60-110);
			if hiscoreplayer == "- - -" and mHiScore == 0 then
				self:diffusealpha(0);
			end;
		end;
	};

};

]]--
--to here


t[#t+1]=Def.ActorFrame{
	LoadActor("Score_Back_a")..{
	InitCommand=cmd(x,SCREEN_LEFT-OffsetX;y,SCREEN_CENTER_Y+200;zoom,1.5);
		OnCommand=cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_LEFT+OffsetX);
		
};
	
	LoadActor("../ScreenGameplay decorations/frame1")..{
	InitCommand=cmd(x,SCREEN_LEFT-OffsetX-28;y,SCREEN_CENTER_Y+148;zoom,0.85);
		OnCommand=cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_LEFT+OffsetX-28);
		
};
	--FC Ring
	LoadActor(THEME:GetPathG("StageIn","Spin FullCombo"))..{
	InitCommand=cmd(player,PLAYER_1;zoom,0.25;shadowlength,1;x,SCREEN_LEFT+167-OffsetX;y,SCREEN_CENTER_Y+190;horizalign,center;draworder,2;);
	OnCommand=function(self)
			local SongOrCourse, StepsOrTrail;
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
				StepsOrTrail = GAMESTATE:GetCurrentTrail(PLAYER_1);
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
				StepsOrTrail = GAMESTATE:GetCurrentSteps(PLAYER_1);
			end;

			local profile, scorelist;
			local text = "";
			if SongOrCourse and StepsOrTrail then
				local st = StepsOrTrail:GetStepsType();
				local diff = StepsOrTrail:GetDifficulty();
				local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;

				if PROFILEMAN:IsPersistentProfile(PLAYER_1) then
					--player profile
					profile = PROFILEMAN:GetProfile(PLAYER_1);
				else
					--machine profile
					profile = PROFILEMAN:GetMachineProfile();
				end;

				scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
				
				assert(scorelist);
					local scores = scorelist:GetHighScores();
					assert(scores);
					local temp=#scores;
					local topscore=0;
					if scores[1] then
						topscore = scores[1]:GetScore();
					end;
					assert(topscore);
					local topgrade;
					if scores[1] then
						-- self:addx(-31);
						-- self:addy(13.5);
						for i=1,temp do 
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
								if (misses+boos) == 0 and scores[1]:GetScore() > 0 and (marvelous+perfects)>0 and (not hasUsedLittle) and topscore:GetGrade()~="Grade_Failed"  then
										if (goods+greats+perfects) == 0 then
												self:diffuse(GameColor.Judgment["JudgmentLine_W1"]);
												self:glowblink();
												self:effectperiod(0.20);
												self:zoom(0.25);
												break;
										elseif goods+greats == 0 then
												self:diffuse(GameColor.Judgment["JudgmentLine_W2"]);
												--self:glowshift();
												self:zoom(0.25);
												break;
										elseif (misses+boos+goods) == 0 then
												self:diffuse(BoostColor(GameColor.Judgment["JudgmentLine_W3"],0.75));
												self:stopeffect();
												self:zoom(0.25);
												if i==1 then
													self:diffuse(BoostColor(GameColor.Judgment["JudgmentLine_W3"],1));
												end;
												break;
										elseif (misses+boos) == 0 then
												self:diffuse(BoostColor(GameColor.Judgment["JudgmentLine_W4"],0.75));
												self:stopeffect();
												self:zoom(0.25);
												if i==1 then
													self:diffuse(BoostColor(GameColor.Judgment["JudgmentLine_W4"],1));
												end;
												break;
										end;
										
										self:diffusealpha(0.8);
										
								else
										self:diffusealpha(0);
								end;
							else
								self:diffusealpha(0);
								break;
							end;
						end;
					else
							self:diffusealpha(0);
					end;
			else
				self:diffusealpha(0);
			end;
			(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_LEFT+OffsetX+167))(self);
		end;
	};
	
	Def.Quad{
	InitCommand=cmd(player,PLAYER_1;zoom,0.35;shadowlength,1;x,SCREEN_LEFT+135-OffsetX;y,SCREEN_CENTER_Y+188;horizalign,center;draworder,2;);

		OnCommand=function(self)
			local SongOrCourse, StepsOrTrail;
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
				StepsOrTrail = GAMESTATE:GetCurrentTrail(PLAYER_1);
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
				StepsOrTrail = GAMESTATE:GetCurrentSteps(PLAYER_1);
			end;

			local profile, scorelist;
			local text = "";
			if SongOrCourse and StepsOrTrail then
				local st = StepsOrTrail:GetStepsType();
				local diff = StepsOrTrail:GetDifficulty();
				local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;

				if PROFILEMAN:IsPersistentProfile(PLAYER_1) then
					-- player profile
					profile = PROFILEMAN:GetProfile(PLAYER_1);
				else
					-- machine profile
					profile = PROFILEMAN:GetMachineProfile();
				end;

				scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
				assert(scorelist);
					local scores = scorelist:GetHighScores();
					assert(scores);
					local topscore=0;
					if scores[1] then
						topscore = scores[1]:GetScore();
					end;
					assert(topscore);
					local topgrade;
					local temp=#scores;
						if scores[1] then
							for i=1,temp do 
								topgrade = scores[1]:GetGrade();
								curgrade = scores[i]:GetGrade();
								assert(topgrade);
								if scores[1]:GetScore()>1  then
									if scores[1]:GetScore()==1000000 and scores[1]:GetGrade() =="Grade_Tier07" then --AutoPlayHack
										self:LoadBackground(THEME:GetPathG("myMusicWheel","Tier01"));
										self:diffusealpha(1);
										break;
									else --Normal
										if ToEnumShortString(curgrade) ~= "Failed" then --current Rank is not Failed
											self:LoadBackground(THEME:GetPathG("myMusicWheel",ToEnumShortString(curgrade)));
											self:diffusealpha(1);
											break;
										else --current Rank is Failed
											if i == temp then
												self:LoadBackground(THEME:GetPathG("myMusicWheel",ToEnumShortString(curgrade)));
												self:diffusealpha(1);
												break;
											end;
										end;
									end;
								else
									self:diffusealpha(0);
								end;
							end;
						else
							self:diffusealpha(0);
						end;
			else
				self:diffusealpha(0);
			end;
			
			(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_LEFT+OffsetX+135))(self);
		end;
	};
	
	scstringP1="";
	
	Def.RollingNumbers { -- Topscore
			File = THEME:GetPathF("_helveticaneuelt pro 65 md","24px");
			InitCommand=cmd(shadowlength,0;zoomy,0.80;zoomx,1.85;maxwidth,240;x,SCREEN_LEFT-OffsetX-40;y,SCREEN_CENTER_Y+194;horizalign,center;);
			OnCommand=function(self)
				if GAMESTATE:IsCourseMode() then
					self:Load("RollingNumbersCourseData");
				else
					--self:Load("RollingNumbersSongData");
					self:Load("RollingNumbersStageInScore");
				end
				self:diffuse(color("1,1,0.38,1"));
				self:strokecolor(color("0.0,0.0,0.0,1"));
				myScoreSet = StageTopRecord(PLAYER_1);
				
				if (myScoreSet["SongOrCourse"]==1) then
					if (myScoreSet["HasScore"]==1) then
					
						local topscore = myScoreSet["topscore"];
						
						self:diffusealpha(1);
						
						self:targetnumber(topscore);
						scstringP1 = topscore;
					else
						self:diffusealpha(1);

						self:targetnumber(0);
						scstringP1 = 0;
					end
				else
					self:diffusealpha(0);
				end
				(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_LEFT+OffsetX-40))(self);
			end;
	};
	

	--Topscore mod P1
	LoadFont("_helveticaneuelt pro 65 md 24px") .. {
		Text = scstringP1;

		InitCommand=cmd(shadowlength,0;zoomy,0.9;zoomx,1.98;maxwidth,240;x,SCREEN_LEFT-OffsetX-40;y,SCREEN_CENTER_Y+590;horizalign,right;);
		OnCommand=function(self)
			self:diffuse(color("1,1,0.28,1"));
			self:strokecolor(color("0.0,0.0,0.0,1"));

			(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_LEFT+OffsetX-40+100))(self);
		end;
	};

	

LoadFont("_helveticaneuelt pro 65 md 24px") .. {
	Text=PROFILEMAN:GetProfile(PLAYER_1):GetDisplayName();
	InitCommand=cmd(maxwidth,200;zoomy,0.8;zoomx,1.4;x,SCREEN_LEFT-OffsetX;y,SCREEN_CENTER_Y+222;horizalign,left;strokecolor,Color("Outline"));
	OnCommand=function(self)
		(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_LEFT+OffsetX-60-110))(self);
	end;
};



};


end


if GAMESTATE:IsPlayerEnabled(PLAYER_2) then


t[#t+1]=Def.ActorFrame{
	LoadActor("Score_Back_a")..{
	InitCommand=cmd(x,SCREEN_RIGHT+OffsetX;y,SCREEN_CENTER_Y+200;zoom,1.5);
		OnCommand=cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_RIGHT-OffsetX);
		
};
	
	LoadActor("../ScreenGameplay decorations/frame2")..{
	InitCommand=cmd(x,SCREEN_RIGHT+OffsetX+28;y,SCREEN_CENTER_Y+148;zoom,0.85);
		OnCommand=cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_RIGHT-OffsetX+28);
		
};
	--FC Ring
	LoadActor(THEME:GetPathG("StageIn","Spin FullCombo"))..{
	InitCommand=cmd(player,PLAYER_2;zoom,0.25;shadowlength,1;x,SCREEN_RIGHT+287-OffsetX;y,SCREEN_CENTER_Y+190;horizalign,center;draworder,2;);
	OnCommand=function(self)
			local SongOrCourse, StepsOrTrail;
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
				StepsOrTrail = GAMESTATE:GetCurrentTrail(PLAYER_2);
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
				StepsOrTrail = GAMESTATE:GetCurrentSteps(PLAYER_2);
			end;

			local profile, scorelist;
			local text = "";
			if SongOrCourse and StepsOrTrail then
				local st = StepsOrTrail:GetStepsType();
				local diff = StepsOrTrail:GetDifficulty();
				local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;

				if PROFILEMAN:IsPersistentProfile(PLAYER_2) then
					--player profile
					profile = PROFILEMAN:GetProfile(PLAYER_2);
				else
					--machine profile
					profile = PROFILEMAN:GetMachineProfile();
				end;

				scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
				
				assert(scorelist);
					local scores = scorelist:GetHighScores();
					assert(scores);
					local temp=#scores;
					local topscore=0;
					if scores[1] then
						topscore = scores[1]:GetScore();
					end;
					assert(topscore);
					local topgrade;
					if scores[1] then
						-- self:addx(-31);
						-- self:addy(13.5);
						for i=1,temp do 
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
								if (misses+boos) == 0 and scores[1]:GetScore() > 0 and (marvelous+perfects)>0 and (not hasUsedLittle) and topscore:GetGrade()~="Grade_Failed"  then
										if (goods+greats+perfects) == 0 then
												self:diffuse(GameColor.Judgment["JudgmentLine_W1"]);
												self:glowblink();
												self:effectperiod(0.20);
												self:zoom(0.25);
												break;
										elseif goods+greats == 0 then
												self:diffuse(GameColor.Judgment["JudgmentLine_W2"]);
												--self:glowshift();
												self:zoom(0.25);
												break;
										elseif (misses+boos+goods) == 0 then
												self:diffuse(BoostColor(GameColor.Judgment["JudgmentLine_W3"],0.75));
												self:stopeffect();
												self:zoom(0.25);
												if i==1 then
													self:diffuse(BoostColor(GameColor.Judgment["JudgmentLine_W3"],1));
												end;
												break;
										elseif (misses+boos) == 0 then
												self:diffuse(BoostColor(GameColor.Judgment["JudgmentLine_W4"],0.75));
												self:stopeffect();
												self:zoom(0.25);
												if i==1 then
													self:diffuse(BoostColor(GameColor.Judgment["JudgmentLine_W4"],1));
												end;
												break;
										end;
										
										self:diffusealpha(0.8);
										
								else
										self:diffusealpha(0);
								end;
							else
								self:diffusealpha(0);
								break;
							end;
						end;
					else
							self:diffusealpha(0);
					end;
			else
				self:diffusealpha(0);
			end;
			(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_RIGHT-OffsetX+167))(self);
		end;
	};
	
	Def.Quad{
	InitCommand=cmd(player,PLAYER_2;zoom,0.35;shadowlength,1;x,SCREEN_RIGHT+287-OffsetX;y,SCREEN_CENTER_Y+188;horizalign,center;draworder,2;);

		OnCommand=function(self)
			local SongOrCourse, StepsOrTrail;
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
				StepsOrTrail = GAMESTATE:GetCurrentTrail(PLAYER_2);
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
				StepsOrTrail = GAMESTATE:GetCurrentSteps(PLAYER_2);
			end;

			local profile, scorelist;
			local text = "";
			if SongOrCourse and StepsOrTrail then
				local st = StepsOrTrail:GetStepsType();
				local diff = StepsOrTrail:GetDifficulty();
				local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;

				if PROFILEMAN:IsPersistentProfile(PLAYER_2) then
					-- player profile
					profile = PROFILEMAN:GetProfile(PLAYER_2);
				else
					-- machine profile
					profile = PROFILEMAN:GetMachineProfile();
				end;

				scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
				assert(scorelist);
					local scores = scorelist:GetHighScores();
					assert(scores);
					local topscore=0;
					if scores[1] then
						topscore = scores[1]:GetScore();
					end;
					assert(topscore);
					local topgrade;
					local temp=#scores;
						if scores[1] then
							for i=1,temp do 
								topgrade = scores[1]:GetGrade();
								curgrade = scores[i]:GetGrade();
								assert(topgrade);
								if scores[1]:GetScore()>1  then
									if scores[1]:GetScore()==1000000 and scores[1]:GetGrade() =="Grade_Tier07" then --AutoPlayHack
										self:LoadBackground(THEME:GetPathG("myMusicWheel","Tier01"));
										self:diffusealpha(1);
										break;
									else --Normal
										if ToEnumShortString(curgrade) ~= "Failed" then --current Rank is not Failed
											self:LoadBackground(THEME:GetPathG("myMusicWheel",ToEnumShortString(curgrade)));
											self:diffusealpha(1);
											break;
										else --current Rank is Failed
											if i == temp then
												self:LoadBackground(THEME:GetPathG("myMusicWheel",ToEnumShortString(curgrade)));
												self:diffusealpha(1);
												break;
											end;
										end;
									end;
								else
									self:diffusealpha(0);
								end;
							end;
						else
							self:diffusealpha(0);
						end;
			else
				self:diffusealpha(0);
			end;
			
			(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_RIGHT-OffsetX+135))(self);
		end;
	};

	scstringP2 = "";
	
	Def.RollingNumbers { -- Topscore
			File = THEME:GetPathF("_helveticaneuelt pro 65 md","24px");
			InitCommand=cmd(shadowlength,0;zoomy,0.8;zoomx,1.85;maxwidth,240;x,SCREEN_RIGHT+OffsetX-40;y,SCREEN_CENTER_Y+194;horizalign,center;);
			OnCommand=function(self)
				if GAMESTATE:IsCourseMode() then
					self:Load("RollingNumbersCourseData");
				else
					--self:Load("RollingNumbersSongData");
					self:Load("RollingNumbersStageInScore");
				end
				self:diffuse(color("1,1,0.38,1"));
				self:strokecolor(color("0.0,0.0,0.0,1"));
				myScoreSet = StageTopRecord(PLAYER_2);
				
				if (myScoreSet["SongOrCourse"]==1) then
					if (myScoreSet["HasScore"]==1) then
					
						local topscore = myScoreSet["topscore"];
						
						self:diffusealpha(1);
						-- "999430"とかいう表示にしたいのに強制的に"999,430"のようにカンマが入る。書式とか
						self:targetnumber(topscore);
						scstringP2 = topscore;
						
					else
						self:diffusealpha(1);
						self:targetnumber(0);
						scstringP2 = 0;
					end
				else
					self:diffusealpha(0);
				end
				(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_RIGHT-OffsetX-40))(self);
			end;
};	

--Topscore mod P2
LoadFont("_helveticaneuelt pro 65 md 24px") .. {
	Text = scstringP2;

	InitCommand=cmd(shadowlength,0;zoomy,0.9;zoomx,1.98;maxwidth,240;x,SCREEN_RIGHT+OffsetX-40+120;y,SCREEN_CENTER_Y+590;horizalign,right;);
	OnCommand=function(self)
		self:diffuse(color("1,1,0.28,1"));
		self:strokecolor(color("0.0,0.0,0.0,1"));

		(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_RIGHT-OffsetX-60+120))(self);
	end;
};

LoadFont("_helveticaneuelt pro 65 md 24px") .. {
	Text=PROFILEMAN:GetProfile(PLAYER_2):GetDisplayName();
	InitCommand=cmd(maxwidth,200;zoomy,0.8;zoomx,1.4;x,SCREEN_RIGHT+OffsetX;y,SCREEN_CENTER_Y+222;horizalign,left;strokecolor,Color("Outline"));
	OnCommand=function(self)
		(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_RIGHT-OffsetX-60-110))(self);
	end;
};



};


end



if not GAMESTATE:IsCourseMode() then --Difficulty

	if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	t[#t+1]=LoadFont("_compacta blk bt 14px") .. {
		Text=THEME:GetString("CustomDifficulty",ToEnumShortString(GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()));
		InitCommand=cmd(maxwidth,240;zoomx,1.5;zoomy,1;x,SCREEN_LEFT-OffsetX-123;y,SCREEN_CENTER_Y+150;horizalign,center;diffuse,CustomDifficultyToColor( ToEnumShortString(GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()) ));
		OnCommand=function(self)
			(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_LEFT+OffsetX-123))(self);
		end;
	};

	end;
	if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	t[#t+1]=LoadFont("_compacta blk bt 14px") .. {
		Text=THEME:GetString("CustomDifficulty",ToEnumShortString(GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty()));
		InitCommand=cmd(maxwidth,240;zoomx,1.5;zoomy,1;x,SCREEN_RIGHT+OffsetX+123;y,SCREEN_CENTER_Y+150;horizalign,center;diffuse,CustomDifficultyToColor( ToEnumShortString(GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty()) ));
		OnCommand=function(self)
			(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_RIGHT-OffsetX+123))(self);
		end;
	};

	end;


else
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	t[#t+1]=LoadFont("_compacta blk bt 14px") .. {
		Text=THEME:GetString("CustomDifficulty",ToEnumShortString(GAMESTATE:GetCurrentTrail(PLAYER_1):GetDifficulty()));
		InitCommand=cmd(maxwidth,240;zoom,1.1;x,SCREEN_LEFT-OffsetX-125;y,SCREEN_CENTER_Y+149;horizalign,center;diffuse,CustomDifficultyToColor( ToEnumShortString(GAMESTATE:GetCurrentTrail(PLAYER_1):GetDifficulty()) ));
		OnCommand=function(self)
			(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_LEFT+OffsetX-125))(self);
		end;
	};

	end;
	if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	t[#t+1]=LoadFont("_compacta blk bt 14px") .. {
		Text=THEME:GetString("CustomDifficulty",ToEnumShortString(GAMESTATE:GetCurrentTrail(PLAYER_2):GetDifficulty()));
		InitCommand=cmd(maxwidth,240;zoom,1.1;x,SCREEN_RIGHT+OffsetX+125;y,SCREEN_CENTER_Y+149;horizalign,center;diffuse,CustomDifficultyToColor( ToEnumShortString(GAMESTATE:GetCurrentTrail(PLAYER_2):GetDifficulty()) ));
		OnCommand=function(self)
			(cmd(sleep,SleepOffset+1.8;linear,0.05;x,SCREEN_RIGHT-OffsetX+125))(self);
		end;
	};
	end;


end
	



return t;