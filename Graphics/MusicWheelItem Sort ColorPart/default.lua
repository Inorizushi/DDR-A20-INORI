function arrangeXPosition3(myself, index, offset)
	if index%2==0 then
		myself:x(-230+offset);
	elseif index%2==1 then
		myself:x(230+offset);
	else
		myself:x(300+offset);
	end;
end

local t = Def.ActorFrame {



--border bright

	--DefaultBG

 	LoadActor("cat_normal")..{
		InitCommand=cmd(y,-8;zoom,2.5;);
		SetCommand=function(self,params)
			if params.Index then
				arrangeXPosition3(self,params.Index,0);
			end
		end;
	};
	LoadActor("cat_bright")..{
		InitCommand=cmd(y,-8;zoom,2.5;diffusecolor,Color("Yellow");blend,Blend.Add;diffusealpha,0.5;thump;effectclock,'beat';effectmagnitude,1,1.1,1;effectoffset,0.20;);
		SetCommand=function(self,params)
			if params.HasFocus then
				self:zoom(2.7);
			else
				self:zoom(0);
			end
			if params.Index then
				arrangeXPosition3(self,params.Index,0);
			end
		end;
	};	
	LoadActor("cat_over")..{
		InitCommand=cmd(y,-8;zoom,0);
		SetMessageCommand=function(self,params)
			
			if params.HasFocus then
				self:zoom(2.7);
			else
				self:zoom(0);
			end
			if params.Index then
				arrangeXPosition3(self,params.Index,0);
			end
		end;
		};
		

  LoadFont("_dfghsgothic-w9 20px")..{
		InitCommand=cmd(y,0;zoom,1.5;maxwidth,240;diffuse,Color("White");uppercase,true);
		SetCommand=function(self,params)
			self:stoptweening();
			self:settextf("%s",params.Label);
			if params.Index then
				arrangeXPosition3(self,params.Index,0);
			end
			if params.HasFocus then
				self:diffuse(Color("Black"));
			else
				self:diffuse(Color("White"));
			end
    end;
  };

};
return t;