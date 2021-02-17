return Def.ActorFrame {
	InitCommand=function(self)
		self:x(-10);
		self:y(-20);
		--self:visible(PREFSMAN:GetPreference("MenuTimer"));
	end;
	LoadActor(ddrgame.."coti_base_tri")..{
		OffCommand=cmd(linear,0.167;zoom,0);
	};
	Def.ActorFrame{
		OnCommand=cmd(playcommand,"Tick");
		TickCommand=cmd(diffusealpha,1;linear,0.4;diffusealpha,0;sleep,0.6;queuecommand,"Tick");
		OffCommand=cmd(stoptweening;linear,0.167;diffusealpha,0);
		Def.Sprite{
			Texture="coti_base_tri_center_light",
		};
		Def.Sprite{
			Texture="coti_base_tri_line",
		};
	}
	
}