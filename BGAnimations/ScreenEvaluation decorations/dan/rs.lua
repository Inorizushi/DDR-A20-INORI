local t = Def.ActorFrame {};


--[ja]段位コースかどうかの判定
if not GAMESTATE:IsCourseMode() then
	return t;
end;

local grName = "";
grName = GAMESTATE:GetCurrentCourse():GetGroupName();

local DanniNinteiFolderName = {
	"Danni_Nintei_SP",
	"Danni_Nintei_SP_forPlay",
	"Danni_Nintei_DP",
	"Danni_Nintei_DP_forPlay",
};

local isDan = false;

for ix = 1,#DanniNinteiFolderName do
	if grName == DanniNinteiFolderName[ix] then
		isDan = true;
	end;
end;

if not isDan then return t; end;

--[ja]合格かどうかの判定
local isPassed = true;

if(STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P1"):GetGrade()=="Grade_Failed") then
	isPassed = false;
end;



local strOfPass = (isPassed) and "Pass" or "Fail";
local waitLightTime = 2;
local backBlackAlpha = 0.5;

t[#t+1] = LoadActor("dan_snd")..{
		OnCommand=cmd(play);
	};

--[ja]背景
t[#t+1] = LoadActor("rs_black")..{

	InitCommand=function(self)
		self:diffusealpha(0);
		self:sleep(waitLightTime);
		self:diffusealpha(backBlackAlpha);
		
		self:x(SCREEN_CENTER_X);
		self:y(SCREEN_CENTER_Y);
		self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT);
		self:diffusealpha(backBlackAlpha);
		self:sleep(2+0.3+0.2+0.5);
		self:linear(0.5);
		self:diffusealpha(0);
	end;
	
	OffCommand=cmd(linear,0.15;diffusealpha,0);

};


--0 1 2 3
--0 1 0 1
--0 0 1 1

--[ja]集まる光
for i=0,3,1 do
t[#t+1] = LoadActor("rs_fourlight")..{

	InitCommand=function(self)
		self:diffusealpha(0);
		self:sleep(waitLightTime);
		self:diffusealpha(0.7);
		self:zoom(2);
		
		self:zoom(0.6);
		self:x((i-(i%2))/2*SCREEN_WIDTH);
		self:y(i%2*SCREEN_HEIGHT);
		self:linear(0.5);
		self:x(SCREEN_CENTER_X);
		self:y(SCREEN_CENTER_Y);
		self:linear(0.1);
		self:diffusealpha(0);
	end;

};
end;

if isPassed then

--[ja]後光
for j =0,1,1 do
t[#t+1] = LoadActor("rs_backlight")..{

	InitCommand=function(self)
		self:diffusealpha(0);
		self:sleep(waitLightTime+0.5);
		self:diffusealpha(1);
		
		
		self:x(SCREEN_CENTER_X);
		self:y(SCREEN_CENTER_Y);
		self:zoom(0.45+1);
		
		self:diffusealpha(0.6);
		self:linear(1);
		self:diffusealpha(1);
		self:linear(1);
		self:diffusealpha(0.6);
		self:zoom(0.5+1);
		self:linear(0.3);
		self:zoom(0.51+1);
		self:diffusealpha(0);
		self:linear(0.3+1);
		self:zoom(2.3);
		self:diffusealpha(0);
	end;
	
	OffCommand=cmd(linear,0.15;diffusealpha,0);

};
end;

--[ja]線
t[#t+1] = LoadActor("rs_sideline")..{

	InitCommand=function(self)
	
		self:blend('BlendMode_Add');
		self:diffusealpha(0);
		self:sleep(waitLightTime+0.5);
		self:diffusealpha(1);
		self:y(SCREEN_CENTER_Y-50);
		self:zoomx(0.8);
		self:zoomy(0.4);
		
		self:x(SCREEN_CENTER_X-600);
		self:diffusealpha(0.2);
		
		self:linear(1);
		self:diffusealpha(0.4);
		self:x(SCREEN_CENTER_X-400);
		
		self:linear(1);
		self:diffusealpha(0);
		self:x(SCREEN_CENTER_X-200);
	end;
};

--[ja]線
t[#t+1] = LoadActor("rs_sideline")..{

	InitCommand=function(self)
	
		self:blend('BlendMode_Add');
		self:diffusealpha(0);
		self:sleep(waitLightTime+0.5);
		self:diffusealpha(1);
		self:y(SCREEN_CENTER_Y+90);
		self:zoomx(-0.8);
		self:zoomy(0.8);
		
		self:x(SCREEN_CENTER_X+600);
		self:diffusealpha(0.2);
		
		self:linear(1);
		self:diffusealpha(0.7);
		self:x(SCREEN_CENTER_X+400);
		
		self:linear(1);
		self:diffusealpha(0);
		self:x(SCREEN_CENTER_X+200);
	end;
};

end;

if not isPassed then

--[ja]暗いやつ
t[#t+1] = LoadActor("rs_dark")..{

	InitCommand=function(self)
	
		self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT);
		self:x(SCREEN_CENTER_X);
		self:y(SCREEN_TOP);
		self:diffusealpha(0);
		self:sleep(waitLightTime+0.5);
		self:diffusealpha(0.5);
		self:linear(0.3);
		self:y(SCREEN_CENTER_Y);
		--self:zoom(1);
		
		self:sleep(2);
		self:linear(0.3);
		self:diffusealpha(0);
	end;
};

end;

--[ja]メインの文字
t[#t+1] = LoadActor("rs_"..strOfPass)..{

	InitCommand=function(self)
		self:diffusealpha(0);
		self:sleep(waitLightTime+0.5);
		self:diffusealpha(1);
		
		
		self:x(SCREEN_CENTER_X);
		self:y(SCREEN_CENTER_Y);
		self:zoom(0.45);
		self:linear(2);
		self:zoom(0.5);
		self:linear(0.3);
		self:zoom(0.51);
		self:linear(0.3);
		self:zoom(2.3);
		self:diffusealpha(0);
	end;
	
	OffCommand=cmd(linear,0.15;diffusealpha,0);

};


--[ja]メインの文字の波動
t[#t+1] = LoadActor("rs_"..strOfPass)..{

	InitCommand=function(self)
		self:diffusealpha(0);
		self:sleep(waitLightTime+0.5);
		self:diffusealpha(1);
		
		self:x(SCREEN_CENTER_X);
		self:y(SCREEN_CENTER_Y);
		self:diffusealpha(1);
		self:zoom(0.45);
		self:linear(0.9);
		self:diffusealpha(0);
		if isPassed then
			self:zoom(0.7);
		else
			self:zoom(0.6);
		end;
	end;
	
	OffCommand=cmd(linear,0.15;diffusealpha,0);

};

if isPassed then

--[ja]レンズフレア1
t[#t+1] = LoadActor("rs_flare")..{

	InitCommand=function(self)
	
		self:blend('BlendMode_Add');
		self:diffusealpha(0);
		self:sleep(waitLightTime+0.5);
		self:diffusealpha(1);
		self:y(SCREEN_CENTER_Y-20);
		self:zoom(0.8);
		
		self:x(SCREEN_CENTER_X-400);
		self:diffusealpha(0.2-0.1);
		
		self:linear(1);
		self:diffusealpha(0.09);
		self:x(SCREEN_CENTER_X-200);
		
		self:linear(1);
		self:diffusealpha(0);
		self:x(SCREEN_CENTER_X);
	end;
};

--[ja]レンズフレア2
t[#t+1] = LoadActor("rs_flare")..{

	InitCommand=function(self)
	
		self:blend('BlendMode_Add');
		self:diffusealpha(0);
		self:sleep(waitLightTime+0.5);
		self:diffusealpha(1);
		self:y(SCREEN_CENTER_Y+90);
		self:zoom(0.8);
		
		self:x(SCREEN_CENTER_X+600);
		self:diffusealpha(0.2);
		
		self:linear(1);
		self:diffusealpha(1);
		self:x(SCREEN_CENTER_X+400);
		
		self:linear(1);
		self:diffusealpha(0);
		self:x(SCREEN_CENTER_X+200);
	end;
};

end;


return t;

