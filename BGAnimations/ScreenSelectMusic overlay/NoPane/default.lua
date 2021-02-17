local pn = ...

return Def.ActorFrame{
    InitCommand=function(s) s:zoom(0.8) end,
    Def.Sprite{
        Texture=ddrgame.."pane.png",
        InitCommand=function(s)
            s:rotationy(pn==PLAYER_1 and 180 or 0)
        end,
    };
    Def.Sprite{
        Texture="pad.png",
        InitCommand=function(s)
            s:xy(pn==PLAYER_1 and -70 or 70,-38):valign(1):diffusealpha(0.75):zoom(0.95)
        end,
    };
    Def.ActorFrame{
        Def.Sprite{
            Texture="TargetOpen",
            InitCommand=function(s) s:zoom(1.2):queuecommand("Show") end,
            ShowCommand=function(s) s:zoom(1.2):linear(0.2):zoom(1):diffusealpha(0.75):queuecommand("Anim") end,
            AnimCommand=function(s) s:sleep(2.45):queuecommand("Stop") end,
            StopCommand=function(s) s:linear(0.2):diffusealpha(0):sleep(6):queuecommand("Show") end,
        };
        Def.Sprite{
            Texture="RecordOpen",
            InitCommand=function(s) s:diffusealpha(0):sleep(3):queuecommand("Show") end,
            ShowCommand=function(s) s:zoom(1.2):linear(0.2):zoom(1):diffusealpha(0.75):queuecommand("Anim") end,
            AnimCommand=function(s) s:sleep(2.45):queuecommand("Stop") end,
            StopCommand=function(s) s:linear(0.2):diffusealpha(0):sleep(6):queuecommand("Show") end,
        };
        Def.Sprite{
            Texture="Close",
            InitCommand=function(s) s:diffusealpha(0):sleep(6):queuecommand("Show") end,
            ShowCommand=function(s) s:zoom(1.2):linear(0.2):zoom(1):diffusealpha(0.75):queuecommand("Anim") end,
            AnimCommand=function(s) s:sleep(2.45):queuecommand("Stop") end,
            StopCommand=function(s) s:linear(0.2):diffusealpha(0):sleep(6):queuecommand("Show") end,
        };
    };
    Def.ActorFrame{
        InitCommand=function(s) s:xy(pn==PLAYER_1 and -70 or 70,-75) end,
        Def.ActorFrame{
            Name="Detail",
            InitCommand=function(s)
                s:queuecommand("Show")
            end,
            ShowCommand=function(s) s:linear(0.2):diffusealpha(1):queuecommand("Anim") end,
            AnimCommand=function(s) s:diffuseramp():effectcolor1(Color.White):effectcolor2(Alpha(Color.White,0.25)):effectperiod(0.35):sleep(2.45):queuecommand("Stop") end,
            StopCommand=function(s) s:stopeffect():linear(0.2):diffusealpha(0):sleep(6):queuecommand("Show") end,
            Def.Sprite{
                Texture="glow",
                InitCommand=function(s) s:x(-18) end,
            };
            Def.Sprite{
                Texture="glow",
                InitCommand=function(s) s:y(-18) end,
            };
        };
        Def.ActorFrame{
            Name="Scores",
            InitCommand=function(s)
                s:diffusealpha(0):sleep(3)
                s:queuecommand("Show")
            end,
            ShowCommand=function(s) s:linear(0.2):diffusealpha(1):queuecommand("Anim") end,
            AnimCommand=function(s) s:diffuseramp():effectcolor1(Color.White):effectcolor2(Alpha(Color.White,0.25)):effectperiod(0.35):sleep(2.45):queuecommand("Stop") end,
            StopCommand=function(s) s:stopeffect():linear(0.2):diffusealpha(0):sleep(6):queuecommand("Show") end,
            Def.Sprite{
                Texture="glow",
                InitCommand=function(s) s:x(-18) end,
            };
            Def.Sprite{
                Texture="glow",
                InitCommand=function(s) s:y(18) end,
            };
        };
        Def.ActorFrame{
            Name="Scores",
            InitCommand=function(s)
                s:diffusealpha(0):sleep(6)
                s:queuecommand("Show")
            end,
            ShowCommand=function(s) s:linear(0.2):diffusealpha(1):queuecommand("Anim") end,
            AnimCommand=function(s) s:diffuseramp():effectcolor1(Color.White):effectcolor2(Alpha(Color.White,0.25)):effectperiod(0.35):sleep(2.45):queuecommand("Stop") end,
            StopCommand=function(s) s:stopeffect():linear(0.2):diffusealpha(0):sleep(6):queuecommand("Show") end,
            Def.Sprite{
                Texture="glow",
                InitCommand=function(s) s:x(18) end,
            };
            Def.Sprite{
                Texture="glow",
                InitCommand=function(s) s:y(18) end,
            };
        };
    };
};