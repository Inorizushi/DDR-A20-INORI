local yval = SCREEN_BOTTOM-60
local t = Def.ActorFrame{};

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
        InitCommand=function(s) s:x(pn==PLAYER_1 and SCREEN_LEFT or SCREEN_RIGHT):draworder(99) end,
        Def.ActorFrame{
            InitCommand=function(s) s:y(yval+2) end,
            Def.Sprite{
                Texture=ddrgame.."dance_score0000_frame_score",
                InitCommand=function(s) s:halign(pn==PLAYER_1 and 0 or 1) end,
            };
        };
    };
end

return t;