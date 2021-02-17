local t = Def.ActorFrame{
	OnCommand=function(s)
		SOUND:PlayOnce(THEME:GetPathS("","_swooshInstructions"))
	end,
	OffCommand=function(s)
		SOUND:PlayOnce(THEME:GetPathS("","_swooshInstructions"))
	end
};

if GAMESTATE:IsHumanPlayer(PLAYER_1) then
	t[#t+1] = LoadActor("options.lua",PLAYER_1);
end;

if GAMESTATE:IsHumanPlayer(PLAYER_2) then
	t[#t+1] = LoadActor("options.lua",PLAYER_2);
end;


return t;
