local pn = ...

local lang = "en";
if THEME:GetCurLanguage() == "ja" then
	lang = "jp";
end;

local function RivalScore(pn,rival)
    local t=Def.ActorFrame {
        CurrentSongChangedMessageCommand=function(s) s:finishtweening():queuecommand("Set") end,
        ["CurrentSteps" .. ToEnumShortString(pn) .. "ChangedMessageCommand"]=function(s) s:finishtweening():queuecommand("Set") end,
        Def.BitmapText{
            Font="_geo 9 20px",
            InitCommand=function(self)
                self:xy(-50,8);
                self:halign(0)
                self:diffuse(Color("Black"));
                if (rival ~= 1) then
                    self:diffuse(Color("White"));
                end;
            end;
            SetCommand=function(self)
                local SongOrCourse, StepsOrTrail;
                if GAMESTATE:IsCourseMode() then
                    SongOrCourse = GAMESTATE:GetCurrentCourse();
                    StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
                else
                    SongOrCourse = GAMESTATE:GetCurrentSong();
                    StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
                end;
    
                local profile, scorelist;
                if SongOrCourse and StepsOrTrail then
                    local st = StepsOrTrail:GetStepsType();
                    local diff = StepsOrTrail:GetDifficulty();
                    local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
                    local profile;
                    if rival == 1 then
                        profile = PROFILEMAN:GetProfile(pn)
                    else
                        profile = PROFILEMAN:GetMachineProfile();
                    end
    
                    scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
                    assert(scorelist)
                    local scores = scorelist:GetHighScores();
                    
                    if scores[rival] then
                        if scores[rival]:GetName() ~= nil then
                            if scores[rival]:GetName() == "" then
                                self:settext("NO NAME")
                            else
                                self:settext(scores[rival]:GetName())
                            end
                        else
                            self:settext("STEP")
                        end
                    else
                        self:settext("")
                    end;
                end;
            end;
        };
        Def.RollingNumbers {
            File = THEME:GetPathF("_geo 95","20px");
            InitCommand=function(self)
                self:x(140);
                self:halign(1)
                self:diffuse(Color("Black"));
                if (rival ~= 1) then
                    self:diffuse(Color("White"));
                end;
            end;
            BeginCommand=cmd(playcommand,"Set");
            SetCommand=function(self)
                local SongOrCourse, StepsOrTrail;
                if GAMESTATE:IsCourseMode() then
                    SongOrCourse = GAMESTATE:GetCurrentCourse();
                    StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
                else
                    SongOrCourse = GAMESTATE:GetCurrentSong();
                    StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
                end;
    
                local profile, scorelist;
                local topscore=0;
                if SongOrCourse and StepsOrTrail then
                    local st = StepsOrTrail:GetStepsType();
                    local diff = StepsOrTrail:GetDifficulty();
                    local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
                    local profile;
                    if rival == 1 then
                        profile = PROFILEMAN:GetProfile(pn)
                    else
                        profile = PROFILEMAN:GetMachineProfile();
                    end
    
                    scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
                    assert(scorelist)
                    local scores = scorelist:GetHighScores();
                    
                    if scores[rival] then
                        if scores[rival]:GetScore() > 1 then
                            topscore = scores[rival]:GetScore();
                            self:visible(true)
                        else
                            topscore = 0
                            self:visible(false)
                        end
                    else
                        topscore = 0
                        self:visible(false)
                    end;
                    assert(topscore);
                    
                end;
                self:Load("RollingNumbersSongData");
                self:targetnumber(topscore);
            end;
        };
    };
    return t;
end

    return Def.ActorFrame{
        Def.Sprite{
            Texture="ScoreBack01",
            InitCommand=function(s) s:valign(0):zoomx(pn==PLAYER_1 and 0.6 or -0.6):zoomy(0.6):xy(pn==PLAYER_1 and-8 or 8,6) end,
        };
        Def.Sprite{
            Texture=lang.."_ScoreFrame",
            InitCommand=function(s) s:valign(0):zoom(0.64) end,
        };
        Def.Sprite{
            Texture="ScoreBack02",
            InitCommand=function(s) s:valign(0):zoom(0.64):xy(pn==PLAYER_1 and 120 or -120,30) end,
        };
        RivalScore(pn,1)..{
            InitCommand=function(s) s:y(64) end,
        };
        RivalScore(pn,2)..{
            InitCommand=function(s) s:y(90) end,
        };
        RivalScore(pn,3)..{
            InitCommand=function(s) s:y(114) end,
        };
        RivalScore(pn,4)..{
            InitCommand=function(s) s:y(140) end,
        };
        RivalScore(pn,5)..{
            InitCommand=function(s) s:y(164) end,
        };
        RivalScore(pn,6)..{
            InitCommand=function(s) s:y(190) end,
        };
        RivalScore(pn,7)..{
            InitCommand=function(s) s:y(214) end,
        };
    }