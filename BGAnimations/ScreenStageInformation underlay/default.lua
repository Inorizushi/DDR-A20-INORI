local t = Def.ActorFrame {
	
			-- LoadActor( "../CourseModeBG" )..{
				-- InitCommand=cmd();
				-- OnCommand=function(self)
					-- if GAMESTATE:IsCourseMode() then	
						-- (cmd(diffusealpha,1))(self);
					-- else
						-- (cmd(diffusealpha,0))(self);
					-- end;
				-- end;
			-- };
			
		-- LoadActor( "../ExModeBG" )..{
			-- InitCommand=cmd();
			-- OnCommand=function(self)
				-- if GAMESTATE:IsExtraStage()==true or GAMESTATE:IsExtraStage2()==true then	
				--if STATSMAN:GetCurStageStats():GetStage()== 'Stage_Extra1' or STATSMAN:GetCurStageStats():GetStage()== 'Stage_Extra2' then
					-- (cmd(visible,1))(self);
				-- else
					-- (cmd(visible,0))(self);
				-- end;
			-- end;
		-- };
};
return t;