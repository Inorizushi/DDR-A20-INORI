return Def.ActorFrame {
	LoadActor( "HOW_TO_PLAY_video" )..{
		InitCommand=cmd(FullScreen);
	};
	LoadActor( "HOW_TO_PLAY_music" )..{
		OnCommand=cmd(play);
		OffCommand=cmd(stop);
	};
}