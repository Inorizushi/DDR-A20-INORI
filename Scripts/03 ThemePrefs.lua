-- sm-ssc Default Theme Preferences Handler

-- Example usage of new system (not really implemented yet)
local Prefs =
{
	AutoSetStyle =
	{
		Default = false,
		Choices = { "ON", "OFF" },
		Values = { true, false }
	},
	Language = 
	{
		Default = "jp",
		Choices = {"Japanese","English", "Korean"},
		Values = {"jp","en","kor"}
	},
	Game = 
	{
		Default = "GOLD",
		Choices = { "GOLD", "BLUE"},
		Values = { "GOLD", "BLUE"},
	},
}

ThemePrefs.InitAll(Prefs)

GoldenLeague = false

lang = "jp_"
function ChangeLanguage()
	if ThemePrefs.Get("Language") == "jp" then
		lang = "jp"
	elseif ThemePrefs.Get("Language") == "kor" then
		lang = "kor"
	else
		lang="en"
	end
end

ddrgame = "gold_"
function ChangeGame()
	if ThemePrefs.Get("Game") == "GOLD" then
		ddrgame = "gold_"
	else
		ddrgame = "blue_"
	end
end

function InitUserPrefs()
	local Prefs = {
		UserPrefGameplayShowStepsDisplay = true,
		UserPrefGameplayShowStepsDisplay = true,
		UserPrefGameplayShowScore = false,
		UserPrefScoringMode = 'DDR Extreme',
		UserPrefShowLotsaOptions = true,
		UserPrefAutoSetStyle = false,
		UserPrefLongFail = false,
		UserPrefNotePosition = true,
		UserPrefComboOnRolls = false,
		UserPrefProtimingP1 = false,
		UserPrefProtimingP2 = false,
		UserPrefGameplayShowCalories=true,
		UserPrefGameplayShowFastSlow=true,
		FlashyCombos = false,
		UserPrefComboUnderField = true,
		UserPrefFancyUIBG = true,
		UserPrefTimingDisplay = true
	}
	for k, v in pairs(Prefs) do
		-- kind of xxx
		local GetPref = type(v) == "boolean" and GetUserPrefB or GetUserPref
		if GetPref(k) == nil then
			SetUserPref(k, v)
		end
	end

	-- screen filter
	setenv("ScreenFilterP1",0)
	setenv("ScreenFilterP2",0)
end

function GetProTiming(pn)
	local pname = ToEnumShortString(pn)
	if GetUserPref("ProTiming"..pname) then
		return GetUserPrefB("ProTiming"..pname)
	else
		SetUserPref("ProTiming"..pname,false)
		return false
	end
end

function GetNote(pn)
	local pname = ToEnumShortString(pn)
	if GetUserPref("NoteType"..pname) then
		return GetUserPrefB("NoteType"..pname)
	else
		SetUserPref("NoteType"..pname,false)
		return false
	end
end

function GetGameplaySubDisplay(pn)
	local pname = ToEnumShortString(pn)
	if GetUserPref("GameplaySubDisplay"..pname) then
		return GetUserPrefB("GameplaySubDisplay"..pname)
	else
		SetUserPref("GameplaySubDisplay"..pname,"Calorie Counter")
		return "Calorie Counter"
	end
end

--[[ option rows ]]
-- screen filter
function OptionRowScreenFilter()
	--we use integers equivalent to the alpha value multiplied by 10
	--to work around float precision issues
	local choiceToAlpha = {0, 25, 50, 75}
	local alphaToChoice = {[0]=1, [25]=2, [5]=3, [75]=4}
	local t = {
		Name="Filter",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = true,
		Choices = { THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionTitles', 'FilterDark'),
			THEME:GetString('OptionTitles', 'FilterDarker'),
			THEME:GetString('OptionTitles', 'FilterDarkest'),
		 },
		LoadSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local filterValue = getenv("ScreenFilter"..pName)

			if filterValue ~= nil then
				local val = alphaToChoice[filterValue] or 1
				list[val] = true
			else
				setenv("ScreenFilter"..pName,0)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						setenv("ScreenFilter"..pName,choiceToAlpha[i])
						found = true
					end
				end
			end
		end,
	};
	setmetatable(t, t)
	return t
end

function ReadOrCreateAppearancePlusValueForPlayer(PlayerUID, MyValue)
	local AppearancePlusFile = RageFileUtil:CreateRageFile()
	if AppearancePlusFile:Open("Save/AppearancePlus/"..PlayerUID..".txt",1) then 
		local str = AppearancePlusFile:Read();
		MyValue =str;
	else
		AppearancePlusFile:Open("Save/AppearancePlus/"..PlayerUID..".txt",2);
		AppearancePlusFile:Write("Visible");
		MyValue="Visible";
	end
	AppearancePlusFile:Close();
	return MyValue;
end

function SaveAppearancePlusValueForPlayer( PlayerUID, MyValue)

	
	local AppearancePlusFile2 = RageFileUtil:CreateRageFile();
	AppearancePlusFile2:Open("Save/AppearancePlus/"..PlayerUID..".txt",2);
	AppearancePlusFile2:Write(tostring(MyValue));
	AppearancePlusFile2:Close();
end

function OptionRowAppearancePlusUseFile()
	local t = {
		Name="AppearancePlus",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Visible", 'Hidden', 'Sudden', 'Stealth', 'Hidden+', 'Sudden+', 'Hidden+&Sudden+', },
		LoadSelections = function(self, list, pn)
			local AppearancePlusValue = "Visible";
			local pf = PROFILEMAN:GetProfile(pn);
			local PlayerUID = "";
			
			if pf then 
				PlayerUID = pf:GetGUID()  
				AppearancePlusValue = ReadOrCreateAppearancePlusValueForPlayer(PlayerUID,AppearancePlusValue);
			else
				PlayerUID = "UnknownPlayerUID"
				AppearancePlusValue = "Visible";
			end
			
			if AppearancePlusValue ~= nil then
				if AppearancePlusValue == "Hidden" then
					list[2] = true
				elseif AppearancePlusValue == "Sudden" then
					list[3] = true
				elseif AppearancePlusValue == "Stealth" then
					list[4] = true
				elseif AppearancePlusValue == "Hidden+" then
					list[5] = true
				elseif AppearancePlusValue == "Sudden+" then
					list[6] = true
				elseif AppearancePlusValue == "Hidden+&Sudden+" then
					list[7] = true
				else
					list[1] = true
				end
			else
				SaveAppearancePlusValueForPlayer(PlayerUID,"Visible")
				list[1] = true
			end
			
		end,
		SaveSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local found = false
			local PlayerUID = "";
			local pf = PROFILEMAN:GetProfile(pn);
			
			if pf then 
				PlayerUID = pf:GetGUID()  
			else
				PlayerUID = "UnknownPlayerUID"
			end
			
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = "Visible";
						if i==2 then
							val = "Hidden";
						elseif i==3 then
							val = "Sudden";
						elseif i==4 then
							val = "Stealth";
						elseif i==5 then
							val = "Hidden+";
						elseif i==6 then
							val = "Sudden+";
						elseif i==7 then
							val = "Hidden+&Sudden+";
						else
							val = "Visible";
						end
						setenv("AppearancePlus"..pName,val)
						SaveAppearancePlusValueForPlayer(PlayerUID,val)
						found = true
						break;
					end
				end
			end
		end,
	};
	setmetatable(t, t)
	return t
end




function ReadOrCreateScreenFilterValueForPlayer(PlayerUID, MyValue)
	local FilterFile = RageFileUtil:CreateRageFile()
	if FilterFile:Open("Save/ScreenFilter/"..PlayerUID..".txt",1) then 
		local str = FilterFile:Read();
		MyValue =tonumber(str);
	else
		FilterFile:Open("Save/ScreenFilter/"..PlayerUID..".txt",2);
		FilterFile:Write("0");
		MyValue=0;
	end
	FilterFile:Close();
	return MyValue;
end

function SaveScreenFilterValueForPlayer( PlayerUID, MyValue)
	-- local FilterFile = RageFileUtil:CreateRageFile();
	-- if FilterFile:Open("Save/ScreenFilter/"..PlayerUID..".txt",1) then 
		-- local str = FilterFile:Read();
		-- MyValue = tonumber(str);
	-- else
		-- FilterFile:Open("Save/ScreenFilter/"..PlayerUID..".txt",2);
		-- FilterFile:Write("0");
	-- end
	-- FilterFile:Close();
	
	local FilterFile2 = RageFileUtil:CreateRageFile();
	FilterFile2:Open("Save/ScreenFilter/"..PlayerUID..".txt",2);
	FilterFile2:Write(tostring(MyValue));
	FilterFile2:Close();
end


function OptionRowScreenFilterUseFile()
	local t = {
		Name="ScreenFilter",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { THEME:GetString('OptionNames','Off'), '0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1.0', },
		LoadSelections = function(self, list, pn)
			--local pName = ToEnumShortString(pn)
			--local filterValue = getenv("ScreenFilter"..pName)
			local filterValue = 0;
			local pf = PROFILEMAN:GetProfile(pn);
			local PlayerUID = "";
			
			if pf then 
				PlayerUID = pf:GetGUID()  
				filterValue = ReadOrCreateScreenFilterValueForPlayer(PlayerUID,filterValue);
			else
				PlayerUID = "UnknownPlayerUID"
				filterValue = 0;
			end
			
			if filterValue ~= nil then
				local val = scale(tonumber(filterValue),0,1,1,#list )
				list[val] = true
			else
				--setenv("ScreenFilter"..pName,0)
				SaveScreenFilterValueForPlayer(PlayerUID,0)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local found = false
			local PlayerUID = "";
			local pf = PROFILEMAN:GetProfile(pn);
			
			if pf then 
				PlayerUID = pf:GetGUID()  
			else
				PlayerUID = "UnknownPlayerUID"
			end
			
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = scale(i,1,#list,0,1)
						setenv("ScreenFilter"..pName,val)
						SaveScreenFilterValueForPlayer(PlayerUID,val)
						found = true
					end
				end
			end
		end,
	};
	setmetatable(t, t)
	return t
end



-- protiming
function OptionRowProTiming()
	local t = {
		Name = "ProTiming",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = {
			THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionNames','On')
		},
		LoadSelections = function(self, list, pn)
			if GetUserPrefB("UserPrefProtiming" .. ToEnumShortString(pn)) then
				local bShow = GetUserPrefB("UserPrefProtiming" .. ToEnumShortString(pn))
				if bShow then
					list[2] = true
				else
					list[1] = true
				end
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local bSave = list[2] and true or false
			SetUserPref("UserPrefProtiming" .. ToEnumShortString(pn), bSave)
		end
	}
	setmetatable(t, t)
	return t
end

-- notetype
function OptionRowNoteType()
	local t = {
		Name = "NoteType",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = {
			THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionNames','On')
		},
		LoadSelections = function(self, list, pn)
			if GetUserPrefB("UserPrefNoteType" .. ToEnumShortString(pn)) then
				local bShow = GetUserPrefB("UserPrefNoteType" .. ToEnumShortString(pn))
				if bShow then
					list[2] = true
				else
					list[1] = true
				end
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local bSave = list[2] and true or false
			SetUserPref("UserPrefNoteType" .. ToEnumShortString(pn), bSave)
		end
	}
	setmetatable(t, t)
	return t
end

function UserPrefGameplayShowScore()
	local t = {
		Name = "UserPrefGameplayShowScore",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {
			THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionNames','On')
		},
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefGameplayShowScore") ~= nil then
				if GetUserPrefB("UserPrefGameplayShowScore") then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("UserPrefGameplayShowScore", false)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[2] and true or false
			WritePrefToFile("UserPrefGameplayShowScore", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t
end

--GameplayShowCalories
function UserPrefGameplayShowCalories()
	local t = {
		Name = "UserPrefGameplayShowCalories",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {
			THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionNames','On')
		},
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefGameplayShowCalories") ~= nil then
				if GetUserPrefB("UserPrefGameplayShowCalories") then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("UserPrefGameplayShowCalories", false)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[2] and true or false
			WritePrefToFile("UserPrefGameplayShowCalories", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t
end

--GameplayShowFastSlow
function UserPrefGameplayShowFastSlow()
	local t = {
		Name = "UserPrefGameplayShowFastSlow",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {
			THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionNames','On')
		},
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefGameplayShowFastSlow") ~= nil then
				if GetUserPrefB("UserPrefGameplayShowFastSlow") then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("UserPrefGameplayShowFastSlow", true)
				list[2] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[2] and true or false
			WritePrefToFile("UserPrefGameplayShowFastSlow", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t
end


function UserPrefGameplayShowStepsDisplay()
	local t = {
		Name = "UserPrefGameplayShowStepsDisplay",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {
			THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionNames','On')
		},
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefGameplayShowStepsDisplay") ~= nil then
				if GetUserPrefB("UserPrefGameplayShowStepsDisplay") then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("UserPrefGameplayShowStepsDisplay", false)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[2] and true or false
			WritePrefToFile("UserPrefGameplayShowStepsDisplay", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t
end

function UserPrefShowLotsaOptions()
	local t = {
		Name = "UserPrefShowLotsaOptions",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Many','Few' },
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefShowLotsaOptions") ~= nil then
				if GetUserPrefB("UserPrefShowLotsaOptions") then
					list[1] = true
				else
					list[2] = true
				end
			else
				WritePrefToFile("UserPrefShowLotsaOptions", false)
				list[2] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[1] and true or false
			WritePrefToFile("UserPrefShowLotsaOptions", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t);
	return t
end

function GetDefaultOptionLines()
	local LineSets = { -- none of these include characters yet.
		"1,8,14,2,3A,3B,4,5,6,R,7,9,10,11,12,13,16,SF,17", -- All
		"1,8,14,2,7,13,16,SF,17", -- DDR Essentials ( no turns, fx )
	};
	local function IsExtra()
		if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
			return true
		else
			return false
		end
	end
	
	local function CheckCharacters(mods)
		if CHARMAN:GetCharacterCount() > 0 then
			return mods .. ",18" --TODO: Better line name.
		end
		return mods
	end
	
	modLines = LineSets[2]
	
	if not IsExtra() then
		modLines = GetUserPrefB("UserPrefShowLotsaOptions")
			and LineSets[1] or LineSets[2]
	end
	
	return CheckCharacters(modLines)
end

function UserPrefAutoSetStyle()
	local t = {
		Name = "UserPrefAutoSetStyle",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {
			THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionNames','On')
		},
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefAutoSetStyle") ~= nil then
				if GetUserPrefB("UserPrefAutoSetStyle") then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("UserPrefAutoSetStyle", false)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[2] and true or false
			WritePrefToFile("UserPrefAutoSetStyle", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" } )
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t
end

function UserPrefNotePosition()
	local t = {
		Name = "UserPrefNotePosition",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Normal','Lower' },
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefNotePosition") ~= nil then
				if GetUserPrefB("UserPrefNotePosition") then
					list[1] = true
				else
					list[2] = true
				end
			else
				WritePrefToFile("UserPrefNotePosition", false)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[1] and true or false
			WritePrefToFile("UserPrefNotePosition", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t
end

function UserPrefLongFail()
	local t = {
		Name = "UserPrefLongFail",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Short','Long' },
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefLongFail") ~= nil then
				if GetUserPrefB("UserPrefLongFail") then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("UserPrefLongFail", false)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[2] and true or false
			WritePrefToFile("UserPrefLongFail", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" } )
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t
end

function UserPrefComboOnRolls()
	local t = {
		Name = "UserPrefComboOnRolls",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {
			THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionNames','On')
		},
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefComboOnRolls") ~= nil then
				if GetUserPrefB("UserPrefComboOnRolls") then
					list[2] = true;
				else
					list[1] = true;
				end;
			else
				WritePrefToFile("UserPrefComboOnRolls",false);
				list[1] = true;
			end;
		end,
		SaveSelections = function(self, list, pn)
			local val = list[2] and true or false
			WritePrefToFile("UserPrefComboOnRolls", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t
end

function UserPrefFlashyCombo()
	local t = {
		Name = "UserPrefFlashyCombo",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {
			THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionNames','On')
		},
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefFlashyCombo") ~= nil then
				if GetUserPrefB("UserPrefFlashyCombo") then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("UserPrefFlashyCombo", false)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[2] and true or false
			WritePrefToFile("UserPrefFlashyCombo", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t
end

function UserPrefComboUnderField()
	local t = {
		Name = "UserPrefComboUnderField",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {
			THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionNames','On')
		},
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefComboUnderField") ~= nil then
				if GetUserPrefB("UserPrefComboUnderField") then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("UserPrefComboUnderField", true)
				list[2] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[2] and true or false
			WritePrefToFile("UserPrefComboUnderField", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t;
end

function UserPrefFancyUIBG()
	local t = {
		Name = "UserPrefFancyUIBG",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {
			THEME:GetString('OptionNames','On'),
			THEME:GetString('OptionNames','Off')
		},
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefFancyUIBG") ~= nil then
				if GetUserPrefB("UserPrefFancyUIBG") then
					list[1] = true
				else
					list[2] = true
				end
			else
				WritePrefToFile("UserPrefFancyUIBG", true)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[1] and true or false
			WritePrefToFile("UserPrefFancyUIBG", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t
end

function UserPrefTimingDisplay()
	local t = {
		Name = "UserPrefTimingDisplay",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {
			THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionNames','On')
		},
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefTimingDisplay") ~= nil then
				if GetUserPrefB("UserPrefTimingDisplay") then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("UserPrefTimingDisplay", true)
				list[2] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[2] and true or false
			WritePrefToFile("UserPrefTimingDisplay", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t
end

-- Target Score
function FirstReMIX_TargetScore()
	local t = {
		Name = "FirstReMIX_TargetScore",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { THEME:GetString('OptionNames','Off'),THEME:GetString('OptionNames','Machine'),THEME:GetString('OptionNames','Personal') },
		LoadSelections = function(self, list, pn)
			local pname = ToEnumShortString(pn);
			local profileGUID = PROFILEMAN:GetProfile(pn):GetGUID();
			if PROFILEMAN:IsPersistentProfile(pn) then
				if ReadPrefFromFile("FirstReMIX_TargetScore_"..profileGUID) ~= nil then
					if GetUserPref("FirstReMIX_TargetScore_" .. profileGUID)=='off' then
						list[1] = true
					elseif GetUserPref("FirstReMIX_TargetScore_" .. profileGUID)=='machine' then
						list[2] = true
					elseif GetUserPref("FirstReMIX_TargetScore_" .. profileGUID)=='personal' then
						list[3] = true
					end						
				else
					WritePrefToFile("FirstReMIX_TargetScore_"..profileGUID, 'off');
					list[1] = true
				end;
			else
				if ReadPrefFromFile("FirstReMIX_TargetScore_" .. pname) ~= nil then
					if GetUserPref("FirstReMIX_TargetScore_" .. pname)=='off' then
						list[1] = true
					elseif GetUserPref("FirstReMIX_TargetScore_" .. pname)=='machine' then
						list[2] = true
					elseif GetUserPref("FirstReMIX_TargetScore_" .. pname)=='personal' then
						list[3] = true
					end
				else
					WritePrefToFile("FirstReMIX_TargetScore_" .. pname, 'off')
					list[1] = true
				end
			end;
		end,
		SaveSelections = function(self, list, pn)
			local val;
			local pname = ToEnumShortString(pn);
			local profileGUID = PROFILEMAN:GetProfile(pn):GetGUID();
			if list[1] then
				val='off';
			elseif list[2] then
				val='machine';
			elseif list[3] then
				val='personal';
			end;
			if PROFILEMAN:IsPersistentProfile(pn) then
				WritePrefToFile("FirstReMIX_TargetScore_"..profileGUID, val);
			else
				WritePrefToFile("FirstReMIX_TargetScore_"..pname, val);
			end;
		end
	}
	setmetatable(t, t)
	return t
end

-- Target Score (no profile)
function FirstReMIX_TargetScore_NoProfile()
	local t = {
		Name = "FirstReMIX_TargetScore_NoProfile",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { THEME:GetString('OptionNames','Off'),THEME:GetString('OptionNames','On')},
		LoadSelections = function(self, list, pn)
			local pname = ToEnumShortString(pn);
			if ReadPrefFromFile("FirstReMIX_TargetScore_" .. pname) ~= nil then
				if GetUserPref("FirstReMIX_TargetScore_" .. pname)=='off' then
					list[1] = true
				elseif GetUserPref("FirstReMIX_TargetScore_" .. pname)=='machine' then
					list[2] = true
				elseif GetUserPref("FirstReMIX_TargetScore_" .. pname)=='personal' then
					list[2] = true
				end
			else
				WritePrefToFile("FirstReMIX_TargetScore_" .. pname, 'off')
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val;
			local pname = ToEnumShortString(pn);
			if list[1] then
				val='off';
			elseif list[2] then
				val='machine';
			end;
			WritePrefToFile("FirstReMIX_TargetScore_"..pname, val);
		end
	}
	setmetatable(t, t)
	return t
end

--[[ end option rows ]]
