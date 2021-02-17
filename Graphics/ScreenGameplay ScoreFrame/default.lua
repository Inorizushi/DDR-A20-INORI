local yval = SCREEN_BOTTOM-60
local t = Def.ActorFrame{
    CurrentSongChangedMessageCommand=function(s) s:queuecommand("Set") end,
};

t[#t+1] = Def.ActorFrame{
    InitCommand=function(s) s:draworder(99) end,
    Def.ActorFrame{
        Name="TextBanner",
        InitCommand=function(s) s:xy(_screen.cx,yval) end,
        Def.Sprite{
            Texture="dance_song_info0000_base",
        };
        Def.BitmapText{
            Font="_arial black 28px",
            InitCommand=function(s) s:zoom(0.9):maxwidth(376):y(-8) end,
            CurrentSongChangedMessageCommand=function(s)
                local song = GAMESTATE:GetCurrentSong()
                if song then
                    s:settext(song:GetDisplayFullTitle())
                end
            end,
        };
        Def.BitmapText{
            Font="_arial black 28px",
            InitCommand=function(s) s:zoom(0.7):maxwidth(360):y(18) end,
            CurrentSongChangedMessageCommand=function(s)
                local song = GAMESTATE:GetCurrentSong()
                if song then
                    s:settext(song:GetDisplayArtist())
                end
            end,
        }
    };
};

for _,pn in pairs(GAMESTATE:GetEnabledPlayers()) do
    t[#t+1] = Def.ActorFrame{
        InitCommand=function(s) s:x(pn==PLAYER_1 and SCREEN_LEFT+192 or SCREEN_RIGHT):draworder(99) end,
        Def.ActorFrame{
            InitCommand=function(s)
                s:y(GAMESTATE:PlayerIsUsingModifier(pn,'reverse') and SCREEN_TOP+72 or (yval-30)):zoomx(1.02)
            end,
            Def.Sprite{
                Texture=ddrgame.."dance_score0000_level_base_none",
                InitCommand=function(s) s:x(72)
                    s:rotationx(GAMESTATE:PlayerIsUsingModifier(pn,'reverse') and 180 or 0)
                end,
            };
            Def.ActorFrame{
                InitCommand=function(s) s:x(-86) end,
                Def.Sprite{
                    Texture=ddrgame.."dance_score0000_frame_difficulty",
                    InitCommand=function(s) 
                        s:rotationx(GAMESTATE:PlayerIsUsingModifier(pn,'reverse') and 180 or 0)
                    end,
                };
                Def.BitmapText{
                    Font="_commador extended 32px",
                    InitCommand=function(s) s:halign(1):zoomy(0.53):zoomx(0.69):playcommand("Set") end,
                    SetCommand=function(s)
                        local diff = GAMESTATE:GetCurrentSteps(pn):GetDifficulty()
                        local sDifficulty = ToEnumShortString( diff );
                        if diff then
                            s:settext(THEME:GetString("CustomDifficulty",sDifficulty))
                            :diffuse(CustomDifficultyToColor(diff))
                            if sDifficulty == 'Challenge' then
                                s:maxwidth(126)
                            end
                            local meter = tonumber(GAMESTATE:GetCurrentSteps(pn):GetMeter())
                            local sDiffWidth = 0;
		                    local sMeterWidth = 0;

		                    if meter <= 0 then
		                    	sMeterWidth = 18;
		                    elseif meter <= 9 then
		                    	sMeterWidth = 18 ;
		                    elseif meter <= 99 then
		                    	sMeterWidth = 0;
		                    else
		                    	sMeterWidth = -18;
                            end;
                            if sDifficulty == 'Beginner' then
                                sDiffWidth = 85;
                            elseif sDifficulty == 'Easy' then
                                sDiffWidth = 52;
                            elseif sDifficulty == 'Medium' then
                                sDiffWidth = 84;
                            elseif sDifficulty == 'Hard' then
                                sDiffWidth = 62;
                            elseif sDifficulty == 'Challenge' then
                                sDiffWidth = 86;
                            else
                                sDiffWidth = 40;
                            end;
                            local totalWidth = sDiffWidth+sMeterWidth;
                            local additionXPos = totalWidth/2-42;
                            s:xy(32+additionXPos,2)
                        end
                    end
                };
                Def.BitmapText{
                    Font="_squareslab711 lt bt Bold 24px",
                    InitCommand=function(s) s:halign(0):zoomx(1.47):zoomy(0.92) end,
                    SetCommand=function(s)
                        local meter = GAMESTATE:GetCurrentSteps(pn):GetMeter();
                        local diff = GAMESTATE:GetCurrentSteps(pn):GetDifficulty()
                        if GAMESTATE:IsCourseMode() then
                            diff = GAMESTATE:GetCurrentTrail(pn):GetTrailEntry(GAMESTATE:GetCourseSongIndex()):GetSteps():GetDifficulty();
                            meter = GAMESTATE:GetCurrentTrail(pn):GetTrailEntry(GAMESTATE:GetCourseSongIndex()):GetSteps():GetMeter();
                        end
                        local sDifficulty = ToEnumShortString(diff)

                        local sDiffWidth = 0;
				        local sMeterWidth = 0;
	
				        if meter <= 0 then
				        	sMeterWidth = 18;
				        elseif meter <= 9 then
				        	sMeterWidth = 18 ;
				        elseif meter <= 99 then
				        	sMeterWidth = 0;
				        else
				        	sMeterWidth = -18;
				        end;

				        if sDifficulty == 'Beginner' then
				        	sDiffWidth = 85;
				        elseif sDifficulty == 'Easy' then
				        	sDiffWidth = 52;
				        elseif sDifficulty == 'Medium' then
				        	sDiffWidth = 84;
				        elseif sDifficulty == 'Hard' then
				        	sDiffWidth = 62;
				        elseif sDifficulty == 'Challenge' then
				        	sDiffWidth = 82;
				        else
				        	sDiffWidth = 40;
				        end;

				        local totalWidth = sDiffWidth+sMeterWidth;
                        local additionXPos = totalWidth/2-42;
                        
                        s:settext(meter):xy(34+additionXPos,2)
                    end,
                };
            };
            
        };
        Def.ActorFrame{
            InitCommand=function(s) s:y(yval+2) end,
            Def.Sprite{
                Texture=ddrgame.."dance_score0000_frame_score",
            };
        };
    };
end

return t;