local t = Def.ActorFrame {};
local gc = Var("GameCommand");
local max_stages = PREFSMAN:GetPreference( "SongsPerPlay" );
local index = gc:GetIndex();
local c = 0;
if index == 0 then
	c = 1;
elseif index == 1 then
	c = 1;
elseif index == 2 then
	c = 0;
elseif index == 3 then
	c = 0;
elseif index == 4 then
	c = 0;
end
--------------------------------------
t[#t+1] = Def.ActorFrame {
    LoadActor("preview " .. gc:GetName() ) .. {
	OnCommand=cmd();
	GainFocusCommand=cmd(stoptweening;decelerate,0.125;zoom,1;y,SCREEN_CENTER_Y-350);
	LoseFocusCommand=cmd(stoptweening;decelerate,0.125;zoom,0.7;y,SCREEN_CENTER_Y-400);
	OffCommand=cmd(stoptweening;sleep,0.2;decelerate,0.125;zoomy,0);
	};
};

return t;
