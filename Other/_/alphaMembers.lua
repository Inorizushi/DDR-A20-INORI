local t = Def.ActorFrame{};

alphaMembers = {
	"VR0",
	"kitty kitty bang bang",
	"TC19",
	"4199 <3",
};
local dispnameP1 = (GAMESTATE:IsHumanPlayer(PLAYER_1)) and
			PROFILEMAN:GetProfile(PLAYER_1):GetDisplayName() or "";
local dispnameP2 = (GAMESTATE:IsHumanPlayer(PLAYER_2)) and
			PROFILEMAN:GetProfile(PLAYER_2):GetDisplayName() or "";

function isAlpha(drawVal)
	for ii = 1,#alphaMembers do
		if dispnameP1 == alphaMembers[ii] or dispnameP2 == alphaMembers[ii] then
			return true;
		end;
	end;
	return false;
end;

if isAlpha(0) then
	t[#t+1] = Def.Quad{
		InitCommand=cmd(CenterX;CenterY;diffusealpha,1;diffuse,color("#0000FF");setsize,SCREEN_WIDTH,SCREEN_HEIGHT);
	};
	t[#t+1] = LoadActor("beep(loop)")..{
		OnCommand=cmd(play);
	};
	--t[#t+1] = LoadActor("_Spacing")..{};
end;

return t;