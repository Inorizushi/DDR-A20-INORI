local t = Def.ActorFrame{};



local function setDiffBG1(self,param)
  local st = GAMESTATE:GetCurrentStyle():GetStepsType()
  if self.ParamCourse then
    local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
    if trail then
      local sDiff = trail:GetDifficulty()
			
      local diffname = GAMESTATE:GetCurrentTrail(PLAYER_2):GetDifficulty()
		local alltrails = self.ParamCourse:GetAllTrails();
		
		local temp=#alltrails;
		if alltrails[1] then
			for i=1,temp do 
				if alltrails[i]:GetDifficulty() == diffname and st == alltrails[i]:GetStepsType() then
					targetindex = i;
					break;
				end
				
				if i== temp then
					targetindex = 0;
				end
			end
		end
		
      if alltrails[1] and targetindex~=0 then
  			self:diffuse(color("1,1,1,1"))
  		else
  			self:diffuse(color("1,1,1,0"))
  		end;
  	else
  		self:diffuse(color("1,1,1,0"))
  	end;
  end;
end;

local function setDiffBG2(self,param)
  local st = GAMESTATE:GetCurrentStyle():GetStepsType()
  if self.ParamCourse then
    local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
    if trail then
      local sDiff = trail:GetDifficulty()
			 
      local diffname = GAMESTATE:GetCurrentTrail(PLAYER_2):GetDifficulty()
		local alltrails = self.ParamCourse:GetAllTrails();
		
		local temp=#alltrails;
		if alltrails[1] then
			for i=1,temp do 
				if alltrails[i]:GetDifficulty() == diffname and st == alltrails[i]:GetStepsType() then
					targetindex = i;
					break;
				end
				
				if i== temp then
					targetindex = 0;
				end
			end
		end
		
      if alltrails[1] and targetindex~=0 then
  			self:diffuse(CustomDifficultyToColor(diffname));
  		else
  			self:diffuse(color("1,1,1,0"))
  		end;
  	else
  		self:diffuse(color("1,1,1,0"))
  	end;
  end;
end;

local function setDiff(self,param)
	local st = GAMESTATE:GetCurrentStyle():GetStepsType()
	local targetindex = 1;
	if self.ParamCourse then
		local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
		if trail then
			local sDiff = trail:GetDifficulty()
			
			local diffname = GAMESTATE:GetCurrentTrail(PLAYER_2):GetDifficulty()
			local alltrails = self.ParamCourse:GetAllTrails();
			
			local temp=#alltrails;
			if alltrails[1] then
				for i=1,temp do 
					if alltrails[i]:GetDifficulty() == diffname and st == alltrails[i]:GetStepsType() then
						targetindex = i;
						break;
					end
					
					if i== temp then
						targetindex = 0;
					end
				end
			end

			
			if alltrails[1] and targetindex~=0 then
				if self:GetName() == diffname then
						
						self:settext( alltrails[targetindex]:GetMeter() )
						self:visible(true)
						self:zoom(2)
				else
					self:visible(false)
				end;
			else
				self:settext("")
			end;
		else
			self:settext("")
		end;
	end;
end;



t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:x(108)
		self:y(-62)
	end;
	Def.ActorFrame{
		InitCommand=cmd(draworder,0);
		LoadActor("difficultyback01")..{
			SetCommand=function(self,param)
				self.ParamCourse = param.Course
				setDiffBG1(self)
				self:zoomy(1.2)
				self:zoomx(-1.2)
			end;
			CurrentTrailP2ChangedMessageCommand=function(self) setDiffBG1(self) end;
			CurrentCourseChangedMessageCommand=function(self) setDiffBG1(self) end;
		};
	};
	
	Def.ActorFrame{
		InitCommand=cmd(draworder,1);
		LoadActor("difficultyback02")..{
			SetCommand=function(self,param)
				self.ParamCourse = param.Course
				setDiffBG2(self)
				self:zoomy(1.2)
				self:zoomx(-1.2)
			end;
			CurrentTrailP2ChangedMessageCommand=function(self) setDiffBG2(self) end;
			CurrentCourseChangedMessageCommand=function(self) setDiffBG2(self) end;
		};
	};
	

	Def.ActorFrame{
		InitCommand=cmd(zoomx,1.2;zoomy,1.0;draworder,2;y,-14);
		Def.BitmapText{
			InitCommand=cmd(diffuse,color("#FFFFFF");strokecolor,color("#000000"));
			Font="_geo 95 20px";
			Name = "Difficulty_Beginner";
			SetCommand=function(self,param)
				self.ParamCourse = param.Course
				setDiff(self)
			end;
			CurrentTrailP2ChangedMessageCommand=function(self) setDiff(self) end;
			CurrentCourseChangedMessageCommand=function(self) setDiff(self) end;
		};
		Def.BitmapText{
			Font="_geo 95 20px";
			Name = "Difficulty_Easy";
			InitCommand=cmd(diffuse,color("#FFFFFF");strokecolor,color("#000000"));
			SetCommand=function(self,param)
				self.ParamCourse = param.Course
				setDiff(self)
			end;
			CurrentTrailP2ChangedMessageCommand=function(self) setDiff(self) end;
			CurrentCourseChangedMessageCommand=function(self) setDiff(self) end;
		};
		Def.BitmapText{
			Font="_geo 95 20px";
			Name = "Difficulty_Medium";
			InitCommand=cmd(diffuse,color("#FFFFFF");strokecolor,color("#000000"));
			SetCommand=function(self,param)
				self.ParamCourse = param.Course
				setDiff(self)
			end;
			CurrentTrailP2ChangedMessageCommand=function(self) setDiff(self) end;
			CurrentCourseChangedMessageCommand=function(self) setDiff(self) end;
		};
		Def.BitmapText{
			Font="_geo 95 20px";
			Name = "Difficulty_Hard";
			InitCommand=cmd(diffuse,color("#FFFFFF");strokecolor,color("#000000"));
			SetCommand=function(self,param)
				self.ParamCourse = param.Course
				setDiff(self)
			end;
			CurrentTrailP2ChangedMessageCommand=function(self) setDiff(self) end;
			CurrentCourseChangedMessageCommand=function(self) setDiff(self) end;
		};
		Def.BitmapText{
			Font="_geo 95 20px";
			Name = "Difficulty_Challenge";
			InitCommand=cmd(diffuse,color("#FFFFFF");strokecolor,color("#000000"));
			SetCommand=function(self,param)
				self.ParamCourse = param.Course
				setDiff(self)
			end;
			CurrentTrailP2ChangedMessageCommand=function(self) setDiff(self) end;
			CurrentCourseChangedMessageCommand=function(self) setDiff(self) end;
		};
		Def.BitmapText{
			Font="_geo 95 20px";
			Name = "Difficulty_Edit";
			InitCommand=cmd(diffuse,color("#FFFFFF");strokecolor,color("#000000"));
			SetCommand=function(self,param)
				self.ParamCourse = param.Course
				setDiff(self)
			end;
			CurrentTrailP2ChangedMessageCommand=function(self) setDiff(self) end;
			CurrentCourseChangedMessageCommand=function(self) setDiff(self) end;
		};
		
	};
};
return t;
