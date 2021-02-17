local f = Def.ActorFrame{}

for i=1,2 do
  f[#f+1] = Def.ActorFrame{
    InitCommand=function(s)
      s:xy(i==1 and SCREEN_LEFT-3 or SCREEN_RIGHT+3,SCREEN_BOTTOM-80)
    end,
    OffCommand=function(s) s:smooth(0.2):diffusealpha(0) end,
    OnCommand=function(self)
     if GAMESTATE:GetNumPlayersEnabled() == 2 then
          self:visible(false)
      else
        self:visible(true)
        self:diffusealpha(0):zoomy(0):linear(0.3):zoomy(1):diffusealpha(1)
      end;
    end;
    PlayerJoinedMessageCommand=function(s,p)
      if p.Player then
        s:queuecommand("Off")
      end
    end,
    Def.Sprite{
      Texture=ddrgame.."frame",
      InitCommand=function(s) s:zoomx(i==1 and -1 or 1):halign(1) end,
    };
    Def.Sprite{
      Texture=THEME:GetPathG("","_shared/P"..i.." BADGE"),
      InitCommand=function(s) s:xy(i==1 and 110 or -110,-20) end,
    };
    Def.Sprite{
      Name="Messages",
      InitCommand=function(s) s:xy(i==1 and 280 or -280,2):queuecommand("Set") end,
      SetCommand=function(s)
        local GetP1 = GAMESTATE:IsPlayerEnabled(PLAYER_1)
        local GetP2 = GAMESTATE:IsPlayerEnabled(PLAYER_2)
        local masterPlayer = GAMESTATE:GetMasterPlayerNumber()
        if i==1 then
          if GetP1 == true and GAMESTATE:GetNumPlayersEnabled() == 1 then
            s:Load(THEME:GetPathB("","ScreenSelectStyle overlay/"..ddrgame..lang.."_P1here"));
          elseif GetP1 == false and GAMESTATE:PlayersCanJoin() and GAMESTATE:GetMasterPlayerNumber() == PLAYER_2 then
            s:Load(THEME:GetPathB("","ScreenSelectStyle overlay/"..ddrgame..lang.."_P1CanJoin"));
          elseif GetP1 == false and GAMESTATE:GetMasterPlayerNumber() == PLAYER_2  then
            if GAMESTATE:GetCoins() ~= GAMESTATE:GetCoinsNeededToJoin() and GAMESTATE:IsEventMode() == false then
              s:Load(THEME:GetPathB("","ScreenSelectStyle overlay/credit"));
            end;
          else
            s:Load(THEME:GetPathB("","ScreenSelectStyle overlay/"..ddrgame..lang.."_P1here"));
          end
        else
          if GetP2 == true and GAMESTATE:GetNumPlayersEnabled() == 1 then
            s:Load(THEME:GetPathB("","ScreenSelectStyle overlay/"..lang.."_P2here"));
          elseif GetP2 == false and GAMESTATE:GetMasterPlayerNumber() == PLAYER_1  then
            if GAMESTATE:GetCoins() ~= GAMESTATE:GetCoinsNeededToJoin()  and GAMESTATE:IsEventMode() == false then
              s:Load(THEME:GetPathB("","ScreenSelectStyle overlay/credit"));
            else
              s:Load(THEME:GetPathB("","ScreenSelectStyle overlay/"..ddrgame..lang.."_P2CanJoin"));
            end;
          else
            s:Load(THEME:GetPathB("","ScreenSelectStyle overlay/"..ddrgame..lang.."_P2here"));
          end
        end
      end
    };
  };

  f[#f+1] = Def.ActorFrame{
    Name="Arrows",
    InitCommand=function(s) s:xy(i==1 and _screen.cx-264 or _screen.cx+264,_screen.cy+194):rotationy(i==2 and 180 or 0):diffusealpha(0) end,
    OnCommand=function(s) s:smooth(0.3):diffusealpha(1) end,
    OffCommand=function(s) s:smooth(0.2):addx(i==1 and -50 or 50):diffusealpha(0) end,
    Def.Sprite{
      Texture=THEME:GetPathG("","_shared/_selectarrowg");
      MenuLeftP1MessageCommand=function(s)
        if i==1 then
          s:smooth(0.1):addx(-20):smooth(0.1):addx(20)
        end
      end,
      MenuLeftP2MessageCommand=function(s) s:queuecommand("MenuLeftP1") end,
      MenuRightP1MessageCommand=function(s)
        if i==2 then
          s:smooth(0.1):addx(-20):smooth(0.1):addx(20)
        end
      end,
      MenuRightP2MessageCommand=function(s) s:queuecommand("MenuRightP1") end,
    };
    Def.Sprite{
      Texture=THEME:GetPathG("","_shared/_selectarrowr");
      OnCommand=function(s) s:diffusealpha(0) end,
      MenuLeftP1MessageCommand=function(s)
        if i==1 then
          s:diffusealpha(1):smooth(0.1):addx(-20):smooth(0.1):addx(20):diffusealpha(0)
        end
      end,
      MenuLeftP2MessageCommand=function(s) s:queuecommand("MenuLeftP1") end,
      MenuRightP1MessageCommand=function(s)
        if i==2 then
          s:diffusealpha(1):smooth(0.1):addx(-20):smooth(0.1):addx(20):diffusealpha(0)
        end
      end,
      MenuRightP2MessageCommand=function(s) s:queuecommand("MenuRightP1") end,
    };
  };
  f[#f+1] = Def.Sprite{
    Name="Press Start",
    Texture=ddrgame.."StartJoinSSS",
    InitCommand=function(s)
      s:xy(i==1 and SCREEN_LEFT+240 or SCREEN_RIGHT-240,_screen.cy+164):zoom(0):diffusealpha(0):queuecommand("Set")
    end,
    AnimateCommand=cmd(linear,0.25;zoomx,0.95;linear,0.25;zoomx,1;queuecommand,"Animate");
    OffCommand=cmd(stoptweening;linear,0.25;zoomy,0;diffusealpha,0);
    SetCommand=function(s)
      local GetP1 = GAMESTATE:IsPlayerEnabled(PLAYER_1)
      local GetP2 = GAMESTATE:IsPlayerEnabled(PLAYER_2)
      local masterPlayer = GAMESTATE:GetMasterPlayerNumber()
      if i==1 then
        if GetP1 == true then
          s:zoom(0)
        else
          if GAMESTATE:GetCoins() ~= GAMESTATE:GetCoinsNeededToJoin() then
            s:zoom(0)
          else
            s:zoom(0):rotationz(-720):linear(0.35):rotationz(720):diffusealpha(1):zoom(1):playcommand("Animate")
          end
        end
      else
        if GetP2 == true then
          s:zoom(0)
        else
          if GAMESTATE:GetCoins() ~= GAMESTATE:GetCoinsNeededToJoin() then
            s:zoom(0)
          else
            s:zoom(0):rotationz(-720):linear(0.35):rotationz(720):diffusealpha(1):zoom(1):playcommand("Animate")
          end
        end
      end
    end,
    CoinsChangedMessageCommand=function(self)
      self:queuecommand("Set");
    end;
    PlayerJoinedMessageCommand=function(self,param)
      if param.Player then
        (cmd(linear,0.15;zoomy,0;))(self);
      end;
    end;
  };
end


return Def.ActorFrame{
  PlayerJoinedMessageCommand=function(self)
    self:queuecommand("Delay1")
  end;
  Delay1Command=function(self)
    self:sleep(2)
    self:queuecommand("SetScreen")
  end;
  SetScreenCommand=function(self)
    GAMESTATE:SetCurrentStyle("versus")
    SCREENMAN:GetTopScreen():SetNextScreenName("ScreenProfileLoad"):StartTransitioningScreen("SM_GoToNextScreen")
  end;
  f;
}