function GetLocalProfiles()
	local t = {};

	for p = 0,PROFILEMAN:GetNumLocalProfiles()-1 do
		local profile=PROFILEMAN:GetLocalProfileFromIndex(p);
		local ProfileCard = Def.ActorFrame {

			LoadFont("_dfphsgothic-w9") .. {
				Text=profile:GetDisplayName();
				InitCommand=cmd(maxwidth,150;diffusealpha,0.3;shadowlength,1;y,-10;zoomx,0.8;zoomy,0.8;ztest,true);
				OffCommand=cmd(linear,0.3;zoomy,0;diffusealpha,0);
			};
			LoadFont("_dfghsgothic-w7") .. {
				InitCommand=cmd(maxwidth,150;diffusealpha,0.3;shadowlength,1;y,8;zoom,0.5;vertspacing,-8;ztest,true);
				BeginCommand=function(self)
					local numSongsPlayed = profile:GetNumTotalSongsPlayed();
					local s = numSongsPlayed == 1 and "Song" or "Songs";
					local numLevel =  math.ceil(numSongsPlayed);
					-- todo: localize
					--self:settext( numSongsPlayed.." "..s.." Played" );
					self:settext("TOTAL STAGES: "..numLevel);
				end;
				OffCommand=cmd(linear,0.3;zoomy,0;diffusealpha,0);
			};
			
		};
		t[#t+1]=ProfileCard;
	end;

	
	return t;
end;
local profnum = PROFILEMAN:GetNumLocalProfiles();
local keyset = {0,0}

--�d�����e����E--------------------------
function LoadCard(cColor,cColor2,Player,IsJoinFrame)
	local t = Def.ActorFrame {
		LoadActor( THEME:GetPathG("ScreenSelectProfile","CardBackground") ) .. {
			InitCommand=cmd(shadowlength,0;zoomx,0.62;zoomy,0;diffuse,cColor);
			OnCommand=cmd(sleep,0.3;linear,0.3;zoomy,0.75;);
			OffCommand=function(self)
				if IsJoinFrame then
					(cmd(sleep,0.5;linear,0.2;zoomy,0.100;diffusealpha,0))(self);
				else
					(cmd(linear,0.2;zoomy,0.100;diffusealpha,0))(self);
				end
			end;
		};
		 LoadActor( THEME:GetPathG("ScreenSelectProfile","CardBG02") ) .. {
			InitCommand=cmd(shadowlength,0;zoomx,0.62;zoomy,0;y,-85;diffuse,cColor2);
			OnCommand=cmd(sleep,0.5;linear,0.13;zoomy,0.85;);
			OffCommand=cmd(linear,0.02;zoom,0.100;diffusealpha,0);
		};
		LoadActor( THEME:GetPathG("ScreenSelectProfile","LvBackground") ) .. {
			InitCommand=cmd(shadowlength,0;zoom,0;y,-40;x,-90;diffuse,cColor2);
			OnCommand=cmd(sleep,0.3;linear,0.3;zoom,1;);
			OffCommand=cmd(linear,0.02;zoom,0.100;diffusealpha,0);
		};
		
		LoadActor( THEME:GetPathG("ScreenSelectProfile","LvWord") ) .. {
			InitCommand=cmd(shadowlength,0;zoom,0;y,-10;x,-90;diffuse,cColor2);
			OnCommand=cmd(sleep,0.3;linear,0.3;zoom,1;);
			OffCommand=cmd(linear,0.02;zoom,0.100;diffusealpha,0);
		};
		
		-- LoadActor( THEME:GetPathG("ScreenSelectProfile","BestWord") ) .. {
			-- InitCommand=cmd(shadowlength,0;zoom,0;y,-40;x,-12;diffuse,cColor2;);
			-- OnCommand=cmd(sleep,0.3;linear,0.3;zoom,0.8;playcommand,"Animate");
			-- OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
			-- AnimateCommand=cmd(sleep,2;smooth,0.05;rotationz,10;smooth,0.05;rotationz,-10;smooth,0.05;rotationz,0;queuecommand,"Animate");
		-- };
		
		
		-- LoadActor( THEME:GetPathG("ScreenSelectProfile","DancerNameWord") ) .. {
			-- InitCommand=cmd(shadowlength,0;zoom,0;y,-165;x,-69;diffuse,cColor2;);
			-- OnCommand=cmd(sleep,0.3;linear,0.3;zoom,0.8;playcommand,"Animate");
			-- OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
			-- AnimateCommand=cmd(sleep,2;smooth,0.1;zoomx,0.801;smooth,0.1;zoomx,0.8;queuecommand,"Animate");
		-- };
		
		
		-- LoadActor( THEME:GetPathG("ScreenSelectProfile","AbilityLevelWord") ) .. {
			-- InitCommand=cmd(shadowlength,0;zoom,0;y,-120;x,-69;diffuse,cColor2;);
			-- OnCommand=cmd(sleep,0.3;linear,0.3;zoom,0.8;playcommand,"Animate");
			-- OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
			-- AnimateCommand=cmd(sleep,2;smooth,0.1;zoomx,0.801;smooth,0.1;zoomx,0.8;queuecommand,"Animate");
		-- };
		
		-- LoadActor( THEME:GetPathG("ScreenSelectProfile","DDR-CodeWord") ) .. {
			-- InitCommand=cmd(shadowlength,0;zoom,0;y,-96;x,-69;diffuse,cColor2;);
			-- OnCommand=cmd(sleep,0.3;linear,0.3;zoom,0.8;playcommand,"Animate");
			-- OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
			-- AnimateCommand=cmd(sleep,2;smooth,0.1;zoomx,0.801;smooth,0.1;zoomx,0.8;queuecommand,"Animate");
		-- };
		
					--�W�U�ج[------------
		LoadActor( THEME:GetPathG("ScreenSelectProfile","CardFrameA") )..{
			Name = "Frame";
			InitCommand=cmd(x,0;y,0;zoom,0);
			OnCommand=cmd(linear,0.3;zoom,0.82;linear,0.3;y,-187);
			OffCommand=function(self)
				if IsJoinFrame then
					(cmd(sleep,0.5;linear,0.2;y,0.100;linear,0.2;diffusealpha,0))(self);
				else
					(cmd(linear,0.2;y,0.100;linear,0.2;diffusealpha,0))(self);
				end
			end;
			
		};
		LoadActor( THEME:GetPathG("ScreenSelectProfile","CardFrameWBase") )..{
			Name = "Frame";
			InitCommand=cmd(x,0;y,0;zoom,0);
			OnCommand=cmd(linear,0.3;zoom,0.82;linear,0.3;y,188);
			OffCommand=function(self)
				if IsJoinFrame then
					(cmd(sleep,0.5;linear,0.2;y,0.100;zoomy,0.5;linear,0.05;diffusealpha,0))(self);
				else
					(cmd(linear,0.2;y,0.100;zoomy,0.5;linear,0.05;diffusealpha,0))(self);
				end
			end;
		};
		
	};

	return t
end



function SetRank02(Rank02, minValue)
	
	if minValue >=1.98 then
		Rank02 = "True God";
	elseif minValue >=1.80 then
		Rank02 = "Dazu God";
	elseif minValue >=1.60 then
		Rank02 = "God";
	elseif minValue >=1.40 then
		Rank02 = "Deity";
	elseif minValue >=1.20 then
		Rank02 = "Phoenix";
	elseif minValue >=1.00 then
		Rank02 = "Dragon";
	elseif minValue >=0.85 then
		Rank02 = "Emperor";
	elseif minValue >=0.70 then
		Rank02 = "King";
	elseif minValue >=0.55 then
		Rank02 = "Shogun";
	elseif minValue >=0.40 then
		Rank02 = "Noble";
	elseif minValue >=0.30 then
		Rank02 = "Knight";
	elseif minValue >=0.20 then
		Rank02 = "Samurai";
	elseif minValue >=0.10 then
		Rank02 = "Warrior";
	elseif minValue >0 then
		Rank02 = "Beginner";
	else
		Rank02 = "???";
		
	end
	
	return Rank02;
end


function SetRankFromRadarValue(selectRank, SingleTable, DoubleTable)
	local Rank01;
	local Rank02 = "123";

	local singleMax = math.max(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5]);
	local doubleMax = math.max(DoubleTable[1],DoubleTable[2],DoubleTable[3],DoubleTable[4],DoubleTable[5]);
	local singleMin = math.min(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5]);
	local doubleMin = math.min(DoubleTable[1],DoubleTable[2],DoubleTable[3],DoubleTable[4],DoubleTable[5]);
	
	local totalMax = math.max(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5],
								DoubleTable[1],DoubleTable[2],DoubleTable[3],DoubleTable[4],DoubleTable[5]);

	-- local totalMin = math.min(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5],
								-- DoubleTable[1],DoubleTable[2],DoubleTable[3],DoubleTable[4],DoubleTable[5]);
	
	if totalMax == SingleTable[1] or totalMax==DoubleTable[1] then
		Rank01 = "Stream";
	elseif totalMax == SingleTable[2] or totalMax==DoubleTable[2] then
		Rank01 = "Voltage";
	elseif totalMax == SingleTable[3] or totalMax==DoubleTable[3] then
		Rank01 = "Air";
	elseif totalMax == SingleTable[4] or totalMax==DoubleTable[4] then
		Rank01 = "Freeze";
	else
		Rank01 = "Chaos";
	end
	
	if (totalMax == SingleTable[1] or 
		totalMax == SingleTable[2] or 
		totalMax == SingleTable[3] or 
		totalMax == SingleTable[4] or
		totalMax == SingleTable[5]) then
	
		Rank02 = SetRank02(Rank02,singleMin);
	else
		Rank02 = SetRank02(Rank02,doubleMin);
	end
	
	if Rank02 == "???" then
		Rank01 ="???"
	end

	selectRank:settext(Rank01.." ".. Rank02);
	
	selectRank:settext("");
end;


function LoadPlayerStuff(Player)
	
	local t = {};
	local pn = (Player == PLAYER_1) and 1 or 2;

	local lang = "en";
		if THEME:GetCurLanguage() == "ja" then
			lang = "jp";
		end;


	t[#t+1] = Def.ActorFrame {
		Name = 'JoinFrame';
		LoadCard(Color('Outline'),color('0,0,0,0'),Player,true);
		
		LoadActor( THEME:GetPathG("ScreenSelectProfile","Start") ) .. {
			InitCommand=cmd(zoomy,0;diffuseshift;effectcolor1,Color('White');effectcolor2,color("#A5A6A5");playcommand,"Animate");
			OnCommand=cmd(zoomy,0;sleep,0.5;linear,0.1;zoomy,1);
			AnimateCommand=cmd(smooth,0.1;zoomx,1.0;smooth,0.1;zoomx,1.0;queuecommand,"Animate");
			OffCommand=cmd(sleep,0.5;linear,0.1;zoomy,0;diffusealpha,0);
		};
		
	};

	t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile",lang.."_CardFrameWord") )..{
		Name = "FrameInstWord";
		InitCommand=cmd(x,0;y,189;zoom,0.82);
		OnCommand=cmd(diffusealpha,0;sleep,0.8;linear,0.3;diffusealpha,1);
		OffCommand=function(self)
		(cmd(stoptweening;linear,0.05;;diffusealpha,0))(self);
		end;
	};
	
	t[#t+1] = Def.ActorFrame {
		Name = 'BigFrame';
		LoadCard(PlayerColor(),color('1,1,1,1'),Player,false);
	};
	t[#t+1] = Def.ActorFrame {
		Name = 'SmallFrame';
		InitCommand=cmd(y,96);
		
		LoadActor( THEME:GetPathG("ScreenSelectProfile","MyGrooveRadarValueBack") )..{
			InitCommand=cmd(zoomto,40,30;x,40;y,-70);
			OnCommand=cmd(diffusealpha,0;sleep,0.5;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.1;zoomy,0;diffusealpha,0);
		};
		LoadActor( THEME:GetPathG("ScreenSelectProfile","MyGrooveRadarValueBack") )..{
			InitCommand=cmd(zoomto,40,30;x,-90;y,-40);
			OnCommand=cmd(diffusealpha,0;sleep,0.6;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.1;zoomy,0;diffusealpha,0);
		};
		LoadActor( THEME:GetPathG("ScreenSelectProfile","MyGrooveRadarValueBack") )..{
			InitCommand=cmd(zoomto,40,30;x,-80;y,30);
			OnCommand=cmd(diffusealpha,0;sleep,0.7;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.1;zoomy,0;diffusealpha,0);
		};
		LoadActor( THEME:GetPathG("ScreenSelectProfile","MyGrooveRadarValueBack") )..{
			InitCommand=cmd(zoomto,40,30;x,80;y,30);
			OnCommand=cmd(diffusealpha,0;sleep,0.8;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.1;zoomy,0;diffusealpha,0);
		};
		LoadActor( THEME:GetPathG("ScreenSelectProfile","MyGrooveRadarValueBack") )..{
			InitCommand=cmd(zoomto,40,30;x,90;y,-40);
			OnCommand=cmd(diffusealpha,0;sleep,0.9;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.1;zoomy,0;diffusealpha,0);
		};
		
		LoadActor( THEME:GetPathG("ScreenSelectProfile","MyGrooveRadarBack") )..{
			InitCommand=cmd(zoom,0.8;y,-5);
			OnCommand=cmd(diffusealpha,0;sleep,0.9;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.01;zoom,0;diffusealpha,0);
		};

		-- Def.Quad {
			-- InitCommand=cmd(zoomto,250-10,40+2);
			-- OnCommand=cmd(diffuse,Color('Black');diffusealpha,0.5;fadeleft,0.25;faderight,0.25;);
			-- OffCommand=cmd(linear,0.3;zoomy,0;diffusealpha,0);
		-- };
		-- Def.Quad {
			-- InitCommand=cmd(zoomto,250-10,40);
			-- OnCommand=cmd(diffuse,PlayerColor(Player);fadeleft,0.25;faderight,0.25;glow,color("1,1,1,0.25"));
			-- OffCommand=cmd(linear,0.3;zoomy,0;diffusealpha,0);
		-- };
		-- Def.Quad {
			-- InitCommand=cmd(zoomto,250-10,40;y,-40/2+20);
			-- OnCommand=cmd(diffuse,Color("Black");fadebottom,1;fadeleft,0.25;faderight,0.25;diffusealpha,0.35);
			-- OffCommand=cmd(linear,0.3;zoomy,0;diffusealpha,0);
		-- };
		-- Def.Quad {
			-- InitCommand=cmd(zoomto,250-10,1;y,-40/2+1);
			-- OnCommand=cmd(diffuse,PlayerColor(Player);glow,color("1,1,1,0.25");fadeleft,0.25;faderight,0.25;);
			-- OffCommand=cmd(linear,0.3;zoomy,0;diffusealpha,0);
		-- };	
	};
	

	t[#t+1] = Def.ActorScroller{
		Name = 'Scroller';
		NumItemsToDraw=1;

		OnCommand=cmd(draworder,1000;y,96;SetFastCatchup,true;SetMask,0,58;SetSecondsPerItem,0.15);
		TransformFunction=function(self, offset, itemIndex, numItems)
			local focus = scale(math.abs(offset),0,2,1,0);
			self:visible(false);
			self:y(math.floor( offset*40 ));

		end;
		children = GetLocalProfiles();
		OffCommand=cmd(linear,0.3;zoomy,0;diffusealpha,0);
	};
	
	
	t[#t+1] = Def.ActorFrame {
		Name = "EffectFrame";
	};
	
	--�U��d��E----------------
	-- t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile","PlayerNameCard") )..{
		-- Name = "Frame";
		-- InitCommand=cmd(y,160;zoomx,0);
		-- OnCommand=cmd(sleep,0.3;linear,0.3;zoomx,1);
		-- OffCommand=cmd(sleep,0.5;linear,0.2;zoomx,0.03;diffusealpha,0.5;sleep,0.1;diffusealpha,0);
		
	-- };
	
	
	-- t[#t+1] = LoadFont("_dfphsgothic-w9") .. {
		-- Text="Player Name";
		-- InitCommand=cmd(diffusealpha,0;zoom,0.5;x,-70;y,135;shadowlength,1;diffuse,color("1,1,0.3,0"));
		-- OnCommand=cmd(sleep,0.5;linear,0.3;diffusealpha,1);
		-- OffCommand=cmd(linear,0.3;zoomy,0;diffusealpha,0);
	-- };

	
local lang = "en";
if THEME:GetCurLanguage() == "ja" then
	lang = "jp";
end;

		
	t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile","CardFrameWBase") )..{
		Name = "FrameInstWBase";
		InitCommand=cmd(x,0;y,189;zoom,0.85);
		OnCommand=cmd(diffusealpha,0;sleep,0.55;linear,0.05;diffusealpha,1);
		OffCommand=function(self)
		(cmd(stoptweening;linear,0.05;;diffusealpha,0))(self);
		end;
	};
	t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile",lang.."_CardFrameWord") )..{
		Name = "FrameInstWord";
		InitCommand=cmd(x,0;y,189;zoom,0.82);
		OnCommand=cmd(diffusealpha,0;sleep,0.8;linear,0.3;diffusealpha,1);
		OffCommand=function(self)
		(cmd(stoptweening;linear,0.05;;diffusealpha,0))(self);
		end;
	};
	
	t[#t+1] = LoadFont("_helveticaneuelt pro 75 bd 60px") .. {
		Name = 'SelectedProfileText';
		InitCommand=cmd(horizalign,left;x,-112;y,-137;zoomx,0.45;zoomy,0.35;shadowlength,1;diffuse,color("1,1,1,0");strokecolor,Color("Outline");maxwidth,350);
		OnCommand=cmd(sleep,0.8;linear,0.5;diffusealpha,1);
		OffCommand=cmd(stoptweening;linear,0.01;zoomy,0;diffusealpha,0);
	};
	
	t[#t+1] = LoadFont("enjoy number") .. {
		Name = 'SelectedProfileLevel';
		InitCommand=cmd(x,-90;y,-42;zoom,0;diffuse,color("1,1,1,1"));
		OnCommand=cmd(sleep,0.7;linear,0.05;diffusealpha,1;zoomy,0.3;zoomx,0.3;maxwidth,240);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
	t[#t+1] = LoadFont("_helveticaneuelt pro 75 bd 60px") .. {
		Name = 'selectedTotalCaloriesBurned';
		InitCommand=cmd(x,80;y,-38;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,Color("Outline");maxwidth,350);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.24;zoomx,0.24;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
	t[#t+1] = LoadFont("_helveticaneuelt pro 75 bd 60px") .. {
		Name = 'selectSongsPlayed';
		InitCommand=cmd(x,50;y,-112;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,Color("Outline");maxwidth,150);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.3;zoomx,0.4;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
	t[#t+1] = LoadFont("_helveticaneuelt pro 75 bd 60px") .. {
		Name = 'selectHonorName';
		InitCommand=cmd(horizalign,center;skewx,-0.35;x,85;y,-129;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.8,1");strokecolor,Color("Outline");maxwidth,200);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomx,0.28;zoomy,0.22);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	

	
	t[#t+1] = Def.Sprite{
		Name = 'selectedMostSongPlayed';
		InitCommand=cmd(x,65;y,-32;zoom,0;scaletoclipped,0,0;);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;diffuse,color("1,1,1,1");scaletoclipped,40,40;);
		OffCommand=cmd(stoptweening;linear,0.1;scaletoclipped,0,0;);
	};
	
	t[#t+1] = Def.Sprite{
		Name = 'selectedHonorPic';
		InitCommand=cmd(x,30;y,-137;zoom,0;scaletoclipped,0,0;);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;scaletoclipped,30,30;);
		OffCommand=cmd(stoptweening;linear,0.1;scaletoclipped,0,0;);
	};
	
	t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile","LvBar") ) .. {
			Name = 'selectLvBarBack';
			InitCommand=cmd(diffusealpha,0;y,1;x,0;zoom,1;zoomy,0.2);
			OnCommand=cmd(diffusealpha,0;sleep,0.3;linear,0.3;diffusealpha,1;diffuse,color("0.4,0.4,0.4,1"));
			OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
			
	};
	
	t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile","LvBar") ) .. {
			Name = 'selectLvBar';
			InitCommand=cmd(diffusealpha,0;y,1;x,0;cropright,1;zoom,1;zoomy,0.2);
			OnCommand=cmd(diffusealpha,0;sleep,0.3;linear,0.3;diffusealpha,1;);
			OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
			
		};
		
		
	t[#t+1]=LoadFont("_helveticaneuelt pro 75 bd 60px") .. {
		Name = 'selectTotalAttackrateWord';
		InitCommand=cmd(x,-10;y,-62;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,Color("Outline");maxwidth,320);
		OnCommand=function(self)
			self:settext(" ");
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.15;zoomx,0.25))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
		
	t[#t+1]=LoadFont("_helveticaneuelt pro 75 bd 60px") .. { --*****************************************************************************************************
		Name = 'LVTitle';
		InitCommand=cmd(x,-60;y,-67;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,Color("Outline");horizalign,left);
		OnCommand=function(self)
			self:settext("Dance LV");
			self:settext("");
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.18;zoomx,0.18))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	t[#t+1]=LoadFont("_helveticaneuelt pro 75 bd 60px") .. {
		Name = 'SPLVTitle';
		InitCommand=cmd(x,5;y,-67;zoom,0;diffuse,color("#12cff2");strokecolor,color("#12cff2");horizalign,left);
		OnCommand=function(self)
			self:settext("SP");
			self:settext("");
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.18;zoomx,0.18))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	t[#t+1]=LoadFont("_helveticaneuelt pro 75 bd 60px") .. {
		Name = 'DPLVTitle';
		InitCommand=cmd(x,68;y,-67;zoom,0;diffuse,color("#f253ed");strokecolor,color("#f253ed");horizalign,left);
		OnCommand=function(self)
			self:settext("DP");
			self:settext("");
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.18;zoomx,0.18))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};                                                
	t[#t+1] = LoadFont("_helveticaneuelt pro 75 bd 60px") .. {
		Name = 'SPLV';
		InitCommand=cmd(x,39-5;y,-67;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,color("Outline");maxwidth,100);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.3;zoomx,0.35;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	t[#t+1] = LoadFont("_helveticaneuelt pro 75 bd 60px") .. {
		Name = 'DPLV';
		InitCommand=cmd(x,102-5;y,-67;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,color("Outline");maxwidth,100);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.3;zoomx,0.35;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};																		--*****************************************************************************************************
	
	
	
	

	t[#t+1] = LoadFont("_helveticaneuelt pro 75 bd 60px") .. {
		Name = 'selectPercentComplete';
		InitCommand=cmd(x,75;y,-62;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,Color("Outline");maxwidth,220);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.3;zoomx,0.35;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	t[#t+1]=LoadFont("_helveticaneuelt pro 75 bd 60px") .. {
		Name = 'selectTotalCalWord';
		InitCommand=cmd(x,-10;y,-38;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,Color("Outline");maxwidth,320);
		OnCommand=function(self)
			self:settext("Today Burned : ");
			self:settext("");
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.15;zoomx,0.25))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	t[#t+1]=LoadFont("_helveticaneuelt pro 65 md 60px") .. {
		Name = 'selectRank';
		InitCommand=cmd(x,35;y,-15;skewx,-0.30;zoom,0;maxwidth,350);
		OnCommand=function(self)
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.22;zoomx,0.3))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
	t[#t+1] = LoadFont("_helveticaneuelt pro 75 bd 60px") .. {
		Name = 'selectPlayerUID';
		InitCommand=cmd(x,35;y,-106;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.9,1");strokecolor,Color("Outline");maxwidth,420);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.3;zoomx,0.45;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
	


	t[#t+1] =LoadFont("_atilla Bold 16px") .. {
		InitCommand=cmd(x,0;y,-186;zoom,0;diffuse,color("1,1,1,1");strokecolor,Color("Outline");maxwidth,270;shadowlength,1);
		OnCommand=function(self)
			if Player== PLAYER_1 then
				self:settext("PLAYER:1");
				self:diffuse(ColorLightTone(PlayerColor(PLAYER_1)));
			else
				self:settext("PLAYER:2");
				self:diffuse(PlayerColor(PLAYER_2));
			end
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.8;zoomx,1.35))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};	
	------MyGrooveRadar
	if (Player == PLAYER_1) then
		t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile", "GrooveRadarP1_Single" ),1,0.2,0.2,0.2,0.5)..{
			Name = "GVRD1S";
			InitCommand=cmd(x,0;y,99;zoom,0.56;diffusealpha,0;diffuse,ColorLightTone(PlayerColor(PLAYER_1),2.5));
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
			OffCommand=cmd(linear,0.05;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD1Value_S1';
			InitCommand=cmd(horizalign,right;x,40+17;y,18;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD1Value_S2';
			InitCommand=cmd(horizalign,right;x,-90+17;y,48;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD1Value_S3';
			InitCommand=cmd(horizalign,right;x,-80+17;y,118;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD1Value_S4';
			InitCommand=cmd(horizalign,right;x,80+17;y,118;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD1Value_S5';
			InitCommand=cmd(horizalign,right;x,90+17;y,48;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		
		t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile", "GrooveRadarP1_Double" ),1,0.2,0.2,0.2,0.5)..{
			Name = "GVRD1D";
			InitCommand=cmd(x,0;y,99;zoom,0.56;diffusealpha,0;diffuse,ColorLightTone(PlayerColor(PLAYER_2),2.5));
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
			OffCommand=cmd(linear,0.05;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD1Value_D1';
			InitCommand=cmd(horizalign,right;x,40+17;y,18+14;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD1Value_D2';
			InitCommand=cmd(horizalign,right;x,-90+17;y,48+14;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD1Value_D3';
			InitCommand=cmd(horizalign,right;x,-80+17;y,118+14;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD1Value_D4';
			InitCommand=cmd(horizalign,right;x,80+17;y,118+14;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD1Value_D5';
			InitCommand=cmd(horizalign,right;x,90+17;y,48+14;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		
		
		
	else
		t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile", "GrooveRadarP2_Single" ),1,0.2,0.2,0.2,0.5)..{
			Name = "GVRD2S";
			InitCommand=cmd(x,0;y,99;zoom,0.56;diffusealpha,0;diffuse,ColorLightTone(PlayerColor(PLAYER_1),2.5));
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
			OffCommand=cmd(linear,0.05;diffusealpha,0);
		};	
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD2Value_S1';
			InitCommand=cmd(horizalign,right;x,40+17;y,18;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD2Value_S2';
			InitCommand=cmd(horizalign,right;x,-90+17;y,48;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD2Value_S3';
			InitCommand=cmd(horizalign,right;x,-80+17;y,118;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD2Value_S4';
			InitCommand=cmd(horizalign,right;x,80+17;y,118;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD2Value_S5';
			InitCommand=cmd(horizalign,right;x,90+17;y,48;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		
		t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile", "GrooveRadarP2_Double" ),1,0.2,0.2,0.2,0.5)..{
			Name = "GVRD2D";
			InitCommand=cmd(x,0;y,99;zoom,0.56;diffusealpha,0;diffuse,ColorLightTone(PlayerColor(PLAYER_2),2.5));
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
			OffCommand=cmd(linear,0.05;diffusealpha,0);
		};

		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD2Value_D1';
			InitCommand=cmd(horizalign,right;x,40+17;y,18+14;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD2Value_D2';
			InitCommand=cmd(horizalign,right;x,-90+17;y,48+14;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD2Value_D3';
			InitCommand=cmd(horizalign,right;x,-80+17;y,118+14;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD2Value_D4';
			InitCommand=cmd(horizalign,right;x,80+17;y,118+14;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD2Value_D5';
			InitCommand=cmd(horizalign,right;x,90+17;y,48+14;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};	
		
	end;
	
	

	return t;
end;

function UpdateInternal3(self, Player)
	local pn = (Player == PLAYER_1) and 1 or 2;
	local frame = self:GetChild(string.format('P%uFrame', pn));
	
	local scroller = frame:GetChild('Scroller');
	local seltext = frame:GetChild('SelectedProfileText');
	local joinframe = frame:GetChild('JoinFrame');
	local smallframe = frame:GetChild('SmallFrame');
	local bigframe = frame:GetChild('BigFrame');
	
	local selLevel = frame:GetChild('SelectedProfileLevel');
	local selTotalCalWord = frame:GetChild('selectTotalCalWord');
	local selTotalCaloriesBurned = frame:GetChild('selectedTotalCaloriesBurned');
	local selectRank = frame:GetChild('selectRank');
	local selectPlayerUID = frame:GetChild('selectPlayerUID');
	local selMostSongPlayed = frame:GetChild('selectedMostSongPlayed');
	local selHonorPic = frame:GetChild('selectedHonorPic');
	local selHonorName = frame:GetChild('selectHonorName');
	local selSongsPlayed = frame:GetChild('selectSongsPlayed');
	local selLvBarBack = frame:GetChild('selectLvBarBack');
	local selLvBar = frame:GetChild('selectLvBar');
	local selPercentComplete = frame:GetChild('selectPercentComplete');
	local selTotalAttackrateWord = frame:GetChild('selectTotalAttackrateWord');
	local LVTitle = frame:GetChild('LVTitle');
	--local SPLVTitle = frame:GetChild('SPLVTitle');
	--local DPLVTitle = frame:GetChild('DPLVTitle');
	--local SPLV = frame:GetChild('SPLV');
	--local DPLV = frame:GetChild('DPLV');
	local FrameInstWBase = frame:GetChild('FrameInstWBase');
	local FrameInstWord = frame:GetChild('FrameInstWord');
	
	--MyGrooveRadar
	local selPlayerUID;
	local selGVRDSingle = (Player == PLAYER_1) and frame:GetChild('GVRD1S') or frame:GetChild('GVRD2S');
	local selGVRDDouble = (Player == PLAYER_1) and frame:GetChild('GVRD1D') or frame:GetChild('GVRD2D');
	local selGVRDValue_S1 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S1') or frame:GetChild('GVRD2Value_S1');
	local selGVRDValue_S2 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S2') or frame:GetChild('GVRD2Value_S2');
	local selGVRDValue_S3 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S3') or frame:GetChild('GVRD2Value_S3');
	local selGVRDValue_S4 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S4') or frame:GetChild('GVRD2Value_S4');
	local selGVRDValue_S5 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S5') or frame:GetChild('GVRD2Value_S5');
	local selGVRDValue_D1 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_D1') or frame:GetChild('GVRD2Value_D1');
	local selGVRDValue_D2 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_D2') or frame:GetChild('GVRD2Value_D2');
	local selGVRDValue_D3 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_D3') or frame:GetChild('GVRD2Value_D3');
	local selGVRDValue_D4 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_D4') or frame:GetChild('GVRD2Value_D4');
	local selGVRDValue_D5 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_D5') or frame:GetChild('GVRD2Value_D5');
	
	
	local PcntLarger;
	--local selMostCoursePlayed = frame:GetChild('selectedMostCoursePlayed');
	if GAMESTATE:IsHumanPlayer(Player) then
		frame:visible(true);
		if MEMCARDMAN:GetCardState(Player) == 'MemoryCardState_none' then
			local ind = SCREENMAN:GetTopScreen():GetProfileIndex(Player);
			local set_ind;
			local key_ind;

			if Player == PLAYER_1 then
				set_ind = {PLAYER_1,PLAYER_2};
				key_ind = {keyset[1],keyset[2]};
			else
				set_ind = {PLAYER_2,PLAYER_1};
				key_ind = {keyset[2],keyset[1]};
			end;
			if GAMESTATE:GetNumPlayersEnabled() >= 2 then
				if SCREENMAN:GetTopScreen():GetProfileIndex(set_ind[1]) == SCREENMAN:GetTopScreen():GetProfileIndex(set_ind[2]) then
					if key_ind[1] == 1 and key_ind[2] < 1 then
						if SCREENMAN:GetTopScreen():GetProfileIndex(set_ind[1]) == profnum then
							SCREENMAN:GetTopScreen():SetProfileIndex(set_ind[2], SCREENMAN:GetTopScreen():GetProfileIndex(set_ind[2])-1 );
						else SCREENMAN:GetTopScreen():SetProfileIndex(set_ind[2], SCREENMAN:GetTopScreen():GetProfileIndex(set_ind[2])+1 );
						end
					end
				end
			end
			if keyset[pn] < 1 then
				--using profile if any
				joinframe:visible(false);
				smallframe:visible(true);
				bigframe:visible(false);
				seltext:visible(true);
				selectPlayerUID:visible(true);
				scroller:visible(true);
				selLevel:visible(true);
				selTotalCalWord:visible(true);
				selTotalCaloriesBurned:visible(true);
				selectRank:visible(true);
				selMostSongPlayed:visible(false);
				selSongsPlayed:visible(false);
				selHonorPic:visible(true);
				selHonorName:visible(true);
				selLvBarBack:visible(true);
				selLvBar:visible(true);
				selPercentComplete:visible(true);
				selTotalAttackrateWord:visible(true);
				LVTitle:visible(true);
				--SPLVTitle:visible(true);
				--DPLVTitle:visible(true);
				--SPLV:visible(true);
				--DPLV:visible(true);
				FrameInstWBase:visible(true);
				FrameInstWord:visible(true);
			
				selGVRDSingle:visible(true);
				selGVRDDouble:visible(true);
				selGVRDValue_S1:visible(true);
				selGVRDValue_S2:visible(true);
				selGVRDValue_S3:visible(true);
				selGVRDValue_S4:visible(true);
				selGVRDValue_S5:visible(true);
				selGVRDValue_D1:visible(true);
				selGVRDValue_D2:visible(true);
				selGVRDValue_D3:visible(true);
				selGVRDValue_D4:visible(true);
				selGVRDValue_D5:visible(true);
			else
				joinframe:visible(false);
				smallframe:visible(true);
				bigframe:visible(false);
				seltext:visible(true);
				selectPlayerUID:visible(true);
				scroller:visible(true);
				selLevel:visible(true);
				selTotalCalWord:visible(true);
				selTotalCaloriesBurned:visible(true);
				selectRank:visible(true);
				selMostSongPlayed:visible(false);
				selSongsPlayed:visible(false);
				selHonorPic:visible(true);
				selHonorName:visible(true);
				selLvBarBack:visible(true);
				selLvBar:visible(true);
				selPercentComplete:visible(true);
				selTotalAttackrateWord:visible(true);
				LVTitle:visible(true);
				--SPLVTitle:visible(true);
				--DPLVTitle:visible(true);
				--SPLV:visible(true);
				--DPLV:visible(true);
				FrameInstWBase:visible(true);
				FrameInstWord:visible(true);
			
				selGVRDSingle:visible(true);
				selGVRDDouble:visible(true);
				selGVRDValue_S1:visible(true);
				selGVRDValue_S2:visible(true);
				selGVRDValue_S3:visible(true);
				selGVRDValue_S4:visible(true);
				selGVRDValue_S5:visible(true);
				selGVRDValue_D1:visible(true);
				selGVRDValue_D2:visible(true);
				selGVRDValue_D3:visible(true);
				selGVRDValue_D4:visible(true);
				selGVRDValue_D5:visible(true);
				frame:queuecommand("Off")
			end
			
			local ind = SCREENMAN:GetTopScreen():GetProfileIndex(Player);
			
			
			if ind > 0 then
			
				selPlayerUID = PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetGUID();
				selectPlayerUID:settext(string.upper(string.sub(selPlayerUID,1,4).."-"..string.sub(selPlayerUID,5,8)));
				local RadarFile = RageFileUtil:CreateRageFile()
				
				local RadarValueTableSingle = {};
				local RadarValueTableDouble = {};
				
				----------Single Radar 
				if RadarFile:Open("Save/MyGrooveRadar/"..selPlayerUID.."_S1.txt",1) then --Stram--
					local str = RadarFile:Read();
					CurrentValue = tonumber(str);
					selGVRDValue_S1:settext(string.format("%0.1f", CurrentValue*100));
					RadarValueTableSingle[1] = CurrentValue;
				else
					selGVRDValue_S1:settext("0");
					RadarValueTableSingle[1] = 0;
				end
				if RadarFile:Open("Save/MyGrooveRadar/"..selPlayerUID.."_S2.txt",1) then --Voltage--
					local str = RadarFile:Read();
					CurrentValue = tonumber(str);
					selGVRDValue_S2:settext(string.format("%0.1f", CurrentValue*100));
					RadarValueTableSingle[2] = CurrentValue;
				else
					selGVRDValue_S2:settext("0");
					RadarValueTableSingle[2] = 0;
				end
				if RadarFile:Open("Save/MyGrooveRadar/"..selPlayerUID.."_S3.txt",1) then --Air--
					local str = RadarFile:Read();
					CurrentValue = tonumber(str);
					selGVRDValue_S3:settext(string.format("%0.1f", CurrentValue*100));
					RadarValueTableSingle[3] = CurrentValue;
				else
					selGVRDValue_S3:settext("0");
					RadarValueTableSingle[3] = 0;
				end
				if RadarFile:Open("Save/MyGrooveRadar/"..selPlayerUID.."_S4.txt",1) then --Freeze--
					local str = RadarFile:Read();
					CurrentValue = tonumber(str);
					selGVRDValue_S4:settext(string.format("%0.1f", CurrentValue*100));
					RadarValueTableSingle[4] = CurrentValue;
				else
					selGVRDValue_S4:settext("0");
					RadarValueTableSingle[4] = 0;
				end
				if RadarFile:Open("Save/MyGrooveRadar/"..selPlayerUID.."_S5.txt",1) then --Chaos--
					local str = RadarFile:Read();
					CurrentValue = tonumber(str);
					selGVRDValue_S5:settext(string.format("%0.1f", CurrentValue*100));
					RadarValueTableSingle[5] = CurrentValue;
				else
					selGVRDValue_S5:settext("0");
					RadarValueTableSingle[5] = 0;
				end
				
				----------Double Radar 
				if RadarFile:Open("Save/MyGrooveRadar/"..selPlayerUID.."_D1.txt",1) then --Stram--
					local str = RadarFile:Read();
					CurrentValue = tonumber(str);
					selGVRDValue_D1:settext(string.format("%0.1f", CurrentValue*100));
					RadarValueTableDouble[1] = CurrentValue;
				else
					selGVRDValue_D1:settext("0");
					RadarValueTableDouble[1] = 0;
				end
				if RadarFile:Open("Save/MyGrooveRadar/"..selPlayerUID.."_D2.txt",1) then --Voltage--
					local str = RadarFile:Read();
					CurrentValue = tonumber(str);
					selGVRDValue_D2:settext(string.format("%0.1f", CurrentValue*100));
					RadarValueTableDouble[2] = CurrentValue;
				else
					selGVRDValue_D2:settext("0");
					RadarValueTableDouble[2] = 0;
				end
				if RadarFile:Open("Save/MyGrooveRadar/"..selPlayerUID.."_D3.txt",1) then --Air--
					local str = RadarFile:Read();
					CurrentValue = tonumber(str);
					selGVRDValue_D3:settext(string.format("%0.1f", CurrentValue*100));
					RadarValueTableDouble[3] = CurrentValue;
				else
					selGVRDValue_D3:settext("0");
					RadarValueTableDouble[3] = 0;
				end
				if RadarFile:Open("Save/MyGrooveRadar/"..selPlayerUID.."_D4.txt",1) then --Freeze--
					local str = RadarFile:Read();
					CurrentValue = tonumber(str);
					selGVRDValue_D4:settext(string.format("%0.1f", CurrentValue*100));
					RadarValueTableDouble[4] = CurrentValue;
				else
					selGVRDValue_D4:settext("0");
					RadarValueTableDouble[4] = 0;
				end
				if RadarFile:Open("Save/MyGrooveRadar/"..selPlayerUID.."_D5.txt",1) then --Chaos--
					local str = RadarFile:Read();
					CurrentValue = tonumber(str);
					selGVRDValue_D5:settext(string.format("%0.1f", CurrentValue*100));
					RadarValueTableDouble[5] = CurrentValue;
				else
					selGVRDValue_D5:settext("0");
					RadarValueTableDouble[5] = 0;
				end
				RadarFile:Close();
				-----Rank From Radar Value
				SetRankFromRadarValue(selectRank,RadarValueTableSingle,RadarValueTableDouble);
			
				----***********************************Set SPLV+DPLV
				local LVSingle = 0;
				local LVDouble = 0;
				
				local DanceLVFile = RageFileUtil:CreateRageFile()
				if DanceLVFile:Open("Save/DanceLV/"..selPlayerUID.."_SP.txt",1) then --SPLV--
					local str = DanceLVFile:Read();
					CurrentValue = tonumber(str);
					--SPLV:settext(string.format("%0.2f", CurrentValue*10));
					LVSingle=CurrentValue;
					DanceLVFile:Close();
				else
					DanceLVFile:Open("Save/DanceLV/"..selPlayerUID.."_SP.txt",2) 
					--SPLV:settext("0.0");
					DanceLVFile:Write("0.0");
					DanceLVFile:Close();	
				end
				
				if DanceLVFile:Open("Save/DanceLV/"..selPlayerUID.."_DP.txt",1) then --DPLV--
					local str = DanceLVFile:Read();
					CurrentValue = tonumber(str);
					--DPLV:settext(string.format("%0.2f", CurrentValue*10));
					LVDouble=CurrentValue;
					DanceLVFile:Close();
				else
					DanceLVFile:Open("Save/DanceLV/"..selPlayerUID.."_DP.txt",2) 
					--DPLV:settext("0.0");
					DanceLVFile:Write("0.0");
					DanceLVFile:Close();	
				end
				

				----***********************************Set SPLV+DPLV End

				local PcntCompleteSingle = 0;
				local PcntCompleteDouble = 0;
				-- local PcntCompleteSingle = PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetSongsAndCoursesPercentCompleteAllDifficulties('StepsType_Dance_Single');
				-- local PcntCompleteDouble = PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetSongsAndCoursesPercentCompleteAllDifficulties('StepsType_Dance_Double');
				
				--HonorName
				
				if LVSingle>LVDouble then
					PcntLarger = LVSingle;
				else 
					PcntLarger = LVDouble;
				end
				PcntLarger = PcntLarger*100;
				
				if PcntLarger==0 then
					selHonorName:settext('--');
					selHonorPic:Load(THEME:GetPathB("","_ability/000"));
				elseif PcntLarger>=0 and PcntLarger<10 then
					selHonorName:settext('stone');
					if PcntLarger >8 then selHonorPic:Load(THEME:GetPathB("","_ability/008")); 
					elseif PcntLarger >6 then selHonorPic:Load(THEME:GetPathB("","_ability/006")); 
					elseif PcntLarger >4 then selHonorPic:Load(THEME:GetPathB("","_ability/004"));
					elseif PcntLarger >2 then selHonorPic:Load(THEME:GetPathB("","_ability/002")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/000")); 					
					end
				elseif PcntLarger>=10 and PcntLarger<20 then
					selHonorName:settext('soap bubble');
					if PcntLarger >18 then selHonorPic:Load(THEME:GetPathB("","_ability/018")); 
					elseif PcntLarger >16 then selHonorPic:Load(THEME:GetPathB("","_ability/016")); 
					elseif PcntLarger >14 then selHonorPic:Load(THEME:GetPathB("","_ability/014"));
					elseif PcntLarger >12 then selHonorPic:Load(THEME:GetPathB("","_ability/012")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/010")); 					
					end
				elseif PcntLarger>=20 and PcntLarger<30 then
					selHonorName:settext('pencil');
					if PcntLarger >28 then selHonorPic:Load(THEME:GetPathB("","_ability/028")); 
					elseif PcntLarger >26 then selHonorPic:Load(THEME:GetPathB("","_ability/026")); 
					elseif PcntLarger >24 then selHonorPic:Load(THEME:GetPathB("","_ability/024"));
					elseif PcntLarger >22 then selHonorPic:Load(THEME:GetPathB("","_ability/022")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/020")); 					
					end
				elseif PcntLarger>=30 and PcntLarger<40 then
					selHonorName:settext('macaron');
					if PcntLarger >38 then selHonorPic:Load(THEME:GetPathB("","_ability/038")); 
					elseif PcntLarger >36 then selHonorPic:Load(THEME:GetPathB("","_ability/036")); 
					elseif PcntLarger >34 then selHonorPic:Load(THEME:GetPathB("","_ability/034"));
					elseif PcntLarger >32 then selHonorPic:Load(THEME:GetPathB("","_ability/032")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/030")); 					
					end
				elseif PcntLarger>=40 and PcntLarger<50 then
					selHonorName:settext('lotus');
					if PcntLarger >48 then selHonorPic:Load(THEME:GetPathB("","_ability/048")); 
					elseif PcntLarger >46 then selHonorPic:Load(THEME:GetPathB("","_ability/046")); 
					elseif PcntLarger >44 then selHonorPic:Load(THEME:GetPathB("","_ability/044"));
					elseif PcntLarger >42 then selHonorPic:Load(THEME:GetPathB("","_ability/042")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/040")); 					
					end
				elseif PcntLarger>=50 and PcntLarger<60 then
					selHonorName:settext('beetle');
					if PcntLarger >58 then selHonorPic:Load(THEME:GetPathB("","_ability/058")); 
					elseif PcntLarger >56 then selHonorPic:Load(THEME:GetPathB("","_ability/056")); 
					elseif PcntLarger >54 then selHonorPic:Load(THEME:GetPathB("","_ability/054"));
					elseif PcntLarger >52 then selHonorPic:Load(THEME:GetPathB("","_ability/052")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/050")); 					
					end
				elseif PcntLarger>=60 and PcntLarger<70 then
					selHonorName:settext('jellyfish');
					if PcntLarger >68 then selHonorPic:Load(THEME:GetPathB("","_ability/068")); 
					elseif PcntLarger >66 then selHonorPic:Load(THEME:GetPathB("","_ability/066")); 
					elseif PcntLarger >64 then selHonorPic:Load(THEME:GetPathB("","_ability/064"));
					elseif PcntLarger >62 then selHonorPic:Load(THEME:GetPathB("","_ability/062")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/060")); 					
					end
				elseif PcntLarger>=70 and PcntLarger<80 then
					selHonorName:settext('hummingbird');
					if PcntLarger >78 then selHonorPic:Load(THEME:GetPathB("","_ability/078")); 
					elseif PcntLarger >76 then selHonorPic:Load(THEME:GetPathB("","_ability/076")); 
					elseif PcntLarger >74 then selHonorPic:Load(THEME:GetPathB("","_ability/074"));
					elseif PcntLarger >72 then selHonorPic:Load(THEME:GetPathB("","_ability/072")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/070")); 					
					end
				elseif PcntLarger>=80 and PcntLarger<90 then
					selHonorName:settext('kaleidoscope');
					if PcntLarger >88 then selHonorPic:Load(THEME:GetPathB("","_ability/088")); 
					elseif PcntLarger >86 then selHonorPic:Load(THEME:GetPathB("","_ability/086")); 
					elseif PcntLarger >84 then selHonorPic:Load(THEME:GetPathB("","_ability/084"));
					elseif PcntLarger >82 then selHonorPic:Load(THEME:GetPathB("","_ability/082")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/080")); 					
					end
				elseif PcntLarger>=90 and PcntLarger<100 then
					selHonorName:settext('prism');
					if PcntLarger >98 then selHonorPic:Load(THEME:GetPathB("","_ability/098")); 
					elseif PcntLarger >96 then selHonorPic:Load(THEME:GetPathB("","_ability/096")); 
					elseif PcntLarger >94 then selHonorPic:Load(THEME:GetPathB("","_ability/094"));
					elseif PcntLarger >92 then selHonorPic:Load(THEME:GetPathB("","_ability/092")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/090")); 					
					end
				elseif PcntLarger>=100  then
					selHonorName:settext('prism');
					selHonorPic:Load(THEME:GetPathB("","_ability/100"));
				end
				
				
				selHonorPic:shadowlength(1);
				
				local Lv = (math.ceil(math.sqrt(PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetTotalCaloriesBurned())));
				local pcnt =((PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetTotalCaloriesBurned())-((Lv-1)*(Lv-1))) /((Lv*Lv)-((Lv-1)*(Lv-1)));
				local totalPcnt = (PcntCompleteSingle + PcntCompleteDouble) / 2;
				
				if profnum > 0 then
					scroller:SetDestinationItem(ind-1);
				else
					scroller:SetDestinationItem(ind);
				end
				bigframe:visible(true);
				seltext:settext(PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetDisplayName());
				selLevel:settext(math.ceil(math.sqrt(PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetTotalCaloriesBurned())) );
				selTotalCaloriesBurned:settext((math.ceil(PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetCaloriesBurnedToday()))..' kCals.');
				selTotalCaloriesBurned:settext("");
				selMostSongPlayed:Load(GetSongGPath(PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetLastPlayedSong()));
				selSongsPlayed:settext(tostring(math.ceil(PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetNumTotalSongsPlayed())));
				
				(cmd(stoptweening;decelerate,0.5;cropright,1-pcnt;diffusealpha,1;))(selLvBar);
				
				--selPercentComplete:settext(string.format("%6.2f", PcntLarger).." %");
				selPercentComplete:settext("");
				
				
				
				
				
			else
				if SCREENMAN:GetTopScreen():SetProfileIndex(Player, 1) then
					bigframe:visible(false);
					scroller:SetDestinationItem(0);
					self:queuecommand('UpdateInternal2');
				else
					joinframe:visible(false);
					smallframe:visible(false);
					bigframe:visible(false);
					scroller:visible(false);
					seltext:settext('No profile');
					frameInstWord:visible(false);
					selectPlayerUID:settext('------------');
					selLevel:settext('No level info');
					selTotalCaloriesBurned:settext('No Played Songs Info');
					selectRank:settext('???');
					selMostSongPlayed:visible(false);
					selSongsPlayed:visible(false);
					selHonorPic:visible(false);
					selHonorName:visible(false);
					selLvBarBack:visible(true);
					selLvBar:visible(false);
					selPercentComplete:visible(false);
					selTotalAttackrateWord:visible(false);
					LVTitle:visible(false);
					--SPLVTitle:visible(false);
					--DPLVTitle:visible(false);
					--SPLV:visible(false);
					--DPLV:visible(false);
					
					FrameInstWBase:visible(false);
					FrameInstWord:visible(false);
					selGVRDSingle:visible(false);
					selGVRDDouble:visible(false);
					selGVRDValue_S1:visible(false);
					selGVRDValue_S2:visible(false);
					selGVRDValue_S3:visible(false);
					selGVRDValue_S4:visible(false);
					selGVRDValue_S5:visible(false);
					selGVRDValue_D1:visible(false);
					selGVRDValue_D2:visible(false);
					selGVRDValue_D3:visible(false);
					selGVRDValue_D4:visible(false);
					selGVRDValue_D5:visible(false);
				end;
			end;
		else
			--using card
			smallframe:visible(false);
			scroller:visible(false);
			seltext:settext('CARD');
			SCREENMAN:GetTopScreen():SetProfileIndex(Player, 0);
		end;
	else
		joinframe:visible(true);
		scroller:visible(false);
		seltext:visible(false);
		selectPlayerUID:visible(false);
		smallframe:visible(false);
		bigframe:visible(false);
		selLevel:visible(false);
		selTotalCalWord:visible(false);
		selTotalCaloriesBurned:visible(false);
		selectRank:visible(false);
		selMostSongPlayed:visible(false);
		selSongsPlayed:visible(false);
		selHonorPic:visible(false);
		selHonorName:visible(false);
		selLvBarBack:visible(false);
		selLvBar:visible(false);
		selPercentComplete:visible(false);
		selTotalAttackrateWord:visible(false);
		LVTitle:visible(false);
		--SPLVTitle:visible(false);
		--DPLVTitle:visible(false);
		--SPLV:visible(false);
		--DPLV:visible(false);
		FrameInstWBase:visible(false);
			FrameInstWord:visible(false);
			
		selGVRDSingle:visible(false);
		selGVRDDouble:visible(false);
		selGVRDValue_S1:visible(false);
		selGVRDValue_S2:visible(false);
		selGVRDValue_S3:visible(false);
		selGVRDValue_S4:visible(false);
		selGVRDValue_S5:visible(false);
		selGVRDValue_D1:visible(false);
		selGVRDValue_D2:visible(false);
		selGVRDValue_D3:visible(false);
		selGVRDValue_D4:visible(false);
		selGVRDValue_D5:visible(false);
	end;
end;

local screen = Var("LoadingScreen")

--�D�{��
local t = Def.ActorFrame {

	StorageDevicesChangedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	CodeMessageCommand = function(self, params)
		if params.Name == 'Start' or params.Name == 'Center' then
			if GAMESTATE:IsHumanPlayer(params.PlayerNumber) then
				if GAMESTATE:GetNumPlayersEnabled() > 1 then
					if params.PlayerNumber == 'PlayerNumber_P1' then
						keyset[1] = 1
						self:queuecommand('UpdateInternal2');
					else
						keyset[2] = 1
						self:queuecommand('UpdateInternal2');
					end
				end
				MESSAGEMAN:Broadcast("StartButton");
				if GAMESTATE:GetNumPlayersEnabled() == 1 then
					self:queuecommand('UpdateInternal4')
					MESSAGEMAN:Broadcast("StartButton");
				else
					if keyset[1] == 1 and keyset[2] == 1 then
						self:queuecommand('UpdateInternal4')
						MESSAGEMAN:Broadcast("StartButton");
					end
				end
			else
				if GAMESTATE:EnoughCreditsToJoin() then
					if GAMESTATE:GetCoinMode() == "CoinMode_Pay" then
						GAMESTATE:InsertCoin(-1)
					end
					SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, -1);
					MESSAGEMAN:Broadcast("StartButton");
				end
			end;
		end;
		if params.Name == 'Up' or params.Name == 'Up2' or params.Name == 'DownLeft' then
			if GAMESTATE:IsHumanPlayer(params.PlayerNumber) then
				local ind = SCREENMAN:GetTopScreen():GetProfileIndex(params.PlayerNumber);
				if ind > 1 then
					if SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, ind - 1 ) then
						MESSAGEMAN:Broadcast("DirectionButton");
						self:queuecommand('UpdateInternal2');
					end;
				end;
			end;
		end;
		if params.Name == 'Down' or params.Name == 'Down2' or params.Name == 'DownRight' then
			if GAMESTATE:IsHumanPlayer(params.PlayerNumber) then
				local ind = SCREENMAN:GetTopScreen():GetProfileIndex(params.PlayerNumber);
				if ind > 0 then
					if SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, ind + 1 ) then
						MESSAGEMAN:Broadcast("DirectionButton");
						self:queuecommand('UpdateInternal2');
					end;
				end;
			end;
		end;
		if params.Name == 'Back' then
			if GAMESTATE:GetNumPlayersEnabled()==0 then
				SCREENMAN:GetTopScreen():Cancel();
			else
				MESSAGEMAN:Broadcast("BackButton");
				SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, -2);
			end;
		end;
	end;

	PlayerJoinedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	PlayerUnjoinedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	OnCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	UpdateInternal2Command=function(self)
		UpdateInternal3(self, PLAYER_1);
		UpdateInternal3(self, PLAYER_2);
	end;
	UpdateInternal4Command=function(self)
		if PROFILEMAN:GetNumLocalProfiles() >= 1 then
			SCREENMAN:GetTopScreen():Finish();
		else
			SCREENMAN:GetTopScreen():StartTransitioningScreen('SM_GoToNextScreen')
		end
	end;
	children = {
		Def.ActorFrame {
			Name = 'P1Frame';
			InitCommand=cmd(x,SCREEN_CENTER_X-260;y,SCREEN_CENTER_Y;zoom,1.5);
			OnCommand=cmd();
			OffCommand=cmd();
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == PLAYER_1 then
					(cmd(zoomx,1.5;zoomy,0.15;linear,0.175;zoomy,1.5;))(self);
				end;
			end;
			children = LoadPlayerStuff(PLAYER_1);
		};
		Def.ActorFrame {
			Name = 'P2Frame';
			InitCommand=cmd(x,SCREEN_CENTER_X+260;y,SCREEN_CENTER_Y;zoom,1.5);
			OnCommand=cmd();
			OffCommand=cmd();
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == PLAYER_2 then
					(cmd(zoomx,1.5;zoomy,0.15;linear,0.175;zoomy,1.5;))(self);
				end;
			end;
			children = LoadPlayerStuff(PLAYER_2);
		};
		-- sounds
		-- LoadActor( THEME:GetPathS("Common","start") )..{
			-- StartButtonMessageCommand=cmd(play);
		-- };
		-- LoadActor( THEME:GetPathS("Common","cancel") )..{
			-- BackButtonMessageCommand=cmd(play);
		-- };
		-- LoadActor( THEME:GetPathS("Common","value") )..{
			-- DirectionButtonMessageCommand=cmd(play);
		-- };
				-- sounds
		LoadActor( THEME:GetPathS("Common","start") )..{
			StartButtonMessageCommand=cmd(play);
		};
		LoadActor( THEME:GetPathS("","Profile_start") )..{
			StartButtonMessageCommand=cmd(play);
		};
		LoadActor( THEME:GetPathS("Common","cancel") )..{
			BackButtonMessageCommand=cmd(play);
		};
		LoadActor( THEME:GetPathS("","Profile_Move") )..{
			DirectionButtonMessageCommand=cmd(play);
		};
	};
};


return t;
