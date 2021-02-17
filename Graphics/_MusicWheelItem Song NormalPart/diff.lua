local pn = ...

return Def.ActorFrame{
    SetCommand=function(self,param)
		self.CurSong = param.Song;
        self:queuecommand "DiffChange";
    end;
    ["CurrentStepsChanged"..pn.."MessageCommand"]=function(s) s:queuecommand("DiffChange") end,
    LoadActor("difficultyback01")..{
        InitCommand=function(s) s:draworder(1):visible(false):zoom(0.75) end;
		DiffChangeCommand = function(self)
			local cur_song = self:GetParent().CurSong;
			local steps = SameDiffSteps(cur_song, pn);
            self:visible(steps~=nil);
		end;
		CurrentSongChangedMessageCommand=function(s) s:queuecommand('DiffChange') end,
    };
	LoadActor("difficultyback02")..{
		InitCommand=function(s) s:draworder(1):visible(false):zoom(0.75) end;
		DiffChangeCommand = function(self)
			local cur_song = self:GetParent().CurSong;
			local steps = SameDiffSteps(cur_song, pn);
            self:visible(steps~=nil);
			if steps then
				self:diffuse(CustomDifficultyToColor(steps:GetDifficulty()));
			end;
		end;
		CurrentSongChangedMessageCommand=function(s) s:queuecommand('DiffChange') end,
	};
	Def.BitmapText{
		InitCommand=function(s) s:draworder(2):y(-14):strokecolor(Color.Black) end;
		Font="_geo 95 20px";
		DiffChangeCommand=function(self)
			local cur_song = self:GetParent().CurSong;
			local steps = SameDiffSteps(cur_song, pn);
            self:visible(steps~=nil);
			if steps then
				self:settext(steps:GetMeter()):zoomx(2.75):zoomy(2.25)
			end;
		end;
		CurrentSongChangedMessageCommand=function(s) s:queuecommand('DiffChange') end,
	};
};
