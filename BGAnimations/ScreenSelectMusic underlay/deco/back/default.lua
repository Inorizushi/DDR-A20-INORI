local diffbacker = LoadActor(ddrgame.."00di_x_dufficulty_wnidow_base");
local radarbacker = LoadActor(ddrgame.."00di_grooverader");
local up_module_up_line = LoadActor(ddrgame.."up_module_up_line.png");
local up_module_up_line_bold = LoadActor(ddrgame.."up_module_up_line_bold.png");
local up_module_up_line_deco1 = LoadActor(ddrgame.."up_module_up_line_deco1.png");
local rival_window_square = LoadActor(ddrgame.."00di_grop_rival_window_square");

return Def.ActorFrame{
  InitCommand=function(s) s:diffusealpha(0.5) end,
  Def.ActorFrame{
    Name="Fancy Background Things";
    Def.ActorFrame{
      InitCommand=function(s) s:y(SCREEN_TOP-28) end,
      up_module_up_line..{
        InitCommand=function(s) s:halign(1):x(_screen.cx) end,
      };
      up_module_up_line..{
        InitCommand=function(s) s:halign(1):x(_screen.cx):zoomx(-1) end,
      };
    };
    Def.ActorFrame{
      InitCommand=function(s) s:y(SCREEN_TOP+2) end,
      up_module_up_line_deco1..{
        InitCommand=function(s) s:x(_screen.cx-460) end,
      };
      up_module_up_line_deco1..{
        InitCommand=function(s) s:x(_screen.cx+460):zoomx(-1) end,
      };
    };
    Def.ActorFrame{
      InitCommand=function(s) s:y(SCREEN_TOP+72) end,
      up_module_up_line_bold..{
        InitCommand=function(s) s:halign(1):x(_screen.cx) end,
      };
      up_module_up_line_bold..{
        InitCommand=function(s) s:halign(1):x(_screen.cx):zoomx(-1) end,
      };
    };
  };
  Def.ActorFrame{
    Name="PanelBackers";
    Def.ActorFrame{
      InitCommand=function(s) s:y(_screen.cy-142) end,
      diffbacker..{
        InitCommand=function(s) s:halign(0):x(SCREEN_LEFT-9) end,
      };
      diffbacker..{
        InitCommand=function(s) s:halign(0):x(SCREEN_RIGHT+9):zoomx(-1) end,
      };
    };
    Def.ActorFrame{
      InitCommand=function(s) s:y(SCREEN_BOTTOM-14) end,
      rival_window_square..{
        InitCommand=function(s) s:align(0,0.5):x(SCREEN_LEFT) end,
      };
      rival_window_square..{
        InitCommand=function(s) s:align(0,0.5):x(SCREEN_RIGHT):zoomx(-1) end,
      };
    };
    Def.ActorFrame{
      InitCommand=function(s) s:y(SCREEN_BOTTOM+4) end,
      radarbacker..{
        InitCommand=function(s) s:align(0,1):x(SCREEN_LEFT-4) end,
      };
      radarbacker..{
        InitCommand=function(s) s:align(0,1):x(SCREEN_RIGHT+4):zoomx(-1) end,
      };
    };
  };
};
