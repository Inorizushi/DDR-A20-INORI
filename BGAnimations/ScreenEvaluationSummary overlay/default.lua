-- Base from CyberiaStyle 7 by gl_yukt

local st = GAMESTATE:GetCurrentStyle():GetStepsType();
local mStages = STATSMAN:GetStagesPlayed();
local i = 0;

local DifficultyToFrame = {
	Difficulty_Beginner	= color("#1cd8ff"),
	Difficulty_Easy		= color("#ffaa19"),
	Difficulty_Medium	= color("#ff1e3c"),
	Difficulty_Hard		= color("#32eb19"),
	Difficulty_Challenge	= color("#eb1eff"),
	Difficulty_Edit 	= color("#afafaf"),
	Difficulty_None		= color("#000000"),
};

local t = Def.ActorFrame {};  

-- Grade back
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:x(SCREEN_CENTER_X);
		self:y(SCREEN_CENTER_Y);
		if mStages == 1 then
			self:addy(0);
		elseif mStages == 2 then
			self:addy(0);
		elseif mStages == 3 then
			self:addy(0);
		elseif mStages == 4 then
			self:addy(0);
		elseif mStages == 5 then
			self:addy(5);
		elseif mStages == 6 then
			self:addy(5);
		elseif mStages == 7 then
			self:addy(5);
		else
			self:addy(0);
		end;
	end;

	LoadActor("Grade_Back") .. {
		BeginCommand=function(self)
		--	self:vertalign(center);
		    self:y(30);
			self:zoomtoheight(0);
			self:linear(0.25);
			if mStages == 1 then
				self:zoomtoheight(256);
				self:zoomtowidth(SCREEN_WIDTH);
			elseif mStages == 2 then
				self:zoomtoheight(256);
				self:zoomtowidth(SCREEN_WIDTH);
			elseif mStages == 3 then
				self:zoomtoheight(256);
				self:zoomtowidth(SCREEN_WIDTH);
			elseif mStages == 4 then
				self:zoomtoheight(330);
				self:zoomtowidth(SCREEN_WIDTH);
			elseif mStages == 5 then
				self:zoomtoheight(400);
				self:zoomtowidth(SCREEN_WIDTH);
			elseif mStages == 6 then
				self:zoomtoheight(470);
				self:zoomtowidth(SCREEN_WIDTH);
			elseif mStages == 7 then
				self:y(50);
				self:zoomtoheight(510);
				self:zoomtowidth(SCREEN_WIDTH);
			else
				self:zoomtoheight(400);
				self:zoomtowidth(SCREEN_WIDTH);
			end;
		end;
		OffCommand=cmd(sleep,0.25;linear,0.25;zoomy,0);
	};
};


function setLableY(myself, mstages)
	if mstages == 1 then
		myself:y(240-34);
	elseif mstages == 2 then
		myself:y(240-64);
	elseif mstages == 3 then
		myself:y(240-94);
	elseif mstages ==4 then
		myself:y(240-124);
	elseif mstages ==5 then
		myself:y(240-154);
	elseif mstages ==6 then
		myself:y(240-184);
	elseif mstages ==7 then
		myself:y(240-214);
	else
		myself:y(360-84);
	end;
end

-----PlayerDisplay
t[#t+1] = LoadActor("p1result") ..{
	InitCommand = function(self)
		self:player('PlayerNumber_P1');
		self:x(SCREEN_LEFT+65);
		--self:Load(THEME:GetPathB("SummaryPlayerDisplay","P1"));
		setLableY(self, mStages);
		
	end;
	OnCommand=cmd(zoomy,0;zoomx,1.25;diffusealpha,0;sleep,0.1,linear,0.2;zoomy,0;diffusealpha,1);
	OffCommand=cmd(linear,0.15;addx,-300);
}

t[#t+1] = LoadActor("p1result")..{
		InitCommand=cmd(x,SCREEN_LEFT+80;y,SCREEN_CENTER_Y-268-3;player,PLAYER_1;zoom,1.5);
		OffCommand=cmd(linear,0.15;addx,-300);
	};


-----PlayerDisplay
t[#t+1] = LoadActor("p2result") ..{
	InitCommand = function(self)
		self:player('PlayerNumber_P2');
		self:x(SCREEN_RIGHT-65);
		--self:Load(THEME:GetPathB("SummaryPlayerDisplay","P2"));
		setLableY(self, mStages);
		
	end;
	OnCommand=cmd(zoomy,0;zoomx,1.25;diffusealpha,0;sleep,0.1,linear,0.2;zoomy,0;diffusealpha,1);
	OffCommand=cmd(linear,0.15;addx,300);
}

t[#t+1] = LoadActor("p2result")..{
		InitCommand=cmd(x,SCREEN_RIGHT-80;y,SCREEN_CENTER_Y-268-3;player,PLAYER_2;zoom,1.5);
		OffCommand=cmd(linear,0.15;addx,300);
	};

-- Center
for i = 1, mStages do
	local ssStats = STATSMAN:GetPlayedStageStats( i );
	t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(Center);
		BeginCommand=function(self)
			if mStages == 2 then
				self:addy(-25 + ((mStages - i) * 68));
			elseif mStages == 3 then
				self:addy(-50 + ((mStages - i) * 68));
			elseif mStages == 4 then
				self:addy(-75 + ((mStages - i) * 68));
			elseif mStages == 5 then
				self:addy(-100 + ((mStages - i) * 68));
			elseif mStages == 6 then
				self:addy(-125 + ((mStages - i) * 68));
			elseif mStages == 7 then
				self:addy(-150 + ((mStages - i) * 68));
			else
				self:addy(((mStages - i) * 68));
			end;
		end;

		LoadActor( "BannerCenter" ) .. {
			InitCommand=cmd(diffusealpha,0;y,10);
			OnCommand=cmd(sleep,0.25;diffusealpha,1);
			OffCommand=cmd(diffusealpha,0);
		};
		
		-- banner line
		Def.Quad {
			BeginCommand=function(self)
				local sssong = ssStats:GetPlayedSongs()[1];
				self:x(-170);
				self:y(11);
				self:zoomto(50,50);
				self:diffuse(color("#000000"));
			end;
			OnCommand=function(self) 
				self:zoomy(0);
				self:sleep(0.25+(i-mStages)*-0.1);
				self:linear(0.2); 
				self:zoomto(50,50);
			end;
			OffCommand=cmd(linear,0.25;zoomy,0);						
		};
		
		-- banner
		Def.Banner {
			BeginCommand=function(self)
				local sssong = ssStats:GetPlayedSongs()[1];
				self:x(-170);
				self:y(11);
				if sssong:HasJacket() then
					self:LoadBackground(sssong:GetJacketPath());
					self:zoomto(48,48);
				elseif sssong:HasBackground() then
					self:LoadFromSongBackground(sssong);
					self:zoomto(48,48);
				else
					self:Load(THEME:GetPathG("","Common fallback jacket"));
					self:zoomto(48,48);
				end;
			end;
			OnCommand=function(self) 
				local sssong = ssStats:GetPlayedSongs()[1];
				if sssong:HasJacket() then
					self:LoadBackground(sssong:GetJacketPath());
					self:zoomto(48,48);
				elseif sssong:HasBanner() then
					self:LoadFromSongBanner(sssong);
					self:zoomto(48,48);
				else
					self:Load(THEME:GetPathG("","Common fallback jacket"));
					self:zoomto(48,48);
				end;
				self:zoomy(0);
				self:sleep(0.25+(i-mStages)*-0.1);
				self:linear(0.2);
				self:zoomy(1);
				self:zoomto(48,48);
			end;
			OffCommand=cmd(linear,0.25;zoomy,0);						
		};
		
		-- Title
		LoadFont("_arial black 28px")..{
			InitCommand=cmd(zoomx,0.7;maxwidth,463;diffuse,color("#ffffff"));
			BeginCommand=function(self)
				local sssong = ssStats:GetPlayedSongs()[1];
				local sssmaint = sssong:GetDisplayFullTitle();
				self:x(26);
				self:settext(sssmaint);
				if sssong:GetDisplaySubTitle() == "" then
					self:y(0);
				else
					self:y(0);
				end;
				self:addy(8);
			end;
			OnCommand=function(self) 
				self:zoomy(0);
				self:sleep(0.25+(i-mStages)*-0.1);
				self:linear(0.2); 
				self:zoomy(0.7);
			end;
			OffCommand=cmd(diffusealpha,0);	
		};
		
		-- SubTitle
		-- LoadFont("Common Normal")..{
			-- InitCommand=cmd(zoomx,0.8;maxwidth,383;diffuse,color("#ffffff");strokecolor,color("#000000"));
			-- BeginCommand=function(self)
				-- local sssong = ssStats:GetPlayedSongs()[1];
				-- local ssssubt = sssong:GetDisplaySubTitle();
				-- self:x(26);
				-- self:y(0.6);
				-- self:settext(ssssubt);
				-- if sssong:GetDisplaySubTitle() ~= "" then
					-- self:visible(true);
				-- else
					-- self:visible(false);
				-- end;
			-- end;
			-- OnCommand=function(self) 
				-- self:zoomy(0);
				-- self:sleep(0.25+(i-mStages)*-0.1);
				-- self:linear(0.2); 
				-- self:zoomy(0.8);
			-- end;
			-- OffCommand=cmd(diffusealpha,0);	
		-- };
		
		-- Artist
		LoadFont("_arial black 28px")..{
			InitCommand=cmd(zoomx,0.5;maxwidth,393;diffuse,color("#ffffff");diffusealpha,0);
			BeginCommand=function(self)
				local sssong = ssStats:GetPlayedSongs()[1];
				local sssartistt = sssong:GetDisplayArtist();
				if sssong:GetDisplaySubTitle() == "" then
					self:y(20);
				else
					self:y(20);
				end;
				self:x(26);
				self:settext(sssartistt);
			end;
			OnCommand=function(self) 
				self:zoomy(0);
				self:sleep(0.25+(i-mStages)*-0.1);
				self:linear(0.2); 
				self:zoomy(0.5);
			end;
			OffCommand=cmd(diffusealpha,0);	
		};
	};
end;

for pn in ivalues(PlayerNumber) do
	for i = 1, mStages do
	
		if GAMESTATE:IsPlayerEnabled(pn) == true then
			
			
			local sStats = STATSMAN:GetPlayedStageStats( i );
			local pStageStats = sStats:GetPlayerStageStats( pn );

			-- FullComboColor base from Default Extended by A.C
			local function GetFullComboEffectColor(pStageStats)
				local r;
					if pStageStats:FullComboOfScore('TapNoteScore_W1') then
						r=color("#fefed0");
					elseif pStageStats:FullComboOfScore('TapNoteScore_W2') then
						r=color("#f8fd6d");
					elseif pStageStats:FullComboOfScore('TapNoteScore_W3') then
						r=color("#01e603");
					elseif pStageStats:FullComboOfScore('TapNoteScore_W4') then
						r=color("#10e0f1");
					end;
				return r;
			end;
			
			
			
			
			t[#t+1] = Def.ActorFrame {
				InitCommand=cmd(player,pn;Center);
				BeginCommand=function(self) 
					if mStages == 2 then
						self:addy(-25 + ((mStages - i) * 68));
					elseif mStages == 3 then
						self:addy(-50 + ((mStages - i) * 68));
					elseif mStages == 4 then
						self:addy(-75 + ((mStages - i) * 68));
					elseif mStages == 5 then
						self:addy(-100 + ((mStages - i) * 68));
					elseif mStages == 6 then
						self:addy(-125 + ((mStages - i) * 68));
					elseif mStages == 7 then
						self:addy(-150 + ((mStages - i) * 68));
					else
						self:addy(((mStages - i) * 68));
					end;
				end;
				OffCommand=function(self) 
					if pn == PLAYER_1 then
						self:linear(0.4); 
						self:addx(-SCREEN_WIDTH);
					else
						self:linear(0.4); 
						self:addx(SCREEN_WIDTH);
					end
					
				end;
				
				-- Label
				LoadActor( "label_under" ) .. {
					InitCommand=cmd(horizalign,right);
					OnCommand=function(self) 
						if pn == PLAYER_1 then
							self:x(-SCREEN_WIDTH);
							self:sleep(0.05+(i-mStages)*-0.1);
							self:linear(0.4); 
							self:x(-230);
							self:y(10);
							self:zoomy(1.37);
						else
							self:rotationy(180);
							self:x(SCREEN_WIDTH);
							self:sleep(0.05+(i-mStages)*-0.1);
							self:linear(0.4); 
							self:x(230);
							self:y(10);
							self:zoomy(1.37);
						end
					end;
				};
				
				-- difficulty
				LoadActor("label_color") .. {
					InitCommand=cmd(horizalign,right);
					BeginCommand=function(self)
					------------------------------
					
						local p1ssstats = sStats:GetPlayerStageStats(pn);
						local diff1 = STATSMAN:GetPlayedStageStats(i):GetPlayerStageStats(pn):GetPlayedSteps();
						local p1ssstep = diff1[1]:GetDifficulty();
						local p1statediff = DifficultyToFrame[p1ssstep];
						if sStats then
							self:diffuse(p1statediff);
							self:visible(true);	
						else
							self:visible(false);
						end
						self:x(-146);
					end;
					OnCommand=function(self) 
						if pn == PLAYER_1 then
							self:x(-SCREEN_WIDTH);
							self:sleep(0.05+(i-mStages)*-0.1);
							self:linear(0.4); 
							self:x(-220);
							self:y(10);
							self:zoomy(1.37);
							self:zoomx(1.4);
						else
							self:rotationy(180);
							self:x(SCREEN_WIDTH);
							self:sleep(0.05+(i-mStages)*-0.1);
							self:linear(0.4); 
							self:x(220);
							self:y(10);
							self:zoomy(1.37);
							self:zoomx(1.4);
						end
					end;
				};

				-- fullcombo
				LoadActor(THEME:GetPathB("ScreenEvaluationSummary","overlay/FullCombo")) .. {
					InitCommand=cmd();
					BeginCommand=function(self)
						if pn == PLAYER_1 then
							self:x(-250+12-10);
						else
							self:x(250+41+12);
						end
						self:y(18);
						local grade = pStageStats:GetGrade();
						if grade ~= "Grade_Tier08" then
							if pStageStats:FullComboOfScore('TapNoteScore_W1') or pStageStats:FullComboOfScore('TapNoteScore_W2') or pStageStats:FullComboOfScore('TapNoteScore_W3') or pStageStats:FullComboOfScore('TapNoteScore_W4') then
								self:diffuse(GetFullComboEffectColor(pStageStats)); 
								self:visible(true);
							else
								self:visible(false);
							end
						else
							self:visible(false);
						end;
					end;
					OnCommand=function(self) 
						self:zoom(0);
						self:sleep(0.45+(i-mStages)*-0.1);
						self:linear(0.4); 
						self:zoom(0.4);
					end;
				};

				-- grade
				Def.Sprite {
					InitCommand=cmd(zoom,0.8;diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.8;effectperiod,0.2;y,10);
					BeginCommand=function(self) 
						local Grade = pStageStats:GetGrade();
						self:LoadBackground(THEME:GetPathG("myMusicWheel",ToEnumShortString(Grade)));
						if pn == PLAYER_1 then
							self:addx(-280-10);
						
						else
							self:addx(260);
							
						end
					end;
					OnCommand=function(self) 
						self:zoomy(0);
						self:sleep(0.45+(i-mStages)*-0.1);
						self:linear(0.4); 
						self:zoomy(0.8);
						
					end;
				};
			
				-- stage
				LoadFont("_itc avant garde pro 20px")..{
					InitCommand=cmd(zoom,0.9;diffuse,color("#ffffff");strokecolor,color("#333333");maxwidth,160);
					BeginCommand=function(self)
						local pStage = sStats:GetStage();
						local stageText = StageToLocalizedString(pStage).." STAGE";
						if pn == PLAYER_1 then
							self:addx(-203-160);
							self:horizalign(left);
						else
							self:addx(203+24);
							self:horizalign(left);
						end
						self:addy(-12);
						self:settext(stageText);
					end;
					OnCommand=function(self) 
						if pn == PLAYER_1 then
							self:x(-SCREEN_WIDTH);
							self:sleep(0.05+(i-mStages)*-0.1);
							self:linear(0.4); 
							self:x(-310-160);
							self:y(0);
						else
							self:x(SCREEN_WIDTH);
							self:sleep(0.05+(i-mStages)*-0.1);
							self:linear(0.4); 
							self:x(310+24);
							self:y(0);
						end
					end;
				};
				
				-- Score
				Def.RollingNumbers {
					File=THEME:GetPathF("_itc avant garde pro","20px");
					InitCommand=cmd(Load,"RollingNumbersScore";zoom,1.2;diffusealpha,0;diffuse,color("#ffffff");strokecolor,color("#000000"));
					BeginCommand=function(self)
						-- local sStats = STATSMAN:GetPlayedStageStats(i);
						local pss = sStats:GetPlayerStageStats(pn);-------------------------------
						local song = sStats:GetPlayedSongs()[1];
						local diff = pss:GetPlayedSteps()[1]:GetDifficulty();
						local steps = song:GetOneSteps( st, diff );
						local radar = steps:GetRadarValues(pn);
						local maxsteps = math.max(radar:GetValue('RadarCategory_TapsAndHolds')+radar:GetValue('RadarCategory_Holds')+radar:GetValue('RadarCategory_Rolls'),1);
						self:targetnumber(GetEvaScore(maxsteps,pss,pn));
						if pn == PLAYER_1 then
							self:horizalign(right);
							self:x(-204-20);
						else
							self:horizalign(left);
							self:x(204+24);
						end
						self:y(8);
					end;
					OnCommand=function(self)
						if pn == PLAYER_1 then
							self:x(-SCREEN_WIDTH);
							self:sleep(0.05+(i-mStages)*-0.1);
							self:linear(0.4); 
							self:x(-310-20);
							self:y(23);
						else
							self:x(SCREEN_WIDTH);
							self:sleep(0.05+(i-mStages)*-0.1);
							self:linear(0.4); 
							self:x(310+24);
							self:y(23);
						end
					end;
				};
			};
		end;
	end;
end;

local lang = "en";
if THEME:GetCurLanguage() == "ja" then
	lang = "jp";
end;

t[#t+1] = Def.ActorFrame {
	LoadActor( "../../Graphics/ScreenWithMenuElements footer/"..lang.."_skip" )..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-40;zoom,0.7);
	OnCommand=cmd(linear,0.2;addy,-8);
	OffCommand=cmd(linear,0.2;addy,100);
	};
};


	t[#t+1] = LoadFont("_commador extended 32px").. {

			InitCommand=function(self)

				local dispnameP1 = PROFILEMAN:GetProfile(PLAYER_1):GetDisplayName();
				local dispnamelengthP1 = string.len(dispnameP1);

				self:player(PLAYER_1);
				self:horizalign(right);
				self:settext(string.upper(dispnameP1));
				self:x(SCREEN_CENTER_X-474);self:y(SCREEN_CENTER_Y-268.8);
				self:draworder(50);
				self:diffuse(color("#feec0a"));
				self:zoomy(0.74);

				if dispnamelengthP1 >= 8 then
					--expand
					self:maxwidth(80*1.0);
					self:zoomx(1.69*1.0);
				else
					--constant width
					self:zoomx(1.02*1.0);
				end;

			end;
			
			OffCommand=cmd(linear,0.15;addx,-300);
			
	};
	t[#t+1] = LoadFont("_commador extended 32px").. {

			InitCommand=function(self)

				local dispnameP2 = PROFILEMAN:GetProfile(PLAYER_2):GetDisplayName();
				local dispnamelengthP2 = string.len(dispnameP2);

				self:player(PLAYER_2);
				self:horizalign(left);
				self:settext(string.upper(dispnameP2));
				self:x(SCREEN_CENTER_X+474);self:y(SCREEN_CENTER_Y-268.8);
				self:draworder(50);
				self:diffuse(color("#feec0a"));
				self:zoomy(0.74);

				if dispnamelengthP2 >= 8 then
					--expand
					self:maxwidth(80*1.0);
					self:zoomx(1.69*1.0);
				else
					--constant width
					self:zoomx(1.02*1.0);
				end;

			end;
			
			OffCommand=cmd(linear,0.15;addx,300);
	};

return t