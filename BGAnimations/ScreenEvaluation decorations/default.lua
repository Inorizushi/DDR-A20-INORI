local t = Def.ActorFrame{
    StandardDecorationFromFileOptional("Header","Header");
    StandardDecorationFromFileOptional("Footer","Footer");
}

for _,pn in pairs(GAMESTATE:GetEnabledPlayers()) do
    t[#t+1] = Def.ActorFrame{
        InitCommand=function(s) s:xy(pn==PLAYER_1 and SCREEN_LEFT+60 or SCREEN_RIGHT-80,_screen.cy-268) end,
        OffCommand=function(s) s:linear(0.15):addx(pn==PLAYER_1 and -300 or 300) end,
        Def.Sprite{Texture=ddrgame.."NameBacker",};
        Def.BitmapText{
            Font="_dispatrox 32px",
            InitCommand=function(s)
                s:settext(string.upper(PROFILEMAN:GetPlayerName(pn))):diffuse(color("#feec0a")):xy(pn==PLAYER_1 and 20 or -20,0)
                :zoom(0.8):maxwidth(200)
            end,
        };
        loadfile(THEME:GetPathB("ScreenEvaluation","decorations/EXSum/default.lua"))(pn)..{
            Condition=ddrgame=="gold_",
        };
    };
    t[#t+1] = Def.ActorFrame{
        InitCommand=function(s) s:xy(pn==PLAYER_1 and _screen.cx-310 or _screen.cx+200,_screen.cy-60) end,
        OffCommand=function(s) s:sleep(0.2):linear(0.2):diffusealpha(0) end,
        Def.Sprite{
            Texture="Score_Label",
            InitCommand=function(s) s:xy(-124,-36) end,
        };
        Def.RollingNumbers{
            File="ScreenEvaluation ScoreNumber",
            InitCommand=function(s)
                s:x(0):playcommand("Set")
            end,
            OffCommand=function(s) s:sleep(0.067):zoom(0) end,
            SetCommand=function(s)
                local score = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetScore();
			    s:Load("RollingNumbersEvaluation"):targetnumber(score);
            end,
        };
    };
    t[#t+1] = Def.ActorFrame{
        loadfile(THEME:GetPathB("ScreenEvaluation","decorations/grade"))(pn)..{
            OffCommand=function(s) s:sleep(0.2):linear(0.2):diffusealpha(0) end,
        };
    }
    t[#t+1] = Def.ActorFrame{
        Name="StepsDisplay",
        InitCommand=function(s) s:xy(pn==PLAYER_1 and _screen.cx-228 or _screen.cx+180,_screen.cy-299) end,
        OffCommand=function(s) s:linear(0.25):diffusealpha(0) end,
        Def.BitmapText{
            Font="_itc avant garde std bk 20px",
            InitCommand=function(self)
                self:shadowlength(1)
                local style = GAMESTATE:GetCurrentStyle()
                if style:GetStyleType() == "StyleType_OnePlayerTwoSides" then
                    self:settext("DOUBLE");
                    self:diffuse(color("#f700d7"));
                elseif style:GetStyleType() == "StyleType_OnePlayerOneSide" then
                    self:settext("SINGLE");
                    self:diffuse(color("#01b4ff"));
                elseif style:GetStyleType() == "StyleType_TwoPlayersTwoSides" then
                    self:settext("VERSUS");
                    self:diffuse(color("#f78c03"));
                end;
            end,
        };
        Def.BitmapText{
            Font="_itc avant garde std bk 20px",
            InitCommand=function(self)
                self:y(25):shadowlength(1)
                local diffname = GAMESTATE:GetCurrentSteps(pn):GetDifficulty();
				self:settext(THEME:GetString("CustomDifficulty",ToEnumShortString(diffname)));
				self:diffuse(GameColor.Difficulty[diffname])
            end,
        };
        Def.BitmapText{
            Font="_itc avant garde std bk 20px",
            InitCommand=function(self)
                self:y(55):shadowlength(1):zoom(1.7):diffuse(Color.White)
                local meter = GAMESTATE:GetCurrentSteps(pn):GetMeter();
				self:settext(meter);
            end,
        };
    }
end

-- If single player
if #GAMESTATE:GetEnabledPlayers() == 1 then
	--P1 Frame
	t[#t+1] = LoadActor("frame", GAMESTATE:GetMasterPlayerNumber(),PLAYER_1,(GAMESTATE:GetMasterPlayerNumber() ~= PLAYER_1))..{
		InitCommand=cmd(xy,SCREEN_CENTER_X-246,_screen.cy+128);
	};
	--P2 Frame
	t[#t+1] = LoadActor("frame", GAMESTATE:GetMasterPlayerNumber(),PLAYER_2,(GAMESTATE:GetMasterPlayerNumber() ~= PLAYER_2))..{
		InitCommand=cmd(xy,SCREEN_CENTER_X+246,_screen.cy+128);
	};
else --If multiplayer
	--P1 Frame
	t[#t+1] = LoadActor("frame", PLAYER_1,PLAYER_1,false)..{
		InitCommand=cmd(xy,SCREEN_CENTER_X-246,_screen.cy+128);
	};
	--P2 Frame
	t[#t+1] = LoadActor("frame", PLAYER_2,PLAYER_2,false)..{
		InitCommand=cmd(xy,SCREEN_CENTER_X+246,_screen.cy+128);
	};

end;

return Def.ActorFrame{
    LoadActor( THEME:GetPathS("ScreenEvaluation", "music") ) .. {
		OnCommand=cmd(play);
	};
    LoadActor("canvas")..{
        InitCommand=function(s) s:FullScreen():diffusealpha(0) end,
    };
    t;
    Def.ActorFrame{
        Name="Jacket";
        InitCommand=function(s) s:xy(_screen.cx,_screen.cy-198) end,
        OffCommand=function(s) s:linear(0.2):zoomy(0) end,
        Def.Sprite{
            OnCommand=function(s)
                local course = GAMESTATE:GetCurrentCourse();
                local song = GAMESTATE:GetCurrentSong();
                if song then
                    s:_LoadSCJacket(song)
                elseif course then
                    s:_LoadSCJacket(course)
                end
                s:setsize(215,215)
            end     
        };
    };
    Def.ActorFrame{
        Name="songinfo",
        InitCommand=function(s) s:xy(_screen.cx,_screen.cy-60) end,
        OffCommand=function(s) s:linear(0.2):zoomy(0) end,
        Def.Sprite{Texture="Song Info",};
        Def.BitmapText{
            Font="_arial black 28px",
            InitCommand=function(s)
                s:maxwidth(350):zoom(0.8)
                local song = GAMESTATE:GetCurrentSong()
                local course = GAMESTATE:GetCurrentCourse()
                if song then
                    s:settext(song:GetDisplayFullTitle()):y(-10)
                else
                    s:settext(course:GetDisplayTitle())
                end
            end,
        };
        Def.BitmapText{
            Font="_arial black 28px",
            InitCommand=function(s)
                s:maxwidth(350):y(15):zoom(0.7)
                local song = GAMESTATE:GetCurrentSong()
                if song then
                    s:settext(song:GetDisplayArtist())
                else
                    s:settext("")
                end
            end,
        };
    };
}