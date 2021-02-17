local t = Def.ActorFrame{};

local data =GAMESTATE:GetCurrentTrail(PLAYER_1);
local radar = GAMESTATE:GetCurrentSteps(PLAYER_1):GetRadarValues(PLAYER_1);
local baseScore = 1000000/(radar:GetValue('RadarCategory_TapsAndHolds')+radar:GetValue('RadarCategory_Holds')+radar:GetValue('RadarCategory_Rolls'));
local maxStep = (radar:GetValue('RadarCategory_TapsAndHolds')+radar:GetValue('RadarCategory_Holds')+radar:GetValue('RadarCategory_Rolls'));

--local curcombo = param.Combo;
   
--t.InitCommand=cmd(SetUpdateFunction,Update);

t[#t+1] = LoadFont("_Silta","20px")..{
			InitCommand = function(self)
				self:x(SCREEN_CENTER_X);
				self:y(SCREEN_CENTER_Y);
				
				self:settext(maxStep);
			end;
			OnCommand = function(self)
			
				self:settext("TapsAndHolds="..radar:GetValue('RadarCategory_TapsAndHolds').."\n"..
				"Holds="..radar:GetValue('RadarCategory_Holds').."\n"..
				"Rolls="..radar:GetValue('RadarCategory_Rolls'));
			end;
			
};			



return t;