local t = ...;
t = Def.ActorFrame{
	LoadActor("Back")..{
	InitCommand=cmd(addx,348;addy,1;diffuseshift;effectcolor1,1,1,1,0.4;effectcolor2,1,1,1,0;effectclock,'beatnooffset');
	};
	LoadActor("Colour")..{
	InitCommand=cmd(addx,348;addy,1;);
	};
	
	Def.Sprite {
	Texture="ScreenPlayerOptions LineHighlight P2 1x2";
	
	Frame0000=0;
	Delay0000=0.5;
	
	Frame0001=1;
	Delay0001=0.5;
	InitCommand=cmd(addx,262+160);
	};	
	
};	
return t;