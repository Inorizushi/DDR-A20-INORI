local t = Def.ActorFrame {};

local exbefore = 0;
local exsum = 0;
local PlayerUID = PROFILEMAN:GetProfile(PLAYER_1):GetGUID()

function ReadTotalEXScoreP1( PlayerUID )
	local EXScoreFile1 = RageFileUtil:CreateRageFile();
	if EXScoreFile1:Open("Save/EXScoreSum/"..PlayerUID..".txt",1) then
		local str = EXScoreFile1:Read();
		exbefore = tonumber(str);
		EXScoreFile1:Close();
	else
		exbefore = 0;
	end;
end;

function SaveTotalEXScoreP1( PlayerUID , extotal)
	local EXScoreFile1 = RageFileUtil:CreateRageFile();
	EXScoreFile1:Open("Save/EXScoreSum/"..PlayerUID..".txt",2);
	EXScoreFile1:Write(tostring(extotal));
	EXScoreFile1:Close();
end;



ReadTotalEXScoreP1(PlayerUID);


exbefore = math.round(exbefore);
local add_exscore = (STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPossibleDancePoints())*(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints())
add_exscore = math.round(add_exscore);

exsum = exbefore + add_exscore;

SaveTotalEXScoreP1(PlayerUID , exsum);

t[#t+1] = LoadActor("p1exscoreback")..{
		InitCommand=cmd(x,SCREEN_LEFT+87+4;y,SCREEN_CENTER_Y-268-3+5+60-2;player,PLAYER_1;zoom,1.14);
		OffCommand=cmd(linear,0.15;addx,-300);
};
t[#t+1] = LoadActor("p2exscoreback")..{
		InitCommand=cmd(x,SCREEN_RIGHT-87-4;y,SCREEN_CENTER_Y-268-3+5+60-2;player,PLAYER_2;zoom,1.14);
		OffCommand=cmd(linear,0.15;addx,300);
};

t[#t+1] = LoadFont("_arial black 28px")..{

	InitCommand=function(self)
		self:player(PLAYER_1);
		self:x(SCREEN_CENTER_X-636);
		self:y(SCREEN_CENTER_Y-198-34);
		--self:draworder(11);
		self:horizalign(left);
		self:vertalign(top);
		self:settext("PLAYER1's RESULT\nTOTAL EX SCORE");
		self:zoom(0.36);
		self:diffuse(color("#feec0a"));
	end;
	OffCommand=cmd(linear,0.15;addx,-300);
	
};




t[#t+1] = Def.RollingNumbers {
	File = THEME:GetPathF("ScreenEvaluation", "EXSummary");
			--InitCommand=cmd(x,SCREEN_CENTER_X-310+10;y,SCREEN_CENTER_Y-52-11+3.2;zoomx,0.947;zoomy,0.958;player,PLAYER_1;playcommand,"Set");
	InitCommand=function(self)
		self:player(PLAYER_1);
		self:x(SCREEN_CENTER_X-503);
		self:y(SCREEN_CENTER_Y-198);
		--self:draworder(11);
		self:horizalign(right);
		self:zoom(0.88);
		self:diffuse(color("#feec0a"));
		self:settext(exbefore);
		self:maxwidth(210);
		
		--self:settext(exsum);
		self:playcommand("Set");
		
		
	end;
	
	SetCommand = function(self)
		self:Load("RollingNumbersEXScoreSum");
		self:targetnumber(exsum);
	end;
	
	OffCommand=cmd(linear,0.15;addx,-300);
			
};

return t;