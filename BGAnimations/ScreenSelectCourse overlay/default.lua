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

local t = Def.ActorFrame {};

local lang = "en";
if THEME:GetCurLanguage() == "ja" then
	lang = "jp";
end;

t[#t+1] = Def.ActorFrame {
	LoadActor( "../../Graphics/ScreenWithMenuElements footer/"..lang.."_selmus"  )..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-40;zoom,0.7);
	OnCommand=cmd(linear,0.2;addy,-8);
	OffCommand=cmd(linear,0.2;addy,100);
	};
};

t[#t+1] = Def.ActorFrame{
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+120;y,SCREEN_TOP+60;zoom,1.5);
		OnCommand=function(self)
			if GAMESTATE:GetPlayMode() == 'PlayMode_Regular' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle' or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
				self:Load(THEME:GetPathG("", "SelMusStageInfo/Stage " .. ToEnumShortString(sStage) ));
				self:diffusealpha(0):sleep(0.2):linear(0.2):diffusealpha(1);
			else
				self:Load(THEME:GetPathG("", "SelMusStageInfo/Stage " .. "1st" ));
				self:diffusealpha(0):sleep(0.2):linear(0.2):diffusealpha(1);
			end;
		end;
		OffCommand=cmd(diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;linear,0.05;diffusealpha,0);
		
	};
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "_frame" )..{
		InitCommand=cmd(zoom,1.5);
		OnCommand=cmd(x,SCREEN_CENTER_X-127;y,SCREEN_TOP+101;diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
		OffCommand=cmd(diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;linear,0.05;diffusealpha,0);
	};
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "mask" )..{
		InitCommand=cmd(zoom,1.5);
		OnCommand=cmd(x,SCREEN_CENTER_X-77;y,SCREEN_TOP+105;blend,'BlendMode_NoEffect';zwrite,true;clearzbuffer,false;);
		OffCommand=cmd(stoptweening;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;linear,0.05;diffusealpha,0);
	};
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "scan" )..{
		InitCommand=cmd(zoom,1.5);
		OnCommand=cmd(x,SCREEN_CENTER_X-420;y,SCREEN_TOP+83;linear,1.5;addx,520;sleep,1;ztest,true;queuecommand,"On";diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
		OffCommand=cmd(stoptweening;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;linear,0.05;diffusealpha,0);
	};
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "scan" )..{
		InitCommand=cmd(zoom,1.5);
		OnCommand=cmd(x,SCREEN_CENTER_X-420;y,SCREEN_TOP+83;linear,1.5;addx,520;sleep,1;ztest,true;queuecommand,"On";diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
		OffCommand=cmd(stoptweening;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;linear,0.05;diffusealpha,0);
	};
};


t[#t+1] = Def.ActorFrame {
	LoadActor( "_info" )..{
		InitCommand=cmd(zoom,1.5);
		OnCommand=cmd(x,SCREEN_CENTER_X-344;y,SCREEN_TOP+49;diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
		OffCommand=cmd(diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;linear,0.05;diffusealpha,0);
	};
};

t[#t+1] = Def.ActorFrame {
	Def.Sprite{
		Texture="_meter 2x2 (doubleres).png";
		OnCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
		InitCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X-5;y,SCREEN_TOP+140;effectclock,'beatnooffset';SetAllStateDelays,1);
		OffCommand=cmd(diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;linear,0.05;diffusealpha,0);
	};
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "_bpm" )..{
		InitCommand=cmd(zoom,1.5);
		OnCommand=cmd(x,SCREEN_CENTER_X+21;y,SCREEN_TOP+134;diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
		OffCommand=cmd(diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;linear,0.05;diffusealpha,0);
	};
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "_coverbg" )..{
		InitCommand=cmd(zoom,1.5);
		OnCommand=cmd(x,SCREEN_CENTER_X+228;y,SCREEN_TOP+89;diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
		OffCommand=cmd(diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;linear,0.05;diffusealpha,0);
	};
};

--Song Info
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) c = self:GetChildren(); end;
	OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP;diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
	OffCommand=cmd(linear,0.3;diffusealpha,0);
	--Title
	LoadFont("_arial black 28px")..{
		Name="Title";
		InitCommand=cmd(horizalign,left;diffusecolor,color("#000000");addy,50;addx,-240;zoom,0.58);
	};
	--Artist
	LoadFont("_arial black 28px")..{
		Name="Artist";
		InitCommand=cmd(horizalign,left;addy,68;addx,-240;zoom,0.475);
	};

	--Jacket
	Def.Sprite{
		Name="SJacket";
		InitCommand=cmd(zoom,1;addy,59;addx,152);
		OffCommand=cmd(linear,0.3;zoomy,0);
	};

	SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong();
		if song then
			--Song
			local title;
			if song:GetDisplaySubTitle() == "" then
				title = song:GetDisplayMainTitle();
			else
				title = song:GetDisplayFullTitle();
			end;
			c.Title:maxwidth(390);
			c.Title:settext(title);

			local artist;
			artist = song:GetDisplayArtist();
			c.Artist:maxwidth(500);
			c.Artist:settext(artist);

			if song:HasJacket() then
				c.SJacket:LoadBackground(song:GetJacketPath());
				c.SJacket:setsize(100,100);
			elseif song:HasBanner() then
				c.SJacket:LoadFromSongBanner(GAMESTATE:GetCurrentSong());
				c.SJacket:setsize(100,100);
			else
				c.SJacket:Load(THEME:GetPathG("", "Common fallback jacket"));
				c.SJacket:setsize(100,100);
			end;
			c.Title:diffusealpha(1);
			c.Artist:diffusealpha(1);
			c.SJacket:diffusealpha(1);
		else
			local course = GAMESTATE:GetCurrentCourse();
			--Not Song
			if course then
				c.Title:settext(course:GetDisplayFullTitle());
				c.Title:diffusealpha(1);
				c.Artist:diffusealpha(0);
				c.SJacket:diffusealpha(0);
			end
		end;
	end;

	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
};

--BPM
t[#t+1] = LoadFont("Bpm")..{
	InitCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X+92;addy,125);
	OnCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
	SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong();
		if song then
			local bpmtext;
			bpmtext = song:GetDisplayBpms();
			if bpmtext[1] == bpmtext[2] then
				bpmtext = round(bpmtext[1],0);
			else
				bpmtext = string.format("%d\nx%3d",round(bpmtext[1],0),round(bpmtext[2],0));
			end
			self:horizalign(right);
			self:vertalign(top);
			self:settext(bpmtext);
			self:visible(true);
		else
			self:visible(false);
		end
	end;
	OffCommand=cmd(diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;linear,0.05;diffusealpha,0);
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
};

--song jacket
t[#t+1] = Def.ActorFrame {
 	InitCommand=cmd(x,126;y,88;zoom,1.16;diffusealpha,1;draworder,1);
	OnCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
	OffCommand=cmd(sleep,0.2;bouncebegin,0.175;zoomy,0);
	Def.Banner {
		SetCommand=function(self)
		if not GAMESTATE:IsCourseMode() then
		local song = GAMESTATE:GetCurrentSong();
				if song then
				self:CenterX();
					if song:HasJacket() then
						self:diffusealpha(1);
						self:LoadBackground(song:GetJacketPath());
						self:zoomtowidth(130);
						self:zoomtoheight(130);							
					elseif song:HasBanner() then
						self:diffusealpha(1);
						self:LoadFromSongBanner(GAMESTATE:GetCurrentSong());
						self:zoomtowidth(130);
						self:zoomtoheight(130);							
					else
						self:Load(THEME:GetPathG("","Common fallback jacket"));
						self:zoomtowidth(130);
						self:zoomtoheight(130);							
					end;
				elseif SCREENMAN:GetTopScreen():GetNextScreenName()=="ScreenStageInformation" 
				and SCREENMAN:GetTopScreen():GetPrevScreenName()~="ScreenSelectMusic" then
						local selgrp =SCREENMAN:GetTopScreen():GetMusicWheel():GetSelectedSection();
						if not GAMESTATE:GetCurrentSong() then
							myLoadGroupJacket(selgrp, self);
							self:zoomtowidth(130);
							self:zoomtoheight(130);	
							self:stoptweening();
						else
							self:Load(THEME:GetPathG("","Common fallback jacket"));
							self:zoomtowidth(130);
							self:zoomtoheight(130);	
							self:stoptweening();							
						end;
				else
						self:diffusealpha(1);
						self:Load(THEME:GetPathG("","Common fallback jacket"));
						self:zoomtowidth(130);
						self:zoomtoheight(130);							
				end;
		else
			self:diffusealpha(0);
		end;
		self:stoptweening();
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		};
	Def.Banner {
		SetCommand=function(self)
		local course = GAMESTATE:GetCurrentCourse();
			if course then
				self:x(SCREEN_CENTER_X+0);
				self:LoadFromCourse(GAMESTATE:GetCurrentCourse());
						self:zoomtowidth(130);
						self:zoomtoheight(130);				
			end;
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
		};
};

return t
