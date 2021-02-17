function ThemeManager:GetAbsolutePath(sPath, optional)
	local sFinPath = self:GetCurrentThemeDirectory().."/"..sPath
	if not optional then
		assert(FILEMAN:DoesFileExist(sFinPath), "the theme element "..sPath.." is missing")
	end
	return sFinPath
end


function cutin(player)
	local ShowDancingCharacters = GetUserPrefB("FirstReMIX_ShowDancingCharacters");
	local character = GAMESTATE:GetCharacter(player):GetCharacterID();
	if not ShowDancingCharacters then
		return false;
	elseif character == "Afro" or character == "Lady" or character == "Emi" then
		return true;
	else
		return false;
	end;
end;

function jacketpath(text, so)
	if not text or text =="" then
		return nil
	end
	
	so = ToEnumShortString(so)
	if so == "Genre" then
		return THEME:GetPathG("","Common fallback jacket")
	elseif so == "TopGrades" then
		return THEME:GetPathG("","_jackets/sort/grade/"..group_name[text]..".png")
	elseif string.find(so,"Meter") then
		return THEME:GetPathG("","_jackets/sort/EasyMeter/"..group_name[text]..".png")
	else
		local internalPath = THEME:GetAbsolutePath("Graphics/_jackets/sort/"..so.."/"..text..".png", true)
		if FILEMAN:DoesFileExist(internalPath) then
			return internalPath
		end
		if so == "Group" then
			local groupPath = GetGroupJacketPath(text, SONGMAN:GetSongGroupBannerPath(text))
			if FILEMAN:DoesFileExist(groupPath) then
				return groupPath
			else
			end
		end
	end
	return THEME:GetPathG("Common","fallback jacket")
end

function jacketset(self)
	local mw = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
	local fPath2 = THEME:GetPathG("","Common fallback jacket")
	if mw:GetSelectedType() == "WheelItemDataType_Section" then
		fPath2 = jacketpath(mw:GetSelectedSection(), GAMESTATE:GetSortOrder())
	end
	return fPath2
end

function jacketsetwi(_,params)
	return jacketpath(params.Text, GAMESTATE:GetSortOrder())
end

function SameDiffSteps(song, pn)
    if song then
		local diff = GAMESTATE:GetCurrentSteps(pn):GetDifficulty();
		local st = GAMESTATE:GetCurrentStyle():GetStepsType();
		return song:GetOneSteps(st, diff);
	end;
end;

-- �W���b�W���x���ݒ�
function JudgmentTransformCommand( self, params )
	local x = 0
	local y = -76
	-- ���o�[�X����Y���ݒ�A�Z���^�[����{
	if params.bReverse then y = 67 end
	-- This makes no sense and wasn't even being used due to misspelling.
	-- if bCentered then y = y * 2 end
	self:x( x )
	self:y( y )
end

-- �R���{�ݒ�
function ComboTransformCommand( self, params )
	local x = 0
	local y = 38
	if params.bReverse then y = -23 end

	--[[
	if params.bCentered then
		if params.bReverse then
			y = y - 30
		else
			y = y + 40
		end
	end
	--]]
	self:x( x )
	self:y( y )
end
function SongMeterDisplayX(pn)
	if Center1Player() then
		return SCREEN_CENTER_X
	else
		return pn == PLAYER_1 and SCREEN_LEFT+16 or SCREEN_RIGHT-16
	end
end

function SongMeterDisplayY(pn)
	return Center1Player() and SCREEN_TOP+50 or SCREEN_CENTER_Y
end

function SongMeterDisplayCommand(pn)
	if Center1Player() then
		return cmd(draworder,50;zoom,0;y,SCREEN_TOP-24;sleep,1.5;decelerate,0.5;zoom,1;y,SCREEN_TOP+50)
	else
		local xAdd = (pn == PLAYER_1) and -24 or 24
		return cmd(draworder,5;rotationz,-90;zoom,0;addx,xAdd;sleep,1.5;decelerate,0.5;zoom,1;addx,xAdd*-1)
	end
end
function JudgmentTransformCommand( self, params )
	local x = 0
	local y = -76
	-- ���o�[�X����Y���ݒ�A�Z���^�[����{
	if params.bReverse then y = 67 end
	-- This makes no sense and wasn't even being used due to misspelling.
	-- if bCentered then y = y * 2 end
	self:x( x )
	self:y( y )
end

-- �R���{�ݒ�
function ComboTransformCommand( self, params )
	local x = 0
	local y = 38
	if params.bReverse then y = -23 end

	--[[
	if params.bCentered then
		if params.bReverse then
			y = y - 30
		else
			y = y + 40
		end
	end
	--]]
	self:x( x )
	self:y( y )
end
function IsPlayingWorkout()
	return GAMESTATE:GetEnv("Workout") == "1"
end
	
function WorkoutResetStageStats()
	STATSMAN:Reset()
end

function WorkoutGetProfileGoalType( pn )
	return PROFILEMAN:GetProfile(pn):GetGoalType()
end

function WorkoutGetStageCalories( pn )
	return STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetCaloriesBurned()
end

function WorkoutGetTotalCalories( pn )
	return STATSMAN:GetAccumStageStats():GetPlayerStageStats(pn):GetCaloriesBurned()
end

function WorkoutGetTotalSeconds( pn )
	return STATSMAN:GetAccumStageStats():GetGameplaySeconds()
end

function WorkoutGetGoalCalories( pn )
	return PROFILEMAN:GetProfile(pn):GetGoalCalories()
end

function WorkoutGetGoalSeconds( pn )
	return PROFILEMAN:GetProfile(pn):GetGoalSeconds()
end

function WorkoutGetPercentCompleteCalories( pn )
	return WorkoutGetTotalCalories(pn) / WorkoutGetGoalCalories(pn)
end

function WorkoutGetPercentCompleteSeconds( pn )
	return WorkoutGetTotalSeconds(pn) / WorkoutGetGoalSeconds(pn)
end

local numbered_stages= {
	Stage_1st= true,
	Stage_2nd= true,
	Stage_3rd= true,
	Stage_4th= true,
	Stage_5th= true,
	Stage_6th= true,
	Stage_Next= true,
}

function thified_curstage_index(on_eval)
	local cur_stage= GAMESTATE:GetCurrentStage()
	local adjust= 1
	-- hack: ScreenEvaluation shows the current stage, but it needs to show
	-- the last stage instead.  Adjust the amount.
	if on_eval then
		adjust= 0
	end
	if numbered_stages[cur_stage] then
		return FormatNumberAndSuffix(GAMESTATE:GetCurrentStageIndex() + adjust)
	else
		return ToEnumShortString(cur_stage)
	end
end