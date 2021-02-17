local t = Def.ActorFrame{}

if not GAMESTATE:IsDemonstration() then
	t[#t+1] = Def.ActorFrame{
		Def.Sound{
			File=THEME:GetPathS("","_select.ogg"),
			OnCommand=function(s) s:play() end,
		};
		loadfile(THEME:GetPathB("ScreenWithMenuElements","background"))()..{
			OnCommand=function(s) s:linear(0.083):diffusealpha(0) end,
		};
		Def.Sprite{
			Texture=THEME:GetPathB("ScreenStageInformation","decorations/scanlines"),
			InitCommand=function(s) s:Center():diffusealpha(0.5) end,
			OnCommand=function(s)
				s:linear(0.5):diffusealpha(0)
			end,
		};
		Def.ActorFrame{
			Name="Top",
			InitCommand=function(s) s:zoom(1):xy(_screen.cx,SCREEN_TOP+126) end,
			OnCommand=function(s) s:linear(0.483):y(SCREEN_TOP-126) end,
			Def.Sprite{
				Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_frame"),
				InitCommand=function(s) s:halign(1) end,
			};
			Def.Sprite{
				Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_frame"),
				InitCommand=function(s) s:halign(1):zoomx(-1) end,
			};
			Def.ActorFrame{
				Def.Sprite{
					Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_edge_flash"),
					InitCommand=function(s) s:halign(1) end,
				};
				Def.Sprite{
					Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_edge_flash"),
					InitCommand=function(s) s:halign(1):zoomx(-1) end,
				};
			};
		};
		Def.ActorFrame{
			Name="Bottom",
			InitCommand=function(s) s:zoom(1):xy(_screen.cx,SCREEN_BOTTOM-126):rotationx(180) end,
			OnCommand=function(s) s:linear(0.483):y(SCREEN_BOTTOM+126) end,
			Def.Sprite{
				Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_frame"),
				InitCommand=function(s) s:halign(1) end,
			};
			Def.Sprite{
				Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_frame"),
				InitCommand=function(s) s:halign(1):zoomx(-1) end,
			};
			Def.ActorFrame{
				Def.Sprite{
					Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_edge_flash"),
					InitCommand=function(s) s:halign(1) end,
				};
				Def.Sprite{
					Texture=THEME:GetPathB("","_door_Stagein/"..ddrgame.."scch_edge_flash"),
					InitCommand=function(s) s:halign(1):zoomx(-1) end,
				};
			};
		};
		Def.Sprite{
			Condition=GoldenLeague == false or ddrgame=="blue_",
			Texture=THEME:GetPathB("ScreenStageInformation","decorations/lights.png"),
			InitCommand=function(s) s:Center():blend(Blend.Add) end,
			OnCommand=function(s) s:sleep(0.134):linear(0.3):diffusealpha(0) end,
			
		};
		Def.ActorFrame{
			InitCommand=function(s) s:Center():blend(Blend.Add) end,
			OnCommand=function(s)
				s:linear(0.1):zoom(0)
			end,
			Def.Sprite{
				Texture=THEME:GetPathB("ScreenStageInformation","decorations/coch_hud"),
				InitCommand=function(s) s:halign(1) end
			};
			Def.Sprite{
				Texture=THEME:GetPathB("ScreenStageInformation","decorations/coch_hud"),
				InitCommand=function(s) s:halign(1):zoomx(-1) end,
			};
		};
		Def.Sprite{
			InitCommand=function(s) s:Center():playcommand("Set") end,
			OnCommand=function(s) s:sleep(1.41):linear(0.06):zoom(1.5):diffusealpha(0) end,
			SetCommand=function(s)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if song then
					s:_LoadSCJacket(song)
				else
					s:LoadBackground(course:GetBannerPath())
				end
				s:setsize(480,480)
			end,
		};
	};
end

return Def.ActorFrame{
	t;
};