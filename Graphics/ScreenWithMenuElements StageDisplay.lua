local t = Def.ActorFrame{};

local disp_stage = "Stage_1st";

local Stage = GAMESTATE:GetCurrentStage();
local StageIndex = GAMESTATE:GetCurrentStageIndex();
local FinalIndex = PREFSMAN:GetPreference("SongsPerPlay");

	--local jp_DanIndex = string.find(title, "�i");
	--local en_DanIndex_upper = string.find(title, "DAN");
	--local en_DanIndex_upper2 = string.find(title, "Dan");
	--local en_DanIndex_lower = string.find(title, "dan");


local DanniNinteiFolderName = {
	"Danni_Nintei_SP",
	"Danni_Nintei_SP_forPlay",
	"Danni_Nintei_DP",
	"Danni_Nintei_DP_forPlay",
};
local isDan = false;
local grName = "";

if GAMESTATE:IsCourseMode() then
	grName = GAMESTATE:GetCurrentCourse():GetGroupName();
end;

for i = 1,#DanniNinteiFolderName do
	if grName == DanniNinteiFolderName[i] then
		isDan = true;
	end;
end;


--Course
if GAMESTATE:IsCourseMode() then
	local title = GAMESTATE:GetCurrentCourse():GetDisplayFullTitle();
	disp_stage = "Course";
	if isDan then 
		disp_stage = "Dan";
	end;

elseif PREFSMAN:GetPreference("EventMode") then
	disp_stage = "Stage_Event";

	--Final
elseif StageIndex == FinalIndex then
	disp_stage = "Stage_Final";
--Extra1
elseif StageIndex == FinalIndex+1 then
	disp_stage = "Stage_Extra1";
--Extra2
elseif StageIndex == FinalIndex+2 then
	disp_stage = "Stage_Extra2";
else
	if StageIndex == 1 then
		disp_stage = "Stage_1st";
	elseif StageIndex == 2 then
		disp_stage = "Stage_2nd";
	elseif StageIndex == 3 then
		disp_stage = "Stage_3rd";
	elseif StageIndex == 4 then
		disp_stage = "Stage_4th";
	elseif StageIndex == 5 then
		disp_stage = "Stage_5th";
	elseif StageIndex == 6 then
		disp_stage = "Stage_6th";
	end;
end;



t[#t+1] = LoadActor("EvalStageDisplay/"..disp_stage)..{

	InitCommand = function(self)
		--self:x(SCREEN_CENTER_X);
		--self:y(SCREEN_CENTER_Y);
		self:zoomx(0.72*1.28);
		self:zoomy(0.55*1.28);
		self:x(327);
		self:y(8+9);

	end;

};

--[[t[#t+1] = LoadFont("_itc avant garde std bk 20px")..{

	InitCommand = function(self)

		
		
		self:settext(" Stage = "..Stage.." \n"..
					" StageIndex = "..StageIndex.."\n"..
					" FinalNum="..FinalIndex.."\n"..
					" FullTitle="..title);

		
		self:x(SCREEN_CENTER_X-100);
		self:y(SCREEN_CENTER_Y-100);


		self:diffuse(color("#000000"));
		self:zoom(0);
		self:horizalign(left);
	
	end;
};]]


return t;