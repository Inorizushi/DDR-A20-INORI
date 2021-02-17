return Def.ActorFrame {
	LoadActor(ddrgame.."background")..{
		InitCommand=function(s) s:FullScreen() end,
	};
}
