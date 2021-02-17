--[[ Screen Filter ]]
local numPlayers = GAMESTATE:GetNumPlayersEnabled()
local center1P = PREFSMAN:GetPreference("Center1Player")

local padding = 8 -- 4px on each side
local arrowWidth = 64 -- until noteskin metrics are implemented...



local filterColor = color("0,0,0,1")
local filterAlphas = {
	PlayerNumber_P1 = 1,
	PlayerNumber_P2 = 1,
	Default = 0,
}

local t = Def.ActorFrame{};

local style = GAMESTATE:GetCurrentStyle()
local cols = style:ColumnsPerPlayer()
local styleType = ToEnumShortString(style:GetStyleType())
local filterWidth = (arrowWidth * cols) + padding

if numPlayers == 1 then
	local player = GAMESTATE:GetMasterPlayerNumber()
	local pNum = (player == PLAYER_1) and 1 or 2
	local PlayerUID = PROFILEMAN:GetProfile(player):GetGUID()  
	filterAlphas[player] = ReadOrCreateScreenFilterValueForPlayer(PlayerUID,filterAlphas[player])
	
	--filterAlphas[player] = tonumber(getenv("ScreenFilterP"..pNum));

	local pos;
	-- [ScreenGameplay] PlayerP#Player*Side(s)X
	if center1P then
		pos = SCREEN_CENTER_X
	else
		local metricName = string.format("PlayerP%i%sX",pNum,styleType)
		pos = THEME:GetMetric("ScreenGameplay",metricName)
	end
	t[#t+1] = Def.Quad{
		Name="SinglePlayerFilter";
		InitCommand=cmd(x,pos;CenterY;zoomto,filterWidth*1.6,SCREEN_HEIGHT;diffusecolor,filterColor;diffusealpha,filterAlphas[player];fadeleft,1/18;faderight,1/18);
			HealthStateChangedMessageCommand=function(self, param)

					if param.PlayerNumber == PLAYER_1 and pNum == 1 then
						if param.HealthState == "HealthState_Danger" then
							self:diffusealpha(0);
						else
							self:diffusealpha(filterAlphas[player]);
						end
					elseif param.PlayerNumber == PLAYER_2 and pNum == 2 then
						if param.HealthState == "HealthState_Danger" then
							self:diffusealpha(0);
						else
							self:diffusealpha(filterAlphas[player]);
						end
					end;

				end;
	};
else
	-- two players... a bit more complex.
	if styleType == "TwoPlayersSharedSides" then
		-- routine, just use one in the center.
		local player = GAMESTATE:GetMasterPlayerNumber()
		local pNum = player == PLAYER_1 and 1 or 2
		local metricName = "PlayerP".. pNum .."TwoPlayersSharedSidesX"
		t[#t+1] = Def.Quad{
			Name="RoutineFilter";
			InitCommand=cmd(x,THEME:GetMetric("ScreenGameplay",metricName);CenterY;zoomto,filterWidth*1.6,SCREEN_HEIGHT;diffusecolor,filterColor;diffusealpha,filterAlphas[player];fadeleft,1/18;faderight,1/18);
		};
	else
		-- otherwise we need two separate ones. to the pairsmobile!
		for i, player in ipairs(PlayerNumber) do
			local pNum = (player == PLAYER_1) and 1 or 2
			local PlayerUID = PROFILEMAN:GetProfile(player):GetGUID()  
			filterAlphas[player] = ReadOrCreateScreenFilterValueForPlayer(PlayerUID,filterAlphas[player])
			--filterAlphas[player] = tonumber(getenv("ScreenFilterP"..pNum));
			local metricName = string.format("PlayerP%i%sX",pNum,styleType)
			local pos = THEME:GetMetric("ScreenGameplay",metricName)
			t[#t+1] = Def.Quad{
				Name="Player"..pNum.."Filter";
				InitCommand=cmd(x,pos;CenterY;zoomto,filterWidth*1.6,SCREEN_HEIGHT;diffusecolor,filterColor;diffusealpha,filterAlphas[player];fadeleft,1/18;faderight,1/18);

				HealthStateChangedMessageCommand=function(self, param)

					if param.PlayerNumber == PLAYER_1 and pNum == 1 then
						if param.HealthState == "HealthState_Danger" then
							self:diffusealpha(0);
						else
							self:diffusealpha(filterAlphas[player]);
						end
					elseif param.PlayerNumber == PLAYER_2 and pNum == 2 then
						if param.HealthState == "HealthState_Danger" then
							self:diffusealpha(0);
						else
							self:diffusealpha(filterAlphas[player]);
						end
					end;

				end;
			};
		end
	end
end
local function FilterUpdate(self)
	local song = GAMESTATE:GetCurrentSong();
	if song then


		local start = song:GetFirstBeat();
		local last = song:GetLastBeat();
		if (GAMESTATE:GetSongBeat() >= last) then
			self:visible(false);
		elseif (GAMESTATE:GetSongBeat() >= start-16) then
			self:visible(true);
		else
			self:visible(false);
		end;


	end;
end;

t.InitCommand=cmd(SetUpdateFunction,FilterUpdate);

t.HealthStateChangedMessageCommand=function(self, param)
local isDanger = (param.HealthState == "HealthState_Danger");
		if isDanger then
			--[20190523] error with versus play
			--self:zoomy(0);
		else
			--self:zoomy(1);
		end;
end;

return t;