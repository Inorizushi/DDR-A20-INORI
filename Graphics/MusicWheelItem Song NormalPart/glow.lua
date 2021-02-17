local args = {...};
local pn = args[1];

return Def.ActorFrame{
    Def.Sprite{
        SetCommand=function(s,p)
            local ClearedRank = 0;
            local FullComboRank = 0;
            local song = p.Song
            local st = GAMESTATE:GetCurrentStyle():GetStepsType()
            
            if song then
                local steps = GAMESTATE:GetCurrentSteps(pn)
                if steps then
                    local sDiff = steps:GetDifficulty()
                    local diff = song:GetOneSteps(st,sDiff)
                    local diffname = GAMESTATE:GetCurrentSteps(pn):GetDifficulty()
                local profile;
                if PROFILEMAN:IsPersistentProfile(pn) then
                    profile = PROFILEMAN:GetProfile(pn)
                else
                    profile = PROFILEMAN:GetMachineProfile()
                end
                local scorelist = profile:GetHighScoreList(song,steps)
                local scores = scorelist:GetHighScores()
                local topscore=0;
                if scores[1] then
                    topscore = scores[1]:GetScore()
                end
                local topgrade;
                local temp=#scores;

                if scores[1] then
                    for i=1,temp do
                        topgrade = scores[1]:GetGrade()
                        curgrade = scores[i]:GetGrade()
                        if scores[1]:GetScore()>1 then
                            if scores[1]:GetScore()>=1000000 and topgrade == "Grade_Tier07" then
                                ClearedRank = 7;
                                break;
                            else
                                if ToEnumShortString(curgrade) ~= "Failed" then
                                    local gradenum = tonumber(string.sub(curgrade,-2,-1));
                                    ClearedRank = gradenum;
                                    break
                                else
                                    if i == temp then
                                        ClearedRank = 7;
                                        break
                                    end
                                end
                            end
                        else
                            ClearedRank = 0;
                        end
                    end
                    local scoresHasUsedBatterAndCleared = false;

                    for i=1,temp do
                        if scores[i] then
                            topscore=scores[i]
                            assert(topscore)
                            local misses = topscore:GetTapNoteScore("TapNoteScore_Miss")+topscore:GetTapNoteScore("TapNoteScore_CheckpointMiss")
							+topscore:GetTapNoteScore("TapNoteScore_HitMine")+topscore:GetHoldNoteScore("HoldNoteScore_LetGo")
					        local boos = topscore:GetTapNoteScore("TapNoteScore_W5")
					        local goods = topscore:GetTapNoteScore("TapNoteScore_W4")
					        local greats = topscore:GetTapNoteScore("TapNoteScore_W3")
					        local perfects = topscore:GetTapNoteScore("TapNoteScore_W2")
					        local marvelous = topscore:GetTapNoteScore("TapNoteScore_W1")
					        local hasUsedLittle = string.find(topscore:GetModifiers(),"Little")
                            local hasUsedBattery = string.find(topscore:GetModifiers(),"Lives")

                            if (misses+boos) == 0 and scores[1]:GetScore() > 0 and (marvelous+perfects)>0 and (not hasUsedLittle) and topscore:GetGrade()~="Grade_Failed"  then
                                if (goods+greats+perfects) == 0 then
                                        FullComboRank = 1;
                                        break;
                                elseif goods+greats == 0 then
                                        FullComboRank = 2;
                                        break;
                                elseif (misses+boos+goods) == 0 then
                                        FullComboRank = 4;
                                        if i==1 then
                                            FullComboRank = 3;
                                        end;
                                        break;
                                elseif (misses+boos) == 0 then
                                        FullComboRank = 6;
                                        if i==1 then
                                            FullComboRank = 5;
                                        end;
                                        break;
                                end;
                            else
                                if topscore:GetGrade()~="Grade_Failed" then
                                    if hasUsedBattery  then
                                        scoresHasUsedBatteryAndCleared = true;
                                        FullComboRank = 7;
                                    else 
                                        scoresHasUsedBatteryAndCleared = scoresHasUsedBatteryAndCleared or false;
                                        FullComboRank = 8;
                                    end
                                end
                            end;
                        end
                    end;
                
                    if scoresHasUsedBatteryAndCleared and FullComboRank == 8 then
                        FullComboRank = 7;
                    end  
                end
                local effecttime = 0.09
                if ClearedRank == 0 then --NoPlayed
                    s:LoadBackground(THEME:GetPathG("_shared/grade light/ClearedMark","MFC"));
                    (cmd(diffuseshift;effectcolor1,1,1,1,0;effectcolor2,1,1,1,0;effectperiod,effecttime))(s);
                elseif ClearedRank == 7 then --E
                    s:LoadBackground(THEME:GetPathG("_shared/grade light/ClearedMark","Failed"));
                    (cmd(diffuseshift;effectcolor1,1,1,1,0.65;effectcolor2,1,1,1,1;effectperiod,1.1))(s);
                elseif FullComboRank == 8 then -- 8=NoFCWithLifeBar
                    s:LoadBackground(THEME:GetPathG("_shared/grade light/ClearedMark","NoFCWithLifeBar"));
                    (cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,1;effectperiod,effecttime))(s);
                elseif FullComboRank == 7 then --7=NoFCWithBatteryLives
                    s:LoadBackground(THEME:GetPathG("_shared/grade light/ClearedMark","NoFCWithBatteryLives"));
                    (cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,1;effectperiod,effecttime))(s);
                elseif FullComboRank == 6 then --6=GoodOldFC
                    s:LoadBackground(THEME:GetPathG("_shared/grade light/ClearedMark","GoodOldFC"));
                    (cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.6;effectperiod,effecttime))(s);
                elseif FullComboRank == 5 then -- 5=GoodFC
                   s:LoadBackground(THEME:GetPathG("_shared/grade light/ClearedMark","GoodFC"));
                    (cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.6;effectperiod,effecttime))(s);
                elseif FullComboRank == 4 then -- 4=GreatOldFC
                    s:LoadBackground(THEME:GetPathG("_shared/grade light/ClearedMark","GreatOldFC"));
                    (cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.6;effectperiod,effecttime))(s);
                elseif FullComboRank == 3 then --3=GreatFC
                    s:LoadBackground(THEME:GetPathG("_shared/grade light/ClearedMark","GreatFC"));
                    (cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.6;effectperiod,effecttime))(s);
                elseif FullComboRank == 2 then --2=PFC
                    s:LoadBackground(THEME:GetPathG("_shared/grade light/ClearedMark","PFC"));
                    (cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.70;effectperiod,effecttime))(s);
                elseif FullComboRank == 1 then --1=MFC
                    s:LoadBackground(THEME:GetPathG("_shared/grade light/ClearedMark","MFC"));
                    (cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.70;effectperiod,effecttime))(s);
                end
            else
                s:LoadBackground(THEME:GetPathG("_shared/grade light/ClearedMark","MFC"));
                (cmd(diffuseshift;effectcolor1,1,1,1,0;effectcolor2,1,1,1,0;effectperiod,0.1))(s);
            end;
        end;
        end,
        CurrentStepsChangedP1MessageCommand=cmd(queuecommand,"Set");
        CurrentStepsChangedP2MessageCommand=cmd(queuecommand,"Set");
    }
}