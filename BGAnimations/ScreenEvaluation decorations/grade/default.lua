--Stolen from https://github.com/Inorizushi/DDR-X3/tree/master/BGAnimations/ScreenEvaluation%20decorations/grade

local pn = ...
-- the only arg is arg 1, the player number
local function m(metric)
	metric = metric:gsub("PN", ToEnumShortString(pn))
	return THEME:GetMetric(Var "LoadingScreen",metric)
end

local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)

--local tier = SN2Grading.ScoreToGrade(pss:GetScore(), pss:GetPlayedSteps()[1]:GetDifficulty())
local tier = pss:GetGrade();

local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame{
	Def.Sprite{
		InitCommand = function(s) s:draworder(98):player(pn):x(m "RingPNX"):y(m "RingPNY"):zoom(0) end,
		OnCommand=function(self)
			local staw = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetStageAward();
			if staw ~= nil then
				if((staw =="StageAward_SingleDigitW3") or (staw =="StageAward_OneW3") or (staw =="StageAward_FullComboW3") or string.find(staw,"W3")) then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/Fullcombo_ring.png"));
				elseif((staw =="StageAward_SingleDigitW2") or (staw =="StageAward_OneW2") or (staw =="StageAward_FullComboW2") ) then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/PerfectFullcombo_ring.png"));
				elseif (staw =="StageAward_FullComboW1") then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/MarvelousFullcombo_ring.png"));
				end;
				self:linear(0.2):zoom(1):spin():effectmagnitude(0,0,170)
			end;
		end;
		OffCommand=cmd(linear,0.2;zoom,0);
	};
	--Lines
	Def.Sprite{
		InitCommand = function(s) s:draworder(98):player(pn):x(m "RingPNX"):y(m "RingPNY"):zoom(0) end,
		OnCommand=function(self)
		local staw = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetStageAward();
			if staw ~= nil then
				if((staw =="StageAward_SingleDigitW3") or (staw =="StageAward_OneW3") or (staw =="StageAward_FullComboW3") or string.find(staw,"W3")) then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/Fullcombo_lines.png"));
				elseif((staw =="StageAward_SingleDigitW2") or (staw =="StageAward_OneW2") or (staw =="StageAward_FullComboW2") ) then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/PerfectFullcombo_lines.png"));
				elseif (staw =="StageAward_FullComboW1") then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/MarvelousFullcombo_lines.png"));
				end;
				self:linear(0.2):zoom(1):spin():effectmagnitude(0,0,-170)
			end;
		end;
		OffCommand=cmd(linear,0.2;zoom,0);
	};
} ;

t[#t+1] = Def.ActorFrame{
	Def.Sprite{
		Texture = THEME:GetPathB("ScreenEvaluation decorations/grade/GradeDisplayEval", ToEnumShortString(tier)),
		InitCommand = function(s) s:x(m "GradePNX"):y(m "GradePNY") end,
		OnCommand = m "GradePNOnCommand",
		OffCommand = m "GradePNOffCommand"
	};
};

return t;
