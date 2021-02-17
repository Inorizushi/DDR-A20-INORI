return Def.ActorFrame {
	InitCommand=function(s) s:Center() end,
	LoadActor( "scene_choice_stage_bg_yellow_here" )..{
		OnCommand=function(self)
			self:diffusealpha(0):zoom(2)
			:linear(0.3):diffusealpha(1):zoom(1):sleep(0.5):linear(0.1):zoomy(0):diffusealpha(0);
		end;
	};
	LoadActor( ddrgame.."scene_choice_here_we_go" )..{
		Name="Actual",
		OnCommand=function(s) s:diffusealpha(0):zoom(1.2):sleep(0.2):linear(0.1)
			:diffusealpha(1):accelerate(0.1):zoomy(1.1):linear(0.1):zoom(1)
			:sleep(0.2):linear(0.1):zoomy(0):diffusealpha(0)
		end,
	};
	LoadActor( ddrgame.."scene_choice_here_we_go" )..{
		Name="Back",
		InitCommand=function(s) s:blend(Blend.Add) end,
		OnCommand=function(s) s:diffusealpha(0):zoom(0.3):linear(0.3):zoom(1)
			:diffusealpha(0.5):sleep(0):zoomx(1.3):linear(0.1):zoomx(2.3):zoomy(2):diffusealpha(0)
		end,
	};
	LoadActor( ddrgame.."scene_choice_here_we_go" )..{
		InitCommand=function(s) s:blend(Blend.Add) end,
		OnCommand=function(s) s:diffusealpha(0):zoom(2):linear(0.3):zoom(0.75):diffusealpha(0.5):linear(0):diffusealpha(0) end,
	};
};
