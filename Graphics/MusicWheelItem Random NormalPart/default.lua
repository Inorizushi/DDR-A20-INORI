local t = Def.ActorFrame {

--border bright

	--DefaultBG
 	LoadActor("normal")..{
		InitCommand=cmd(y,-8;zoom,2.5;);
			SetMessageCommand=function(self,params)
		if params.HasFocus then
				self:zoom(3.0);
			else
				self:zoom(2.5);
			end
	end;
	};
	LoadActor("normal")..{
		InitCommand=cmd(y,-8;zoom,2.5;diffusecolor,Color("Red");blend,Blend.Add;diffusealpha,0.5;thump;effectclock,'beat';effectmagnitude,1.0,1.05,1.0;effectoffset,0.35;);
		SetMessageCommand=function(self,params)
			if params.HasFocus then
				self:zoom(3.0);
			else
				self:zoom(0);
			end
		end;
		};
		
LoadActor("bright")..{
		InitCommand=cmd(y,-8;zoom,0;);
		SetMessageCommand=function(self,params)
			
			if params.HasFocus then
				self:zoom(3.0);
				(cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.5;effectclock,'beatnooffset'))(self);
			else
				self:zoom(0);
			end
		end;
		};
  LoadFont("_dfghsgothic-w9 20px")..{
		InitCommand=cmd(y,10;zoom,1.5;maxwidth,320;diffuse,Color("Red"));
		SetCommand=function(self,params)
			self:stoptweening();
			self:settextf("RANDOM SELECT MUSIC");
		if params.HasFocus then
				self:zoom(1.8);
				self:y(0);
			else
				self:zoom(1.5);
				self:y(0);
			end
    end;
  };

};
return t;
