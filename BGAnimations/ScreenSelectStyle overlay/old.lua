local lang = "en";
if THEME:GetCurLanguage() == "ja" then
	lang = "jp";
end;

local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
  InitCommand=cmd(draworder,99);
  Name="Frames";
  LoadActor(ddrgame.."Frame")..{
    Name="P1 Frame";
    InitCommand=cmd(x,SCREEN_LEFT;y,SCREEN_BOTTOM-80;halign,1;zoomx,-1);
    OnCommand=function(self)
      if GAMESTATE:GetNumPlayersEnabled() == 2 then
        self:visible(false)
      else
        self:visible(true)
        self:diffusealpha(0):zoomy(0):linear(0.3):zoomy(1):diffusealpha(1)
      end;
    end;
    OffCommand=cmd(smooth,0.2;diffusealpha,0;);
    PlayerJoinedMessageCommand=function(self,param)
      if param.Player == PLAYER_1 then
        self:queuecommand("Off")
      end;
      if param.Player == PLAYER_2 then
        self:queuecommand("Off")
      end;
    end;
  };
  LoadActor(ddrgame.."Frame")..{
    Name="P2 Frame";
    InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_BOTTOM-80;halign,1);
    OnCommand=function(self)
      if GAMESTATE:GetNumPlayersEnabled() == 2 then
        self:visible(false)
      else
        self:diffusealpha(0):zoomy(0):linear(0.3):zoomy(1):diffusealpha(1)
      end;
    end;
    OffCommand=cmd(smooth,0.2;diffusealpha,0;);
    PlayerJoinedMessageCommand=function(self,param)
      if param.Player == PLAYER_1 then
        self:queuecommand("Off")
      end;
      if param.Player == PLAYER_2 then
        self:queuecommand("Off")
      end;
    end;
  };
};

t[#t+1] = Def.ActorFrame {
  InitCommand=cmd(draworder,99);
  Name="Badges";
  LoadActor(THEME:GetPathG("","_shared/P1 BADGE"))..{
    Name="P1 Badge";
    InitCommand=cmd(visible,false;x,SCREEN_LEFT+104;y,SCREEN_BOTTOM-102);
    OnCommand=function(self)
      if GAMESTATE:GetNumPlayersEnabled() == 2 then
        self:visible(false)
      else
        self:visible(true)
        self:diffusealpha(0):rotationz(45):sleep(0.3):linear(0.3):rotationz(0):diffusealpha(1)
      end;
    end;
    OffCommand=cmd(smooth,0.2;diffusealpha,0;);
    PlayerJoinedMessageCommand=function(self)
      self:queuecommand("Off")
    end;
  };
  LoadActor(THEME:GetPathG("","_shared/P2 BADGE"))..{
    Name="P2 Badge";
    InitCommand=cmd(visible,false;x,SCREEN_RIGHT-104;y,SCREEN_BOTTOM-102);
    OnCommand=function(self)
      if GAMESTATE:GetNumPlayersEnabled() == 2 then
        self:visible(false)
      else
        self:visible(true)
        self:diffusealpha(0):rotationz(45):sleep(0.3):linear(0.3):rotationz(0):diffusealpha(1)
      end;
    end;
    OffCommand=cmd(smooth,0.2;diffusealpha,0;);
    PlayerJoinedMessageCommand=function(self)
      self:queuecommand("Off")
    end;
  };
};

t[#t+1] = Def.ActorFrame{
  InitCommand=cmd(draworder,99);
  Def.Sprite{
    Name="P1 Messages";
    InitCommand=cmd(visible,false;x,SCREEN_LEFT+274;y,SCREEN_BOTTOM-82);
    OnCommand=function(self)
      if GAMESTATE:GetNumPlayersEnabled() == 2 then
        self:visible(false)
      else
        self:queuecommand("Set")
      end;
    end;
    SetCommand=function(self)
      local GetP1 = GAMESTATE:IsPlayerEnabled(PLAYER_1);
      if GetP1 == true and GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 then
        self:visible(true)
        self:Load(THEME:GetPathB("","ScreenSelectStyle overlay/"..lang.."_P1here"));
      elseif GetP1 == false and GAMESTATE:PlayersCanJoin() and GAMESTATE:GetMasterPlayerNumber() == PLAYER_2 then
        self:visible(true)
        self:Load(THEME:GetPathB("","ScreenSelectStyle overlay/"..lang.."_P1CanJoin"));
      elseif GetP1 == false and GAMESTATE:GetMasterPlayerNumber() == PLAYER_2  then
        if GAMESTATE:GetCoins() ~= GAMESTATE:GetCoinsNeededToJoin() then
          self:visible(true)
          self:Load(THEME:GetPathB("","ScreenSelectStyle overlay/"..lang.."_credit"));
        end;
      elseif GAMESTATE:GetNumPlayersEnabled() == 2 then
        self:visible(false)
      end;
      self:diffusealpha(0):zoomy(0):sleep(0.5):linear(0.3):zoomy(1):diffusealpha(1)
    end;
    OffCommand=cmd(smooth,0.2;diffusealpha,0);
    CoinsChangedMessageCommand=function(self)
      self:queuecommand("Set");
    end;
    PlayerJoinedMessageCommand=function(self)
      self:queuecommand("Off")
    end;
  };
  Def.Sprite{
    Name="P2 Messages";
    InitCommand=cmd(visible,false;x,SCREEN_RIGHT-284;y,SCREEN_BOTTOM-82);
    OnCommand=function(self)
      if GAMESTATE:GetNumPlayersEnabled() == 2 then
        self:visible(false)
      else
        self:queuecommand("Set")
      end;
    end;
    SetCommand=function(self)
      local GetP2 = GAMESTATE:IsPlayerEnabled(PLAYER_2);
      if GetP2 == true and GAMESTATE:GetMasterPlayerNumber() == PLAYER_2 then
        self:visible(true)
        self:Load(THEME:GetPathB("","ScreenSelectStyle overlay/"..lang.."_P2here"));
      elseif GetP2 == false and GAMESTATE:GetMasterPlayerNumber() == PLAYER_1  then
        if GAMESTATE:GetCoins() ~= GAMESTATE:GetCoinsNeededToJoin() then
          self:visible(true)
          self:Load(THEME:GetPathB("","ScreenSelectStyle overlay/"..lang.."_credit"));
        else
          self:Load(THEME:GetPathB("","ScreenSelectStyle overlay/"..lang.."_P2CanJoin"));
          self:visible(true)
        end;
      elseif GAMESTATE:GetNumPlayersEnabled() == 2 then
        self:visible(false)
      end;
      self:diffusealpha(0):zoomy(0):sleep(0.5):linear(0.3):zoomy(1):diffusealpha(1)
    end;
    OffCommand=cmd(smooth,0.2;diffusealpha,0);
    CoinsChangedMessageCommand=function(self)
      self:queuecommand("Set");
    end;
    PlayerJoinedMessageCommand=function(self)
      self:queuecommand("Off")
    end;
  };
};

t[#t+1] = Def.ActorFrame{
  InitCommand=cmd(draworder,200;xy,SCREEN_CENTER_X,SCREEN_CENTER_Y+194);
  Def.ActorFrame{
    InitCommand=cmd(x,-264;diffusealpha,0);
    OnCommand=cmd(smooth,0.3;diffusealpha,1;);
    OffCommand=cmd(smooth,0.2;addx,50;diffusealpha,0;);
    LoadActor("_selectarrowg") .. {
      MenuLeftP1MessageCommand=cmd(smooth,0.1;addx,-20;smooth,0.1;addx,20;);
      MenuLeftP2MessageCommand=cmd(smooth,0.1;addx,-20;smooth,0.1;addx,20;);
    };
    LoadActor("_selectarrowr") .. {
      OnCommand=cmd(diffusealpha,0;);
      MenuLeftP1MessageCommand=cmd(diffusealpha,1;smooth,0.1;addx,-20;smooth,0.1;addx,20;diffusealpha,0);
      MenuLeftP2MessageCommand=cmd(diffusealpha,1;smooth,0.1;addx,-20;smooth,0.1;addx,20;diffusealpha,0);
    };
  };
  Def.ActorFrame{
    InitCommand=cmd(x,264;zoomx,-0.5;zoomy,0.5;diffusealpha,0);
    OnCommand=cmd(smooth,0.3;zoomx,-1;zoomy,1;diffusealpha,1;);
    OffCommand=cmd(smooth,0.2;addx,50;diffusealpha,0;);
    LoadActor("_selectarrowg") .. {
      MenuRightP1MessageCommand=cmd(smooth,0.1;addx,-20;smooth,0.1;addx,20;);
      MenuRightP2MessageCommand=cmd(smooth,0.1;addx,-20;smooth,0.1;addx,20;);
    };

    LoadActor("_selectarrowr") .. {
      OnCommand=cmd(diffusealpha,0);
      MenuRightP1MessageCommand=cmd(diffusealpha,1;smooth,0.1;addx,-20;smooth,0.1;addx,20;diffusealpha,0);
      MenuRightP2MessageCommand=cmd(diffusealpha,1;smooth,0.1;addx,-20;smooth,0.1;addx,20;diffusealpha,0);
    };
  }
};

t[#t+1] = LoadActor(ddrgame.."StartJoinSSS")..{
  Name = "PressStartP1";
  InitCommand=function(self)
    self:x(SCREEN_LEFT+240):y(SCREEN_CENTER_Y+164)
    self:queuecommand("Set")
    self:zoom(0)
    self:diffusealpha(0)
  end;
  AnimateCommand=cmd(linear,0.25;zoomx,0.95;linear,0.25;zoomx,1;queuecommand,"Animate");
  OffCommand=cmd(stoptweening;linear,0.25;zoomy,0;diffusealpha,0);
  SetCommand=function(self)
    local GetP1 = GAMESTATE:IsPlayerEnabled(PLAYER_1);
    if GetP1 == false then
      self:zoom(0)
    else
      if GAMESTATE:GetCoins() ~= GAMESTATE:GetCoinsNeededToJoin() then
        self:zoom(0)
      else
        self:zoom(0):rotationz(-720):linear(0.35):rotationz(720):diffusealpha(1):zoom(1):playcommand("Animate")
      end;
    end;
  end;
  CoinsChangedMessageCommand=function(self)
    self:queuecommand("Set");
  end;
  PlayerJoinedMessageCommand=function(self,param)
    if param.Player == PLAYER_1 then
      (cmd(linear,0.15;zoomy,0;))(self);
    end;
  end;
};

t[#t+1] = LoadActor(ddrgame.."StartJoinSSS")..{
  Name = "PressStartP2";
  InitCommand=function(self)
    self:x(SCREEN_RIGHT-240):y(SCREEN_CENTER_Y+164)
    self:queuecommand("Set")
    self:zoom(0)
    self:diffusealpha(0)
  end;
  AnimateCommand=cmd(linear,0.25;zoomx,0.95;linear,0.25;zoomx,1;queuecommand,"Animate");
  OffCommand=cmd(stoptweening;linear,0.25;zoomy,0;diffusealpha,0);
  SetCommand=function(self)
    local GetP2 = GAMESTATE:IsPlayerEnabled(PLAYER_2);
    if GetP2 == false then
      self:zoom(0)
    else
      if GAMESTATE:GetCoins() ~= GAMESTATE:GetCoinsNeededToJoin() then
        self:zoom(0)
      else
        self:zoom(0):rotationz(-720):linear(0.35):rotationz(720):diffusealpha(1):zoom(1):playcommand("Animate")
      end;
    end;
  end;
  CoinsChangedMessageCommand=function(self)
    self:queuecommand("Set");
  end;
  PlayerJoinedMessageCommand=function(self,param)
    if param.Player == PLAYER_2 then
      (cmd(linear,0.15;zoomy,0;))(self);
    end;
  end;
};

t[#t+1] = Def.Actor{
  PlayerJoinedMessageCommand=function(self)
    self:queuecommand("Delay1")
  end;
  Delay1Command=function(self)
    self:sleep(2)
    self:queuecommand("SetScreen")
  end;
  SetScreenCommand=function(self)
    SCREENMAN:GetTopScreen():SetNextScreenName("ScreenProfileLoad"):StartTransitioningScreen("SM_GoToNextScreen")
  end;
};



return t
