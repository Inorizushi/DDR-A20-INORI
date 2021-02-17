local x = Def.ActorFrame{};
x[#x+1] = Def.ActorFrame {
	Def.Quad{
		InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,80;diffuse,color("0,0,0,0.0"));
		OnCommand=cmd(smooth,0.2;diffuse,color("0,0,0,0.0"));
		OffCommand=cmd(smooth,0.2;diffuse,color("0,0,0,0.0");zoomy,0);
	};
	LoadFont("_arial black 32px")..{
		Text=ScreenString("Saving Profiles");
		InitCommand=cmd(Center;diffuse,color("1,1,1,1");shadowlength,1);
		OffCommand=cmd(linear,0.15;diffusealpha,0);
	};
};
if GAMESTATE:HasEarnedExtraStage() and GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2() then
x[#x+1] = Def.ActorFrame {
	LoadActor("_bluebg");
}
end


local function SaveRadarValue( PlayerUID, ActualValue, CurrentValue, StyleWord, CataNumber )
	local RadarFile = RageFileUtil:CreateRageFile();
	if RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_"..StyleWord..CataNumber..".txt",1) then 
		local str = RadarFile:Read();
		CurrentValue = tonumber(str);
		RadarFile:Close();	
	else
		RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_"..StyleWord..CataNumber..".txt",2);
		RadarFile:Write("0.0");
		RadarFile:Close();	
	end
	
	if ActualValue > CurrentValue then
		CurrentValue = CurrentValue +(ActualValue-CurrentValue)/10;
	end
	RadarFile:Close();	
	
	
	local RadarFile2 = RageFileUtil:CreateRageFile();
	RadarFile2:Open("Save/MyGrooveRadar/"..PlayerUID.."_"..StyleWord..CataNumber..".txt",2);
	RadarFile2:Write(tostring(CurrentValue));
	RadarFile2:Close();
end

--Save My Groove Radar Values
for _,pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	GAMESTATE:StoreRankingName(pn,PROFILEMAN:GetProfile(pn):GetDisplayName())
	local PlayerUID = PROFILEMAN:GetProfile(pn):GetGUID();

local StreamActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetRadarActual():GetValue("RadarCategory_Stream"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetRadarPossible():GetValue("RadarCategory_Stream"));
local VoltageActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetRadarActual():GetValue("RadarCategory_Voltage"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetRadarPossible():GetValue("RadarCategory_Voltage"));
local AirActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetRadarActual():GetValue("RadarCategory_Air"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetRadarPossible():GetValue("RadarCategory_Air"));
local FreezeActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetRadarActual():GetValue("RadarCategory_Freeze"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetRadarPossible():GetValue("RadarCategory_Freeze"));
local ChaosActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetRadarActual():GetValue("RadarCategory_Chaos"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetRadarPossible():GetValue("RadarCategory_Chaos"));


local StreamCurrentValue = 0;
local VoltageCurrentValue = 0;
local AirCurrentValue = 0;
local FreezeCurrentValue = 0;
local ChaosCurrentValue = 0;

	if not GAMESTATE:IsCourseMode() then
		if GAMESTATE:GetCurrentStyle():GetStepsType() == 'StepsType_Dance_Single' then ---------Single
			SaveRadarValue(PlayerUID,StreamActualValue,StreamCurrentValue,"S","1");
			SaveRadarValue(PlayerUID,VoltageActualValue,VoltageCurrentValue,"S","2");
			SaveRadarValue(PlayerUID,AirActualValue,AirCurrentValue,"S","3");
			SaveRadarValue(PlayerUID,FreezeActualValue,FreezeCurrentValue,"S","4");
			SaveRadarValue(PlayerUID,ChaosActualValue,ChaosCurrentValue,"S","5");
		else-----------------------Double
			SaveRadarValue(PlayerUID,StreamActualValue,StreamCurrentValue,"D","1");
			SaveRadarValue(PlayerUID,VoltageActualValue,VoltageCurrentValue,"D","2");
			SaveRadarValue(PlayerUID,AirActualValue,AirCurrentValue,"D","3");
			SaveRadarValue(PlayerUID,FreezeActualValue,FreezeCurrentValue,"D","4");
			SaveRadarValue(PlayerUID,ChaosActualValue,ChaosCurrentValue,"D","5");
		end
	end;

end

x[#x+1] = Def.Actor {
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():HaveProfileToSave() then self:sleep(0.5); end;

		self:queuecommand("Load");
	end;
	LoadCommand=function() SCREENMAN:GetTopScreen():Continue(); end;
};


return x;