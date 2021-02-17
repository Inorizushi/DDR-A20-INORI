local player = ...;

local Combo = 	STATSMAN:GetCurStageStats():GetPlayerStageStats(player):MaxCombo();

local Marvelous = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W1");
local Perfect = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W2");
local Great = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W3");
local Good = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W4");
local Ok = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetHoldNoteScores("HoldNoteScore_Held");
local Miss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_Miss") + STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W5");

local Fast=getenv("numFast"..ToEnumShortString(player));
local Slow=getenv("numSlow"..ToEnumShortString(player));

local Score = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetScore();
local EXScore = math.floor(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPossibleDancePoints())*(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints())+0.5


local Large = Def.BitmapText{
	Font="_atilla Bold 16px",
	InitCommand=function(s) s:zoom(1.7) end,
};

local Judge = Def.BitmapText{
	Font="_atilla Bold 16px",
	InitCommand=function(s) s:zoom(1.4):halign(1)
		:DiffuseAndStroke(Color.Black,Color.White)
	end,
};

return Def.ActorFrame{
	Large..{
		Name="MaxCombo",
		InitCommand=function(s)
			s:xy(18,-110):halign(1)
			:settextf(Combo)
		end,
	};
	Judge..{
		Name="Marvelous",
		InitCommand=function(s)
			s:xy(18,-76):halign(1)
			:settextf(Marvelous)
		end,
	};
	Judge..{
		Name="Perfect",
		InitCommand=function(s)
			s:xy(18,-45):halign(1)
			:settextf(Perfect)
		end,
	};
	Judge..{
		Name="Perfect",
		InitCommand=function(s)
			s:xy(18,-15):halign(1)
			:settextf(Great)
		end,
	};
	Judge..{
		Name="Perfect",
		InitCommand=function(s)
			s:xy(18,15):halign(1)
			:settextf(Good)
		end,
	};
	Judge..{
		Name="Perfect",
		InitCommand=function(s)
			s:xy(18,45):halign(1)
			:settextf(Ok)
		end,
	};
	Judge..{
		Name="Perfect",
		InitCommand=function(s)
			s:xy(18,75):halign(1)
			:settextf(Miss)
		end,
	};
	Large..{
		Name="MaxCombo",
		InitCommand=function(s)
			s:xy(18,105):halign(1)
			:settextf("%4d",EXScore)
		end,
	};
}
