local pn = ...

return Def.ActorFrame{
    SetCommand=function(self,param)
		self.CurSong = param.Song;
        self:queuecommand "DiffChange";
    end;
    ["CurrentStepsChanged"..pn.."MessageCommand"]=function(s) s:queuecommand("DiffChange") end,
    LoadActor(ddrgame.."diffback")..{
        InitCommand=function(s) s:draworder(1) end;
		DiffChangeCommand = function(self)
			local cur_song = self:GetParent().CurSong;
			local steps = SameDiffSteps(cur_song, pn);
		end;
		CurrentSongChangedMessageCommand=function(s) s:queuecommand('DiffChange') end,
    };
	LoadActor("diffcolor")..{
		InitCommand=function(s) s:draworder(1) end;
		DiffChangeCommand = function(self)
			local cur_song = self:GetParent().CurSong;
			local steps = SameDiffSteps(cur_song, pn);
			if steps then
				self:diffuse(CustomDifficultyToColor(steps:GetDifficulty()));
			end;
		end;
		CurrentSongChangedMessageCommand=function(s) s:queuecommand('DiffChange') end,
	};
	Def.BitmapText{
		InitCommand=function(s) s:draworder(2):y(-10):strokecolor(Color.Black) end;
		Font="_geo 95 20px";
		DiffChangeCommand=function(self)
			local cur_song = self:GetParent().CurSong;
			local steps = SameDiffSteps(cur_song, pn);
			if steps then
				self:settext(steps:GetMeter()):zoomx(1.5):zoomy(1.25)
			end;
		end;
		CurrentSongChangedMessageCommand=function(s) s:queuecommand('DiffChange') end,
	};
};
