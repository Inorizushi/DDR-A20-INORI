local t = Def.ActorFrame{};
if PREFSMAN:GetPreference("PercentageScoring")==true and PREFSMAN:GetPreference("DancePointsForOni")==true then
-- if true then
	if GAMESTATE:GetPlayMode() ~='PlayMode_Oni' then

		t[#t+1] = LoadFont("_Newsanse Heavy")..{
			InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_CENTER_X-440-100;y,SCREEN_CENTER_Y+305;diffusealpha,1;shadowlength,1;zoomx,1.2;zoomy,1;diffuse,Color("Yellow"));
			OnCommand=function(self)
				self:settext("EX");
			end;
		};	
		t[#t+1] = LoadFont("_Newsanse Heavy")..{
			InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_CENTER_X+440-100;y,SCREEN_CENTER_Y+305;diffusealpha,1;shadowlength,1;zoomx,1.2;zoomy,1;diffuse,Color("Yellow"));
			OnCommand=function(self)
				self:settext("EX");
			end;
		};	
	end;

end;

return t;