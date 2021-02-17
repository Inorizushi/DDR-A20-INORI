return Def.ActorFrame{
  LoadActor("base")..{
    InitCommand=function(s) s:FullScreen():diffusealpha(0) end,
  };
  LoadActor("deco/back/default.lua")..{
    InitCommand=function(s) s:diffusealpha(0) end,
    OnCommand=function(s) s:diffusealpha(0):sleep(0.4):linear(0.05):diffusealpha(0.4):linear(0.1):diffusealpha(0.25):linear(0.1):diffusealpha(0.5) end,
  }
};
