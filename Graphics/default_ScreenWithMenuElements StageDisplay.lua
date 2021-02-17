
local stages = Def.ActorFrame {
	BeginCommand=cmd(playcommand,"Set";);
	CurrentSongChangedMessageCommand=cmd(finishtweening;playcommand,"Set";);
};

local ScreenName = Var "LoadingScreen";

function MakeBitmapTest()
	return LoadFont(ScreenName,"StageDisplay") .. {

	};
end
if not PREFSMAN:GetPreference("EventMode") then
	for s in ivalues(Stage) do
		stages[#stages+1] = MakeBitmapTest() .. {
			SetCommand=function(self, params)
				local tRemap = {
					Stage_1st		= 1,
					Stage_2nd		= 2,
					Stage_3rd		= 3,
					Stage_4th		= 4,
					Stage_5th		= 5,
					Stage_6th		= 6,
--[[ 					'Stage_Next'	= 6,
					'Stage_Final'	= 7,
					'Stage_Extra1'	= 8,
					'Stage_Extra2'	= 9,
					'Stage_Nonstop'	= 10,
					'Stage_Oni'		= 11,
					'Stage_Endless'	= 12,
					'Stage_Event'	= 13,
					'Stage_Demo'	= 14, --]]
				}
				local Stage = GAMESTATE:GetCurrentStage();
				local StageIndex = GAMESTATE:GetCurrentStageIndex();
				local screen = SCREENMAN:GetTopScreen();
-- 				local cStageOutlineColor = ColorDarkTone( StageToStrokeColor(s) );
-- 				cStageOutlineColor[4] = 0.75;
				if screen and screen.GetStageStats then
					local ss = screen:GetStageStats();
					Stage = ss:GetStage();
					StageIndex = ss:GetStageIndex();
				end
				self:visible( Stage == s );
				
				if tRemap[Stage] == PREFSMAN:GetPreference("SongsPerPlay") then
					Stage = 'Stage_Final';
				else
					Stage = Stage;
					s = s;
				end;
				self:settext( string.format( THEME:GetString("ScreenWithMenuElements","StageCounter"), StageToLocalizedString(Stage) ) );
				-- self:diffuse( (Stage == 'Stage_Final') and StageToColor('Stage_Final') or StageToColor(s) );
				-- self:diffusebottomedge( (Stage == 'Stage_Final') and ColorMidTone(StageToColor('Stage_Final')) or ColorMidTone(StageToColor(s)) );
				-- self:strokecolor( (Stage == 'Stage_Final') and ColorDarkTone(StageToColor('Stage_Final')) or ColorDarkTone(StageToColor(s)) );

				--20190523
				self:settext("");

				self:x(315);
				self:y(11);
				self:zoomx(3);
				self:zoomy(2);
				self:maxwidth(70);
				self:diffuse(Color("Yellow"));
			end;
		}
		stages[#stages+1] = MakeBitmapTest() .. {
			SetCommand=function(self, params)
				local tRemap = {
					Stage_1st		= 1,
					Stage_2nd		= 2,
					Stage_3rd		= 3,
					Stage_4th		= 4,
					Stage_5th		= 5,
					Stage_6th		= 6,
--[[ 					'Stage_Next'	= 6,
					'Stage_Final'	= 7,
					'Stage_Extra1'	= 8,
					'Stage_Extra2'	= 9,
					'Stage_Nonstop'	= 10,
					'Stage_Oni'		= 11,
					'Stage_Endless'	= 12,
					'Stage_Event'	= 13,
					'Stage_Demo'	= 14, --]]
				}
				local Stage = GAMESTATE:GetCurrentStage();
				local StageIndex = GAMESTATE:GetCurrentStageIndex();
				local screen = SCREENMAN:GetTopScreen();
-- 				local cStageOutlineColor = ColorDarkTone( StageToStrokeColor(s) );
-- 				cStageOutlineColor[4] = 0.75;
				if screen and screen.GetStageStats then
					local ss = screen:GetStageStats();
					Stage = ss:GetStage();
					StageIndex = ss:GetStageIndex();
				end
				self:visible( Stage == s );
				
				if tRemap[Stage] == PREFSMAN:GetPreference("SongsPerPlay") then
					Stage = 'Stage_Final';
				else
					Stage = Stage;
					s = s;
				end;
				self:settext( string.format( THEME:GetString("ScreenWithMenuElements","StageCounter"), StageToLocalizedString(Stage) ) );
				self:x(320);
				self:y(-600);
				self:zoomx(3);
				self:zoomy(2);
				self:maxwidth(100);
				self:diffuse(Color("Yellow"));
			end;
		}
	end
else
	stages[#stages+1] = MakeBitmapTest() .. {
		SetCommand=function(self,params)
			if Var "LoadingScreen" then
				local Offset = THEME:GetMetric(Var "LoadingScreen","StageDisplayNumberOffset");
				local Stage = GAMESTATE:GetCurrentStageIndex();
				local RealStage = Stage + Offset;
--				self:settextf( THEME:GetString("ScreenWithMenuElements","EventStageCounter"), RealStage );
				self:settext("EVENT STAGEst");
				self:x(315);
				self:y(11);
				self:zoomx(3);
				self:zoomy(2);
				self:maxwidth(70);
				self:diffuse(Color("Yellow"));
				self:strokecolor(color("#005599"));
			end;
		end;
	}


end

return stages;
