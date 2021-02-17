local t = Def.ActorFrame{};

local isDouble = GAMESTATE:GetCurrentStyle():GetStepsType()=="StepsType_Dance_Double";
local tit="";
if GAMESTATE:IsCourseMode() then
	song=GAMESTATE:GetCurrentCourse();
	tit=song:GetDisplayFullTitle();
else
	song=GAMESTATE:GetCurrentSong();
	tit=song:GetDisplayFullTitle();
end;

local data =GAMESTATE:GetCurrentTrail(PLAYER_1);
local radar = GAMESTATE:GetCurrentSteps(PLAYER_1):GetRadarValues(PLAYER_1);
local baseScore = 1000000/(radar:GetValue('RadarCategory_TapsAndHolds')+radar:GetValue('RadarCategory_Holds')+radar:GetValue('RadarCategory_Rolls'));
local stepall = radar:GetValue('RadarCategory_TapsAndHolds')+radar:GetValue('RadarCategory_Holds')+radar:GetValue('RadarCategory_Rolls');
local rivalScore = 999800;

rivalScore = 0;
local rivaltapscore = {};
local rivalFC = 1;

for kk = 1,stepall do
	rivaltapscore[kk] = math.random(300);
	if rivaltapscore[kk] < 2 then
		rivaltapscore[kk] = 3;
	elseif rivaltapscore[kk] < 20 then
		rivaltapscore[kk] = 2;
	else
		rivaltapscore[kk] = 1;
	end;
	
	local addsc = baseScore;
	if rivaltapscore[kk]==2 then
		addsc=addsc-10;
		if rivalFC < 2 then rivalFC = 2; end;
	elseif rivaltapscore[kk]==3 then
		addsc=addsc*0.6-10;
		if rivalFC < 3 then rivalFC = 3; end;
	elseif rivaltapscore[kk]==4 then
		addsc=addsc*0.2-10;
		if rivalFC < 4 then rivalFC = 4; end;
	elseif rivaltapscore[kk]==5 then
		if rivalFC < 5 then rivalFC = 5; end;
		addsc=0;
	end;
			
	rivalScore = rivalScore + addsc;
end;



local currivalScore = 0;
local curmyScore = 0;


local rvStr = tostring(math.round(rivalScore/10)*10);
local infoStr = "";

if rivalScore >= 990000 then
	infoStr = "AAA";
elseif rivalScore >= 950000 then
	infoStr = "AA+";
elseif rivalScore >= 900000 then
	infoStr = "AA";
elseif rivalScore >= 890000 then
	infoStr = "AA-";
elseif rivalScore >= 850000 then
	infoStr = "A+";
elseif rivalScore >= 800000 then
	infoStr = "A";
elseif rivalScore >= 790000 then
	infoStr = "A-";
end;

if rivalFC == 1 then
	infoStr = infoStr .. "   Marvelous Fullcombo";
elseif rivalFC == 2 then
	infoStr = infoStr .. "   Perfect Fullcombo";
elseif rivalFC == 3 then
	infoStr = infoStr .. "   Full Combo";
elseif rivalFC == 4 then
	infoStr = infoStr .. "   Full Combo";
end;

local marvCount = 0;
local perfCount = 0;
local greatCount = 0;
local goodCount = 0;
local missCount = 0;

local pnumBefore = 0;
local deltaScore = 0;

--[ja]ノーツ毎に記録するので、配列の動的確保が必要
local tapScoreAtMoment = {};
local notesCount = 1;

--[ja]"W1"などと書くと長ったらしいので 1 2 3 4 5で記録




t[#t+1] = LoadFont("rivalnum")..{
--t[#t+1] = LoadFont("_itc avant garde std bk 50px")..{

	InitCommand=function(self)
		self:draworder(100);
		self:player(PLAYER_1);
		self:x(SCREEN_CENTER_X-290);
		self:y(SCREEN_CENTER_Y-73);
		if isDouble then
			self:x(SCREEN_CENTER_X+60);
		end;
		self:horizalign(right);
		self:settext("0");
		self:zoomy(0.44);
		self:zoomx(0.44)
		self:diffuse(color("#FFFFFF"));
		self:diffusealpha(1);
		self:diffusealpha(0);
	end;
	--OffCommand=cmd(linear,0.15;addy,300);

	JudgmentMessageCommand = function(self,params)

		--if params.Player ~= player then return end;
		self:player(params.Player);
		self:diffusealpha(1);
		
		--Marvelous
		if params.TapNoteScore=='TapNoteScore_W1' then
			marvCount=marvCount+1;
			tapScoreAtMoment[notesCount]="Marvelous";
			notesCount=notesCount+1;

		--Perfect
		elseif params.TapNoteScore=='TapNoteScore_W2' then
			perfCount=perfCount+1;
			tapScoreAtMoment[notesCount]="Perfect";
			notesCount=notesCount+1;

		--Great
		elseif params.TapNoteScore=='TapNoteScore_W3' then
			greatCount=greatCount+1;
			tapScoreAtMoment[notesCount]="Great";
			notesCount=notesCount+1;

		--Good
		elseif params.TapNoteScore=='TapNoteScore_W4' then
			goodCount=goodCount+1;
			tapScoreAtMoment[notesCount]="Good";
			notesCount=notesCount+1;

		--Miss
		elseif params.TapNoteScore=='TapNoteScore_CheckpointMiss' 
			or params.TapNoteScore=='TapNoteScore_W5' 
			or params.TapNoteScore=='TapNoteScore_Miss' then
			missCount=missCount+1;
			tapScoreAtMoment[notesCount]="Miss";
			notesCount=notesCount+1;

		end;
		
		totalStep = marvCount+perfCount+greatCount+goodCount+missCount;
		curPos = totalStep/stepall;
		
		rivaltotallose = 1000000 - rivalScore;
		currivalScore = 1000000 - rivaltotallose * curPos;
		
		currivalScore = 0;
		for r_st = 1,totalStep do
			curRJ = baseScore;
			if rivaltapscore[r_st]==2 then
				curRJ=curRJ-10;
			elseif rivaltapscore[r_st]==3 then
				curRJ=curRJ*0.6-10;
			elseif rivaltapscore[r_st]==4 then
				curRJ=curRJ*0.2-10;
			elseif rivaltapscore[r_st]==5 then
				curRJ=0;
			end;
			
			currivalScore = currivalScore + curRJ;
		end;
		
		curmyScore = baseScore * marvCount
					+(baseScore-10) * perfCount
					+(baseScore*0.6-10) * greatCount
					+(baseScore*0.2-10) * goodCount;
					
		--deltaScore = math.round((curmyScore-currivalScore)/10)*10;
		deltaScore = math.round((curmyScore)/10)*10-math.round((currivalScore)/10)*10;
		

		
		
		
		--[[
		deltaScore = math.round((1000000
		           +(-10)*perfCount
				   +(-baseScore*0.4-10)*greatCount
				   +(-baseScore*0.8-10)*goodCount
				   +(-baseScore*1.0-10)*missCount
				   -currivalScore)/10)*10;
		]]--
		
		local signSc = "";
		if deltaScore < 0 then
			self:diffuse(color("#FF6666"));
			signSc = "m";
		elseif deltaScore < 10 and deltaScore > -10 then
			self:diffuse(color("#FFFFFF"));
			signSc = "e";
		else
			self:diffuse(color("#6677FF"));
			signSc = "p";
		end;
		
		deltaScore = (deltaScore < 0) and -deltaScore or deltaScore;
		
		

		
		self:settext(signSc..deltaScore);
		
		
		
		--[[
		if params.TapNoteScore=='TapNoteScore_W1' and LowerJudge[p]<1 then
			LowerJudge[p]=1;
		elseif params.TapNoteScore=='TapNoteScore_W2' and LowerJudge[p]<2 then
			LowerJudge[p]=2;
		elseif params.TapNoteScore=='TapNoteScore_W3' and LowerJudge[p]<3 then
			LowerJudge[p]=3;
		elseif params.TapNoteScore=='TapNoteScore_W4' and LowerJudge[p]<4 then
			LowerJudge[p]=4;
		elseif params.TapNoteScore=='TapNoteScore_CheckpointMiss' 
			or params.TapNoteScore=='TapNoteScore_W5' 
			or params.TapNoteScore=='TapNoteScore_Miss' then
			LowerJudge[p]=0;
		end;
		]]--
	end;
	
	
};


t[#t+1] = LoadFont("_itc avant garde std bk 50px")..{
	InitCommand = function(self)
		self:shadowlength(2);
		self:draworder(100);
		self:player(PLAYER_1);
		self:x(SCREEN_CENTER_X-370);
		self:y(SCREEN_CENTER_Y-120);
		if isDouble then
			self:x(SCREEN_CENTER_X);
		end;
		self:horizalign(center);
		self:settext("RIVAL SCORE");
		self:zoomy(0.7*0.5);
		self:zoomx(1*0.5)
		self:diffuse(color("#FFFFFF"));
		self:diffusealpha(1);
		self:sleep(3);
		self:linear(0.7);
		self:diffusealpha(0);
	end;
}
t[#t+1] = LoadFont("_itc avant garde std bk 50px")..{

	Name = 'DownScore';
	
	InitCommand = function(self)
		self:shadowlength(2);
		self:draworder(100);
		self:player(PLAYER_1);
		self:x(SCREEN_CENTER_X-370);
		self:y(SCREEN_CENTER_Y-90);
		if isDouble then
			self:x(SCREEN_CENTER_X);
		end;
		self:horizalign(center);
		self:settext(rvStr);
		self:zoomy(0.7);
		self:zoomx(0.8)
		self:diffuse(color("#FFFFFF"));
		self:diffusealpha(1);
		self:sleep(3);
		self:decelerate(0.7);
		self:diffusealpha(0.2);
		self:y(SCREEN_BOTTOM-106);
		self:x(SCREEN_CENTER_X);
		self:settext(rvStr);
	end;
	
	JudgmentMessageCommand = function(self,params)
		self:settext(tostring(math.round((currivalScore)/10)*10).." / "..rvStr);
		
	end;
}
t[#t+1] = LoadFont("_itc avant garde std bk 50px")..{
	InitCommand = function(self)
		self:shadowlength(2);
		self:draworder(100);
		self:player(PLAYER_1);
		self:x(SCREEN_CENTER_X-370);
		self:y(SCREEN_CENTER_Y-60);
		if isDouble then
			self:x(SCREEN_CENTER_X);
		end;
		self:horizalign(center);
		self:settext(infoStr);
		self:zoomy(0.7*0.5);
		self:zoomx(0.7*0.5)
		self:diffuse(color("#FFFFFF"));
		self:diffusealpha(1);
		self:sleep(3);
		self:linear(0.7);
		self:diffusealpha(0);
	end;
}


--[[

t[#t+1] = LoadFont("_itc avant garde std bk 50px")..{


	Name = 'Sumidagawa';

	InitCommand = function(self)
		self:draworder(100);
		self:player(PLAYER_1);
		--self:x(SCREEN_CENTER_X+410);
		--self:y(SCREEN_BOTTOM-10);
		
		self:x(SCREEN_CENTER_X-600);
		self:y(SCREEN_BOTTOM-490);

		self:horizalign(left);
		self:vertalign(bottom);
		self:zoomy(1*0.6);
		self:zoomx(1*0.6)
		self:diffuse(color("#FFFFFF"));
		self:diffusealpha(1);

		self:settext();
	end;

	JudgmentMessageCommand= function(self,params)
		self:queuecommand('On');
	end;


	OnCommand = function(self,params)

		self:sleep(0.04);

		local string = "";
		for ix = 1,#tapScoreAtMoment do
			--local xx = ix;
			string = string..""..tostring(ix).."/"..tostring(stepall).." : ";
			string = string..tostring(tapScoreAtMoment[ix]);
			string = string.." vs "
			string = string..tostring(numToJud(rivaltapscore[ix]));
			string = string.."\n";
		end;
		self:settext(string);

	end;

};

]]--


function numToJud(jn)

	if jn == 1 then
		return "Marvelous";
	elseif jn == 2 then
		return "Perfect";
	elseif jn == 3 then
		return "Great";
	elseif jn == 4 then
		return "Good";
	elseif jn == 5 then
		return "Miss";
	end;
	
	return 0;
end;


return t;
