local t = Def.ActorFrame{}

local xPosPlayer = {
    P1 = SCREEN_LEFT+280,
    P2 = SCREEN_RIGHT-280
}

for _,pn in pairs(GAMESTATE:GetEnabledPlayers()) do
    t[#t+1] = Def.ActorFrame{
        InitCommand=function(s) s:xy(pn==PLAYER_1 and SCREEN_LEFT+210 or SCREEN_RIGHT-210,_screen.cy+200) end,
        OnCommand=function(self)
            self:addx(pn==PLAYER_1 and -800 or 800):sleep(1.2):decelerate(0.2):addx(pn==PLAYER_1 and 800 or -800) 
        end;
        Def.ActorFrame{
            InitCommand=function(s) s:y(-44) end,
            Def.Sprite{
                Texture=ddrgame.."cosh_choice_best_score",
            };
            Def.BitmapText{
                Name="ScoreNumber";
                Font="_helveticaneuelt pro 65 md 24px",
                InitCommand=function(s) s:xy(50,-4):queuecommand("Set")
                    :halign(1):diffuse(color("1,1,0.38,1"))
                    :zoomy(0.9):zoomx(1.85):maxwidth(240)
                end,
                SetCommand=function(s)
                    s:settext("")

                    local steps = GAMESTATE:GetCurrentSteps(pn);
                    local song=GAMESTATE:GetCurrentSong()
                    if song then
                        local st=GAMESTATE:GetCurrentStyle():GetStepsType();

                        if PROFILEMAN:IsPersistentProfile(pn) then
                            profile = PROFILEMAN:GetProfile(pn)
                        else
                            profile = PROFILEMAN:GetMachineProfile()
                        end;

                        scorelist = profile:GetHighScoreList(song,steps)
                        local scores = scorelist:GetHighScores()
                        local topscore = 0

                        if scores[1] then
                            topscore = scores[1]:GetScore()
                        end;

                        if topscore ~= 0 then
                            s:settext(topscore)
                        else
                            s:settext("0")
                        end;
                    end;
                end,
            };
            Def.BitmapText{
                Font="_helveticaneuelt pro 65 md 24px",
                InitCommand=function(self)
                    self:xy(-180,24):halign(0)
                    self:playcommand("Set")
                    self:zoomx(1.4):zoomy(0.8);
                end;
                SetCommand=function(s)
                    s:maxwidth(200);
                    if PROFILEMAN:IsPersistentProfile(pn) then
                        s:settext(PROFILEMAN:GetProfile(pn):GetDisplayName())
                    else
                        s:settext(pn=='PlayerNumber_P2' and "PLAYER 2" or "PLAYER 1")
                    end;
                end;
            };
            Def.ActorFrame{
                InitCommand=function(s) s:xy(pn=='PlayerNumber_P2' and -220 or 220,-32) end,
                LoadActor(THEME:GetPathG("Player","Badge FullCombo"))..{
                  InitCommand=function(s) s:xy(6,6):zoom(0.75) end,
                  BeginCommand=cmd(playcommand,"Set");
                  SetCommand=function(self)
                    local st=GAMESTATE:GetCurrentStyle():GetStepsType();
                    local song=GAMESTATE:GetCurrentSong();
                    if song then
                      local steps = GAMESTATE:GetCurrentSteps(pn);
              
                      if PROFILEMAN:IsPersistentProfile(pn) then
                        profile = PROFILEMAN:GetProfile(pn);
                      else
                        profile = PROFILEMAN:GetMachineProfile();
                      end;
                      local scorelist = profile:GetHighScoreList(song,steps);
                      assert(scorelist);
                      local scores = scorelist:GetHighScores();
                      assert(scores);
                      local topscore;
                      if scores[1] then
                        topscore = scores[1];
                        assert(topscore);
                        local misses = topscore:GetTapNoteScore("TapNoteScore_Miss")+topscore:GetTapNoteScore("TapNoteScore_CheckpointMiss")
                        local boos = topscore:GetTapNoteScore("TapNoteScore_W5")
                        local goods = topscore:GetTapNoteScore("TapNoteScore_W4")
                        local greats = topscore:GetTapNoteScore("TapNoteScore_W3")
                        local perfects = topscore:GetTapNoteScore("TapNoteScore_W2")
                        local marvelous = topscore:GetTapNoteScore("TapNoteScore_W1")
                        if (misses+boos) == 0 and scores[1]:GetScore() > 0 and (marvelous+perfects)>0 then
                          if (greats+perfects) == 0 then
                            self:diffuse(GameColor.Judgment["JudgmentLine_W1"]);
                            self:glowblink();
                            self:effectperiod(0.20);
                          elseif greats == 0 then
                            self:diffuse(GameColor.Judgment["JudgmentLine_W2"]);
                            self:glowshift();
                          elseif (misses+boos+goods) == 0 then
                            self:diffuse(GameColor.Judgment["JudgmentLine_W3"]);
                            self:stopeffect();
                          elseif (misses+boos) == 0 then
                            self:diffuse(GameColor.Judgment["JudgmentLine_W4"]);
                            self:stopeffect();
                          end;
                          self:diffusealpha(1);
                        else
                          self:diffusealpha(0);
                        end;
                      else
                        self:diffusealpha(0);
                      end;
                    else
                      self:diffusealpha(0);
                    end;
                  end;
                };
                Def.Quad{
                  InitCommand=function(self)
                    self:zoom(0.12)
                  end;
                  BeginCommand=cmd(playcommand,"Set");
                  SetCommand=function(self)
                    local song = GAMESTATE:GetCurrentSong();
                    local steps = GAMESTATE:GetCurrentSteps(pn);
                    if song then
                      local st = GAMESTATE:GetCurrentStyle():GetStepsType()
                      local diff = steps:GetDifficulty();
              
                      if PROFILEMAN:IsPersistentProfile(pn) then
                        -- player profile
                        profile = PROFILEMAN:GetProfile(pn);
                      else
                        -- machine profile
                        profile = PROFILEMAN:GetMachineProfile();
                      end;
              
                      scorelist = profile:GetHighScoreList(song,steps);
                      assert(scorelist);
              
                      local scores = scorelist:GetHighScores();
                      assert(scores);
              
                      local topscore=0;
                      if scores[1] then
                        topscore = SN2Scoring.GetSN2ScoreFromHighScore(steps, scores[1])
                        topscore2 = scores[1];
                      end;
                      assert(topscore);
                      if scores[1] then
                        local misses = topscore2:GetTapNoteScore("TapNoteScore_Miss")+topscore2:GetTapNoteScore("TapNoteScore_CheckpointMiss")
                        local boos = topscore2:GetTapNoteScore("TapNoteScore_W5")
                        local goods = topscore2:GetTapNoteScore("TapNoteScore_W4")
                        local greats = topscore2:GetTapNoteScore("TapNoteScore_W3")
                        local perfects = topscore2:GetTapNoteScore("TapNoteScore_W2")
                        local marvelous = topscore2:GetTapNoteScore("TapNoteScore_W1")
                        if (misses+boos) == 0 and topscore > 0 and (marvelous+perfects)>0 then
                          self:addx(-14)
                        end;
                      end;
                      if scores[1] then
                        local topgrade = scores[1]:GetGrade();
                        local tier = SN2Grading.ScoreToGrade(topscore, diff)
                        assert(topgrade);
                        if scores[1]:GetScore()>1  then
                          if topgrade == 'Grade_Failed' then
                            self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/GradeDisplayEval Failed"));
                          else
                            self:Load(THEME:GetPathB("ScreenEvaluation decorations/grade/GradeDisplayEval",ToEnumShortString(tier)));
                          end;
                          self:diffusealpha(1);
                        else
                          self:diffusealpha(0);
                        end;
                      else
                        self:diffusealpha(0);
                      end;
                    else
                      self:diffusealpha(0);
                    end;
                  end;
                };
              }
        };
        Def.ActorFrame{
            InitCommand=function(s) s:y(44) end,
            Def.Sprite{
                Texture=ddrgame.."cosh_choice_target_score",
            };
        };
    };
end

return Def.ActorFrame{
    t;
}