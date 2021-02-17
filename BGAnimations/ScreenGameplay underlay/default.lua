local t = Def.ActorFrame{};

if FILEMAN:DoesFileExist("Themes/Random/default.lua") then
t[#t+1] = LoadActor("../../../Random")..{
	OnCommand=function(self)
	local song = GAMESTATE:GetCurrentSong();
	if song then
		if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'StaticBG') or GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'StaticBG') or song:HasBGChanges() then
		self:diffusealpha(0);
		else
		self:diffusealpha(1);
		end;
		end;
	end;
	CurrentSongChangedMessageCommand=function(self)
	local song = GAMESTATE:GetCurrentSong();
	if song then
		if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'StaticBG') or GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'StaticBG') or song:HasBGChanges() then
		self:diffusealpha(0);
		else
		self:diffusealpha(1);
		end;
		end;
	end;
	};
end;

t[#t+1] = LoadActor("../ScreenGameplay Danger");
	--LoadActor("danger");
t[#t+1] = LoadActor("ScreenFilter");

--[ja]190606 Double Fixed
local dispnameP1 = (GAMESTATE:IsHumanPlayer(PLAYER_1)) and
			PROFILEMAN:GetProfile(PLAYER_1):GetDisplayName() or "";
local dispnameP2 = (GAMESTATE:IsHumanPlayer(PLAYER_2)) and
			PROFILEMAN:GetProfile(PLAYER_2):GetDisplayName() or "";

local betaMembers = {
	"WVN-DVT.",
	"Hellghast",
	"MASA-INP",
	"Arbel",
	"trical",
	"yuisin",
	"Stormy",
	"G-SUS093",
	"JESUS093",
	"MACARON",
	"PLAYER 1",
	"PLAYER 2"
};

local viewGDp1 = false;
local viewGDp2 = false;

for ii = 1,#betaMembers do
	if dispnameP1 == betaMembers[ii] then
		viewGDp1 = true;
	end;
	if dispnameP2 == betaMembers[ii] then
		viewGDp2 = true;
	end;
end;

if viewGDp1 then
	t[#t+1] = LoadActor("GuideLine_p1")..{};
end;

if viewGDp2 then
	t[#t+1] = LoadActor("GuideLine_p2")..{};
end;

t[#t+1] = LoadActor("../../Other/_/alphaMembers")..{};

return t;