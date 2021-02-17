local playMode = GAMESTATE:GetPlayMode()
if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
	curStage = playMode;
end;
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

local t = Def.ActorFrame {};



t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:y(SCREEN_CENTER_Y);
	end;

};
t[#t+1] = Def.Quad{
	OnCommand=cmd(diffuse,color("#000000");y,2000;setsize,1,1;diffusealpha,0;zoom,4;sleep,1.9;linear,0.2;diffusealpha,1;zoom,1);
	};
if not GAMESTATE:IsCourseMode() then
--song jacket--
t[#t+1] = Def.ActorFrame {
	OnCommand=cmd(playcommand,'Set';y,2000;diffusealpha,0;zoom,4;sleep,1.9;linear,0.2;diffusealpha,1;zoom,1;sleep,3;diffusealpha,1);
	Def.Sprite {
		SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong();
			if song:HasJacket() then
				self:LoadBackground(song:GetJacketPath());
				self:setsize(480,480);
			elseif song:HasBanner() then
				self:LoadFromSongBanner(GAMESTATE:GetCurrentSong());
				self:setsize(480,480);
			else
				self:Load(THEME:GetPathG("","Common fallback jacket"));
				self:setsize(480,480);
			end;
		end;
	};
};
else
t[#t+1] = LoadActor("CourseDisplay")..{
	OnCommand=cmd(y,2000);
};
end;
t[#t+1] = LoadActor("StageDisplay")..{
	OnCommand=cmd(y,2000);
};

t[#t+1] = LoadActor("ScoreDispay");

return t