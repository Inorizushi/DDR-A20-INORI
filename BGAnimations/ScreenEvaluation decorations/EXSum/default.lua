local pn = ...

local exbefore = 0;
local exsum = 0;
local PlayerUID = PROFILEMAN:GetProfile(pn):GetGUID()

function ReadTotalEXScore( PlayerUID )
	local EXScoreFile1 = RageFileUtil:CreateRageFile();
	if EXScoreFile1:Open("Save/EXScoreSum/"..PlayerUID..".txt",1) then
		local str = EXScoreFile1:Read();
		exbefore = tonumber(str);
		EXScoreFile1:Close();
	else
		exbefore = 0;
	end;
end;

function SaveTotalEXScore( PlayerUID , extotal)
	local EXScoreFile1 = RageFileUtil:CreateRageFile();
	EXScoreFile1:Open("Save/EXScoreSum/"..PlayerUID..".txt",2);
	EXScoreFile1:Write(tostring(extotal));
	EXScoreFile1:Close();
end;

ReadTotalEXScore(PlayerUID);


exbefore = math.round(exbefore);
local add_exscore = (STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPossibleDancePoints())*(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPercentDancePoints())
add_exscore = math.round(add_exscore);

exsum = exbefore + add_exscore;

SaveTotalEXScore(PlayerUID , exsum);

local t = Def.ActorFrame {};

t[#t+1] = LoadActor("exback")..{
    InitCommand=function(s) s:xy(pn==PLAYER_1 and 34 or 94,64):rotationy(pn==PLAYER_1 and 0 or 180) end,
	OffCommand=cmd(linear,0.15;addx,-300);
};

t[#t+1] = LoadFont("_arial black 28px")..{
	InitCommand=function(self)
		self:xy(pn==PLAYER_1 and -58 or 58,40)
		self:align(pn==PLAYER_1 and 0 or 1,0):zoom(0.36):diffuse(color("#feec0a"))
		self:settext("GOLDEN LEAGUE\nTOTAL EX SCORE");
	end;
	OffCommand=cmd(linear,0.15;addx,-300);
	
};




t[#t+1] = Def.RollingNumbers {
	File = THEME:GetPathF("ScreenEvaluation", "EXSummary");
    InitCommand=function(self)
        self:Load("RollingNumbersEXScoreSum")
        self:xy(pn==PLAYER_1 and 58 or 58,76):halign(pn==PLAYER_1 and 1 or 0):zoom(0.88)
        :diffuse(color("#feec0a")):maxwidth(210);
		self:targetnumber(exbefore)
		self:queuecommand("Set")
	end;
	SetCommand = function(self)
		self:targetnumber(exsum);
	end;
	
	OffCommand=cmd(linear,0.15;addx,-300);
			
};

return t;