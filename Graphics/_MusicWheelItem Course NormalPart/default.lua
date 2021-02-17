local sBannerPath = THEME:GetPathG("Common", "fallback jacket");
local sJacketPath = THEME:GetPathG("Common", "fallback jacket");
local bAllowJackets = true
local song;
local group;
local bannerPath;
--arrange song position devide by 3
 --function arrangeXPosition(myself, index)
--	 if index%3==0 then
--		 --myself:x(-300);
--		 myself:x(0);
--	 elseif index%3==1 then
--		 myself:x(0);
--	 else
--		 myself:x(0);
--	 end;
-- end

-- function arrangeXPosition2(myself, index, offset)
--	 if index%3==0 then
--		 --myself:x(-300+offset);
--		 myself:x(0+offset);
--	 elseif index%3==1 then
--		 myself:x(0+offset);
--	 else
--		 --myself:x(300+offset);
--		 myself:x(0+offset);
--	 end;
-- end


 --function arrangeYPosition(myself, index, offset)
--	 if index%999==499 then
--		 myself:y(0+offset);
--	 else
--		 myself:y(0+offset+(index*170));
--	 end;
-- end




function arrangeAllClearMarkOnWheelCourse(self,params,pn)
			local song = params.Song;
			local course = params.Course;
			local AllCleared = true;
			local WrostClearedRank = 1;
			local st=GAMESTATE:GetCurrentStyle():GetStyleType();
			
			if st == "StyleType_TwoPlayersTwoSides" then
				if pn == PLAYER_1 then
					self:cropright(0.5);
				else
					self:cropleft(0.5);
				end
			
			end;
			
			if song then
				local steps = SongUtil.GetPlayableSteps( song );
				
				arrangeXPosition(self,params.Index,0);

				if PROFILEMAN:IsPersistentProfile(pn) then 
					profile = PROFILEMAN:GetProfile(pn); --player profile
				else 
					profile = PROFILEMAN:GetMachineProfile(); --machine profile
				end;

				for i,step in ipairs(steps) do
					scorelist = profile:GetHighScoreList( song, step);
					
					local scores = scorelist:GetHighScores();
					local temp=#scores;
					local topscore=0;
					if scores[1] then
						topscore = scores[1]:GetScore();
					end;
					local topgrade;
					
					if scores[1] then   -- 7=Failed  6=D  5=C  4=B  3=A  2=AA  1=AAA
						for i=1,temp do 
							topgrade = scores[1]:GetGrade();
							curgrade = scores[i]:GetGrade();
							if scores[1]:GetScore()>1  then
								if scores[1]:GetScore()==1000000 and topgrade=="Grade_Tier07" then --AutoPlayHack
									AllCleared = AllCleared and false;
									WrostClearedRank = 7;
									break;
								else --Normal
									if ToEnumShortString(curgrade) ~= "Failed"  then --not failed
										AllCleared = AllCleared and true;
										local gradenum = tonumber(string.sub(curgrade,-2,-1));
										if WrostClearedRank <  gradenum then
											WrostClearedRank = gradenum;
										end
										break;
									else --failed
										if i == temp then
											AllCleared = AllCleared and true;
											WrostClearedRank = 7;
											break;
										
										end;
									end;
								end;
							else
								AllCleared = AllCleared and false;
							end;
						end;
					else
						AllCleared = AllCleared and false;
					end
				end;
				
				if AllCleared == true then 
					self:diffusealpha(1);
					---(cmd(diffuseshift;effectcolor1,1,1,1,0.65;effectcolor2,1,1,1,0.8;effectperiod,0.1))(self);
					if WrostClearedRank == 7 then --E
						(cmd(diffuseshift;effectcolor1,0,0,0,0.65;effectcolor2,0,0,0,1;effectperiod,1.1))(self);
					elseif WrostClearedRank == 6 then --D
						(cmd(diffuseshift;effectcolor1,0.6,0,0,0.65;effectcolor2,0.8,0,0,1;effectperiod,0.5))(self);
					elseif WrostClearedRank == 5 then --C
						(cmd(diffuseshift;effectcolor1,1,0,1,0.65;effectcolor2,1,0,1,0.35;effectperiod,0.5))(self);
					elseif WrostClearedRank == 4 then --B
						(cmd(diffuseshift;effectcolor1,0,0.3,1,0.65;effectcolor2,0,0.5,1,0.9;effectperiod,0.1))(self);
					elseif WrostClearedRank == 3 then --A
						(cmd(diffuseshift;effectcolor1,1,1,0.2,0.65;effectcolor2,1,1,0.2,0.35;effectperiod,0.1))(self);
					elseif WrostClearedRank == 2 then --AA
						(cmd(diffuseshift;effectcolor1,1,1,0.6,0.65;effectcolor2,1,1,0.7,1;effectperiod,0.1))(self);
					elseif WrostClearedRank == 1 then --AAA
						(cmd(diffuseshift;effectcolor1,1,1,1,0.65;effectcolor2,1,1,1,0.8;effectperiod,0.1))(self);
					end
				else
					self:diffusealpha(0);
				end
				
				if params.HasFocus then
					self:zoom(2.2);
				else
					self:zoom(1.8);
				end
			end
end

function GetSongBanner(song)
	if song then
		local path = song:GetBannerPath()
		if path then return path end
	end
	return THEME:GetPathG("Common","fallback banner")
end

function GetSongBg(song)
	if song then
		local path = song:GetBackgroundPath()
		if path then return path end
	end
	return THEME:GetPathG("Common","fallback background")
end
--main backing
local t = Def.ActorFrame {
	SetMessageCommand=function(s,p)
		--[[if p.Index then
			arrangeXPosition(s,p.Index,0)
		end]]
	end,


--border bright
LoadActor(THEME:GetPathG("MusicWheelItem Song","NormalPart/bright"))..{
		InitCommand=cmd(zoom,0);
		SetMessageCommand=function(self,params)
			if params.HasFocus then
				self:zoom(2.2);
				(cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.5;effectclock,'beatnooffset'))(self);
				--(cmd(thump;effectclock,'beat';effectmagnitude,1.0,1.05,1.0;effectoffset,0.20;))(self);
			else
				self:zoom(0);
			end
		end;
		};

--border default
LoadActor(THEME:GetPathG("MusicWheelItem Song","NormalPart/bg01"))..{
		InitCommand=cmd(zoom,1.8);
		SetMessageCommand=function(self,params)
			if params.HasFocus then
				self:zoom(2.2);
			else
				self:zoom(1.8);
			end
		end;
		};
		LoadActor(THEME:GetPathG("MusicWheelItem Song","NormalPart/bg01"))..{
		InitCommand=cmd(zoom,1.8;diffusecolor,Color("Yellow");blend,Blend.Add;diffusealpha,0.5;thump;effectclock,'beat';effectmagnitude,1.0,1.05,1.0;effectoffset,0.35;);
		SetMessageCommand=function(self,params)
			if params.HasFocus then
				self:zoom(2.2);
			else
				self:zoom(0);
			end
		end;
		};	



Def.Quad {
	InitCommand=cmd(setsize,224,224;y,-5;diffuse,color("#000000"));
	SetMessageCommand=function(self,params)
		if params.HasFocus then
				self:zoom(0.9);
			else
				self:zoom(0.7);
			end
	end;
	};
--banner
	Def.Sprite {
		Name="Banner";
		InitCommand=cmd(scaletoclipped,220,220;y,-5);
		BannerCommand=cmd(scaletoclipped,220,220);
		JacketCommand=cmd(scaletoclipped,220,220);
		SetMessageCommand=function(self,params)
			local Song = params.Song;
			local Course = params.Course;
			if Song then
				if ( Song:GetJacketPath() ~=  nil ) and ( bAllowJackets ) then
					self:Load( Song:GetJacketPath() );
					self:playcommand("Jacket");
				elseif ( Song:GetBannerPath() ~= nil ) then
					self:Load( Song:GetBannerPath() );
					self:playcommand("Banner");
				elseif ( Song:GetBackgroundPath() ~= nil ) and ( bAllowJackets ) then
					self:Load( Song:GetBackgroundPath() );
					self:playcommand("Jacket");
				else
				  self:Load( bAllowJackets and sBannerPath or sJacketPath );
				  self:playcommand( bAllowJackets and "Jacket" or "Banner" );
				end;
			elseif Course then
				if ( Course:GetBackgroundPath() ~= nil ) and ( bAllowJackets ) then
					self:Load( Course:GetBackgroundPath() );
					self:playcommand("Jacket");
				elseif ( Course:GetBannerPath() ~= nil ) then
					self:Load( Course:GetBannerPath() );
					self:playcommand("Banner");
				else
					self:Load( sJacketPath );
					self:playcommand( bAllowJackets and "Jacket" or "Banner" );
				end
			else
				self:Load( bAllowJackets and sJacketPath or sBannerPath );
				self:playcommand( bAllowJackets and "Jacket" or "Banner" );
			end;
			if params.HasFocus then
				self:zoom(0.9);
			else
				self:zoom(0.7);
			end
		end;
	};
--banner effect
	Def.Sprite {
		Name="Banner";
		InitCommand=cmd(scaletoclipped,220,220;y,-5);
		BannerCommand=cmd(scaletoclipped,220,220);
		JacketCommand=cmd(scaletoclipped,220,220);
		SetMessageCommand=function(self,params)
			local Song = params.Song;
			local Course = params.Course;
			if Song then
				if ( Song:GetJacketPath() ~=  nil ) and ( bAllowJackets ) then
					self:Load( Song:GetJacketPath() );
					self:playcommand("Jacket");
				elseif ( Song:GetBannerPath() ~= nil ) then
					self:Load( Song:GetBannerPath() );
					self:playcommand("Banner");
				elseif ( Song:GetBackgroundPath() ~= nil ) and ( bAllowJackets ) then
					self:Load( Song:GetBackgroundPath() );
					self:playcommand("Jacket");
				else
				  self:Load( bAllowJackets and sBannerPath or sJacketPath );
				  self:playcommand( bAllowJackets and "Jacket" or "Banner" );
				end;
			elseif Course then
				if ( Course:GetBackgroundPath() ~= nil ) and ( bAllowJackets ) then
					self:Load( Course:GetBackgroundPath() );
					self:playcommand("Jacket");
				elseif ( Course:GetBannerPath() ~= nil ) then
					self:Load( Course:GetBannerPath() );
					self:playcommand("Banner");
				else
					self:Load( sJacketPath );
					self:playcommand( bAllowJackets and "Jacket" or "Banner" );
				end
			else
				self:Load( bAllowJackets and sJacketPath or sBannerPath );
				self:playcommand( bAllowJackets and "Jacket" or "Banner" );
			end;
			if params.HasFocus then
				self:zoom(0.9);
				(cmd(blend,Blend.Add;diffusealpha,0.4;thump;effectclock,'beat';effectmagnitude,1.0,1.1,1.0;effectoffset,0.35))(self);
			else
				self:zoom(0);
			end
		end;
	};

	LoadFont("_open sans semibold 24px")..{
		InitCommand=cmd(y,110;zoomx,1;maxwidth,235;diffuse,Color("White");strokecolor,color("0.15,0.15,0.0,0.9"));
		SetCommand=function(self,params)
			local song = params.Song;
			local index= params.Index;
			local numItems = params.Items;
			local course = params.Course;
			local tit="";
			if song and not course then
				tit=song:GetDisplayFullTitle();
			elseif course and not song then
				tit=course:GetDisplayFullTitle();
			end;
			-- if string.len(tit)>20 then
				-- tit = string.sub(tit, 1, 21).."...";
			-- end;
			self:stoptweening();
			self:settextf("%s",tit);
			--self:settextf("%d",index);
			self:y(110);
			if params.HasFocus then
				self:addy(23);
				self:zoom(1.3);
			else
				self:addy(0);
				self:zoom(1.05);
			end
		end;
		
	};

	
	-- LoadActor("AllCleared_All")..{-- P1 All Clear Mark
		-- InitCommand=cmd(zoom,0;player,PLAYER_1);
		-- SetMessageCommand=function(self,params)
			-- arrangeAllClearMarkOnWheelCourse(self,params,PLAYER_1)
		-- end;
	-- };
	
	-- LoadActor("AllCleared_All")..{-- P2 All Clear Mark
		-- InitCommand=cmd(zoom,0;player,PLAYER_2);
		-- SetMessageCommand=function(self,params)
			-- arrangeAllClearMarkOnWheelCourse(self,params,PLAYER_2)
		-- end;
	-- };



	--Selection cursor
	Def.ActorFrame {
		LoadActor( "cursor" )..{
			InitCommand=cmd();
			SetCommand=function(self,params)
				
				(cmd(bounce;effectmagnitude,12,0,0;effectclock,'beatnooffset'))(self);
				if params.HasFocus then
					self:zoom(2.2);
				else
					self:zoom(0);
				end
			end;
			
			OffCommand=cmd(sleep,0.2;linear,0;diffusealpha,0);
		}
	};

	Def.ActorFrame {
		LoadActor( "cursor" )..{
			InitCommand=cmd(zoomx,-1);
			SetCommand=function(self,params)
				
				(cmd(bounce;effectmagnitude,-12,0,0;effectclock,'beatnooffset'))(self);
				if params.HasFocus then
					self:zoomy(2.2);
					self:zoomx(-2.2);
				else
					self:zoom(0);
				end
			end;
			OffCommand=cmd(sleep,0.2;linear,0;diffusealpha,0);
		}
	};

	LoadActor("bgNew") .. {
		InitCommand=cmd(finishtweening;draworder,1;zoom,2);
		SetCommand=function(self,param)
			if param.Song then
				if PROFILEMAN:IsSongNew(param.Song) then
					self:visible(true);
				else
					self:visible(false);
				end
			else
				self:visible(false);
			end
			if param.HasFocus then
				self:zoom(2.2);
			else
				self:zoom(1.8);
			end
		end;
	};
};

--[[for pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	t[#t+1] = loadfile(THEME:GetPathG("MusicWheelItem","Course NormalPart/grade.lua"))(pn)..{
		SetCommand=function(s,p)
			if p.Index then
				arrangeXPosition(s,p.Index,0)
				arrangeYPosition(s,p.Index,0)
			end
			if p.HasFocus then
				s:zoom(2.2)
			else
				s:zoom(1.8)
			end
		end
	}
end]]

--[[if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	t[#t+1] = LoadActor("grade1.lua")..{
	SetCommand=function(self,param)
		if params.Index then
			arrangeXPosition(self,param.Index,0);
			arrangeYPosition(self,param.Index,0);
		end
		if param.HasFocus then
				self:zoom(2.2);
			else
				self:zoom(1.8);
			end
	end;
	};
end;

if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	t[#t+1] = LoadActor("grade2.lua")..{
	SetCommand=function(self,param)
		if params.Inde
		arrangeXPosition(self,param.Index,0);
		arrangeYPosition(self,param.Index,0);
		if param.HasFocus then
				self:zoom(2.2);
			else
				self:zoom(1.8);
			end
	end;
	};
end;]]

if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	t[#t+1] = LoadActor("diff1.lua")..{
	SetCommand=function(self,param)
		if param.HasFocus then
				self:zoom(1.28);
			else
				self:zoom(1.03);
			end
	end;
	};
end;

if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	t[#t+1] = LoadActor("diff2.lua")..{
	SetCommand=function(self,param)
		if param.HasFocus then
				self:zoom(1.28);
			else
				self:zoom(1.03);
			end
	end;
	};
end;

return t;