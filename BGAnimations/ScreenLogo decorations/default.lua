local t = Def.ActorFrame{
  LoadActor(ddrgame.."back")..{
    InitCommand=cmd(CenterX;y,_screen.cy-54;zoom,1);
  };
  LoadActor(ddrgame.."logo")..{
    InitCommand=cmd(CenterX;y,_screen.cy-54;zoom,1);
  };
  LoadActor("copyright")..{
    InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-148;zoom,0.8);
  };
  Def.BitmapText{
    Font="_futura pt medium 30px";
    InitCommand=cmd(settext,"MDX:J:A:A:2018102200";halign,0;xy,SCREEN_LEFT+8,SCREEN_TOP+15;zoomx,0.62;zoomy,0.6;strokecolor,color("0,0,0,0.5"));
  };
};

return t;
