local pn = ...

local function base_x()
	if pn == PLAYER_1 then
		return _screen.cx-360
	elseif pn == PLAYER_2 then
		return _screen.cx+360
	else
	  error("Pass a valid player number, dingus.",2)
	end
end

return Def.ActorFrame{
    InitCommand=function(s)
        s:xy(base_x(),SCREEN_TOP+36):draworder(99)
    end,
    Name="LifeFrame",
    Def.Sprite{
        Texture="stream/gauge0000_gauge_normal (stretch)",
        OnCommand=function(s) s:setsize(442,34):y(-1)
            :MaskDest():ztestmode("ZTestMode_WriteOnFail"):customtexturerect(0,0,1,1)
            :texcoordvelocity(pn=="PlayerNumber_P2" and 0.5 or -0.5,0)
        end,
        HealthStateChangedMessageCommand=function(self, param)
			if param.PlayerNumber == pn then
				if param.HealthState == "HealthState_Danger" then
					self:Load(THEME:GetPathB("","ScreenGameplay decorations/lifeframe/stream/gauge0000_gauge_danger_eff (stretch).png"))
				elseif param.HealthState == "HealthState_Hot" then
					self:Load(THEME:GetPathB("","ScreenGameplay decorations/lifeframe/stream/gauge0000_gauge_rainbow (stretch).png"))
		  		else
					self:Load(THEME:GetPathB("","ScreenGameplay decorations/lifeframe/stream/gauge0000_gauge_normal (stretch).png"))
		  		end;
		  		self:scaletoclipped(442,31)
			end;
		end;
    };
    Def.Sprite{
        Name="LifeFrame"..pn,
        InitCommand=function(s) s:x(pn==PLAYER_1 and 0 or 0):rotationy(pn==PLAYER_2 and 180 or 0) end,
        BeginCommand=function(self)
            if GAMESTATE:PlayerIsUsingModifier(pn,'battery') or GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
            self:Load(THEME:GetPathB("ScreenGameplay","decorations/lifeframe/"..ddrgame.."gauge0000_frame_4life.png"))  
          else
              self:Load(THEME:GetPathB("ScreenGameplay","decorations/lifeframe/"..ddrgame.."gauge0000_frame_normal.png"))
          end;
        end
    }
}