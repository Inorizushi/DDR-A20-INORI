--[[ GuideLine(BETA) PLAYER_1]]
--by Wyvern-D@xinomav 190606

--This is testing stuff,please change "default.lua" to turn it on

local thickness = 3;
local mainAlpha = 0.9;
local subAlpha = 0.2;

local singleWidth = 380;
local doubleWidth = 760;


local t = Def.ActorFrame{};

local offsetY = 120;

if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'reverse') then
	offsetY = 596;
end;

local isDouble = GAMESTATE:GetCurrentStyle():GetStepsType()=="StepsType_Dance_Double";



--[ja]拍ごとにラインを描画
for i = 0,800,1 do

	t[#t+1] = Def.Quad{
		
		InitCommand = function(self)
			self:player(PLAYER_1);
			self:zoomto(380,thickness);
			self:diffusecolor(color("1,1,1,1"));
			if (i%4==0) then
				self:diffusealpha(mainAlpha);
			else
				self:diffusealpha(subAlpha);
			end;

			if isDouble then
				self:x(SCREEN_CENTER_X);
				self:zoomto(doubleWidth,thickness);
			else
				self:x(SCREEN_CENTER_X-370);
				self:zoomto(singleWidth,thickness);
			end;

			self:y(SCREEN_TOP+offsetY+i*UnitBySpeedModP1(GetCurrentSpeedModP1()));
		end;

		OnCommand = function(self)
			local curY=SCREEN_TOP+offsetY+i*UnitBySpeedModP1(GetCurrentSpeedModP1());
			self:y(curY);
		end;

		--[ja]一個手前のハイスピで調整される(コマンド毎の対応で修正済)
		CodeMessageCommand=function(self, params)
			if params.PlayerNumber == PLAYER_1 then
				--self:playcommand("On");

				if params.Name == "SpeedUp" then
					local curY=SCREEN_TOP+offsetY+i*UnitBySpeedModP1(GetUpperSpeedP1(GetCurrentSpeedModP1()));
					self:y(curY);
				elseif params.Name == "SpeedDown" then
					local curY=SCREEN_TOP+offsetY+i*UnitBySpeedModP1(GetLowerSpeedP1(GetCurrentSpeedModP1()));
					self:y(curY);
				end;
			end;
		end;
		
	};
end;


--[ja]小節番号(iで位置を指定すれば任意の場所に文字を置ける)
--for i = 0,100,1 do
--
--	t[#t+1] = LoadFont("_arial black 28px")..{
--			InitCommand = function(self)
--				self:player(PLAYER_1);
--				self:zoom(5.5);
--				self:x(SCREEN_CENTER_X-150);
--				self:y(SCREEN_TOP+100+i*(4*UnitBySpeedModP1()));
--				--self:horizalign(left);
--				self:horizalign(center);
--				self:diffusealpha(0.2);
--				self:queuecommand("Update");
--				self:maxwidth(380);
--			end;
--
--			OnCommand=function(self)
--				self:settext(i);
--				if i==0 then
--					self:addx(-370);
--					self:settext("START");
--				end;
--
--			end;
--
--			UpdateCommand = function(self)
--			--self:x(SCREEN_CENTER_X);
--			--self:addx(1);
--				self:maxwidth(380);
--				self:x(SCREEN_CENTER_X-150-220);
--				self:y(SCREEN_TOP+offsetY+i*4*UnitBySpeedModP1()+50);
--				self:sleep(0.05);
--				self:queuecommand("Update");
--			end;
--
--	};
--end;






local function GLScroll(self)
	local song = GAMESTATE:GetCurrentSong();
	if song then

		local start = song:GetFirstBeat();
		local last = song:GetLastBeat();
		local cur = GAMESTATE:GetSongBeat();
		
		self:y(cur*(0-UnitBySpeedModP1(GetCurrentSpeedModP1())));

		--[ja]スクリーンフィルタに揃える
		if (GAMESTATE:GetSongBeat() >= last) then
			self:visible(false);
		elseif (GAMESTATE:GetSongBeat() >= start-16) then
			self:visible(true);
		else
			--self:visible(true);
			self:visible(false);
		end;
		
	end;
end;



t.InitCommand=cmd(SetUpdateFunction,GLScroll);


function UnitBySpeedModP1(sm)

	if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'reverse') then
		return -96 * sm;
	else
		return 96 * sm;
	end;

end;

function GetUpperSpeedP1(cur_hispeed)

	if cur_hispeed == 8 then
		return 8;
	else
		return cur_hispeed+0.25;
	end;

	return 1;

end;

function GetLowerSpeedP1(cur_hispeed)

	if cur_hispeed == 0.5 then
		return 0.5;
	else
		return cur_hispeed-0.25;
	end;

	return 1;

end;

function GetCurrentSpeedModP1()

	local hispeed = 1;

	if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'0.25x') then
		hispeed=0.25;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'0.5x') then
		hispeed=0.5;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'0.75x') then
		hispeed=0.75;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'1x') then
		hispeed=1;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'1.25x') then
		hispeed=1.25;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'1.5x') then
		hispeed=1.5;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'1.75x') then
		hispeed=1.75;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'2x') then
		hispeed=2;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'2.25x') then
		hispeed=2.25;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'2.5x') then
		hispeed=2.5;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'2.75x') then
		hispeed=2.75;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'3x') then
		hispeed=3;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'3.25x') then
		hispeed=3.25;   
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'3.5x') then
		hispeed=3.5;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'3.75x') then
		hispeed=3.75;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'4x') then
		hispeed=4;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'4.25x') then
		hispeed=4.25;   
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'4.5x') then
		hispeed=4.5;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'4.75x') then
		hispeed=4.75;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'5x') then
		hispeed=5;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'5.25x') then
		hispeed=5.25;   
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'5.5x') then
		hispeed=5.5;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'5.75x') then
		hispeed=5.75;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'6x') then
		hispeed=6;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'6.25x') then
		hispeed=6.25;   
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'6.5x') then
		hispeed=6.5;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'6.75x') then
		hispeed=6.75;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'7x') then
		hispeed=7;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'7.25x') then
		hispeed=7.25;   
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'7.5x') then
		hispeed=7.5;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'7.75x') then
		hispeed=7.75;
	elseif GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'8x') then
		hms=8;
	end;



	return hispeed;

end;

return t;