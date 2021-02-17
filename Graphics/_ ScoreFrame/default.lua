local t = Def.ActorFrame{};

--P1 ScoreFrame
if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	t[#t+1] = LoadActor("normal")..{
		InitCommand=cmd(x,SCREEN_LEFT+198;y,SCREEN_CENTER_Y+295;zoom,1.5);
	}
	t[#t+1] = LoadActor("diffandname_back")..{
		InitCommand=cmd(x,SCREEN_LEFT+198;y,SCREEN_CENTER_Y+295;zoom,1.5);
		OnCommand=function(self)
			if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'reverse') then
				self:addx(-14);
				self:y(SCREEN_CENTER_Y-305.0);
				self:rotationx(180);
			end;
		end;
	}
	

--Meter BG in ScreenGamplay decorations
end

--GetCourseSongIndex()

--P2 ScoreFrame
if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	t[#t+1] = LoadActor("normal")..{
		InitCommand=cmd(x,SCREEN_RIGHT-201;y,SCREEN_CENTER_Y+295;rotationy,180;zoom,1.5;);
	}
	t[#t+1] = LoadActor("diffandname_back")..{
		InitCommand=cmd(x,SCREEN_RIGHT-163;y,SCREEN_CENTER_Y+295;zoom,1.5;);
		OnCommand=function(self)
			if GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'reverse') then
				self:addx(14);
				self:y(SCREEN_CENTER_Y-305.0);
				self:rotationx(180);
			end;
		end;
	}

end

return t