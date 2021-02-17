local lang = "en";
if THEME:GetCurLanguage() == "ja" then
	lang = "jp";
end;
local Crstext = THEME:GetString("MusicWheel","CustomItemCrsText");

----------------------------------------------------------------------------
--ReadPaneControl
function ReadOrCreatePaneControlForPlayerSide(PlayerUID)
	local PaneControlFile = RageFileUtil:CreateRageFile()
	local MyValue2 = "";
	if PaneControlFile:Open("Save/PaneControl/"..PlayerUID.."_PlayerSide.txt",1) then 
		MyValue2 = PaneControlFile:Read();
	else
		PaneControlFile:Open("Save/PaneControl/"..PlayerUID.."_PlayerSide.txt",2);
		PaneControlFile:Write("ClosePanes");
		MyValue2="";
	end
	PaneControlFile:Close();
	return MyValue2;
end


function ReadOrCreatePaneControlForAnotherSide(PlayerUID)
	local PaneControlFile = RageFileUtil:CreateRageFile()
	local MyValue2 = "";
	if PaneControlFile:Open("Save/PaneControl/"..PlayerUID.."_AnotherSide.txt",1) then 
		MyValue2 = PaneControlFile:Read();
		
	else
		PaneControlFile:Open("Save/PaneControl/"..PlayerUID.."_AnotherSide.txt",2);
		PaneControlFile:Write("ClosePanesA");
		MyValue2="";
	end
	PaneControlFile:Close();
	return MyValue2;
end

--SavePaneControl
function SavePaneControl( PlayerUID, MyValue, Mode)
	if Mode == "PlayerSide" then
		local PaneControlFile3 = RageFileUtil:CreateRageFile();
		PaneControlFile3:Open("Save/PaneControl/"..PlayerUID.."_PlayerSide.txt",2);
		PaneControlFile3:Write(tostring(MyValue));
		PaneControlFile3:Close();
	elseif Mode == "AnotherSide" then
		local PaneControlFile4 = RageFileUtil:CreateRageFile();
		PaneControlFile4:Open("Save/PaneControl/"..PlayerUID.."_AnotherSide.txt",2);
		PaneControlFile4:Write(tostring(MyValue));
		PaneControlFile4:Close();
		
	end
end;
----------------------------------------------------------------------------

local Jacket = Def.ActorFrame{
	Def.Sprite{
		SetCommand=function(s)
			local song = GAMESTATE:GetCurrentSong()
			local mw = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
			if not mw then return end
			if song then
				s:_LoadSCJacket(song)
				s:diffusealpha(1)
			else
				if mw:GetSelectedType('WheelItemDataType_Section') then
					if mw:GetSelectedSection() ~= "" then
						s:Load(jacketset(s)):diffusealpha(1)
					else
						s:diffusealpha(0)
					end
				else
					s:diffusealpha(0)
				end
			end
			s:setsize(150,150)
		end
	};
}

local doors = Def.ActorFrame{}
local diff = Def.ActorFrame{}
local score = Def.ActorFrame{}

if(GAMESTATE:GetCurrentStage()=='Stage_1st') or GAMESTATE:GetCurrentStageIndex()==0 or (GAMESTATE:HasEarnedExtraStage() and GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2()) then
	doors[#doors+1] = LoadActor("../_doors.lua")..{
		BeginCommand=function(s) s:playcommand("Show") end,
		OnCommand=function(s) 
			s:queuecommand("AnimOff")
		end,
	};
else
	doors[#doors+1] = Def.Actor{
		OnCommand=function(s) s:sleep(0.4):playcommand("Play") end,
		PlayCommand=function(s)
			SOUND:PlayOnce(THEME:GetPathS("","_swooshInstructions"))
		end,
	};
end;

local detail = Def.ActorFrame{};
local score = Def.ActorFrame{}
local Radar = Def.ActorFrame{};
local NoPane = Def.ActorFrame{};

for _,pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	diff[#diff+1] = loadfile(THEME:GetPathB("ScreenSelectMusic","overlay/Difficulty"))(pn)..{
		InitCommand=function(s) s:xy(pn==PLAYER_1 and SCREEN_LEFT+148 or SCREEN_RIGHT-148,_screen.cy-132) end,
	};
	Radar[#Radar+1] = loadfile(THEME:GetPathB("ScreenSelectMusic","overlay/RadarHandler"))(pn)..{
		InitCommand=function(s) s:xy(pn==PLAYER_1 and SCREEN_LEFT+128 or SCREEN_RIGHT-130,_screen.cy+52) end,
	}
	score[#score+1] = loadfile(THEME:GetPathB("ScreenSelectMusic","overlay/Scores/default.lua"))(pn)..{
		InitCommand=function(s) s:xy(pn==PLAYER_1 and SCREEN_LEFT+170 or SCREEN_RIGHT-170,_screen.cy+80) end,
		OnCommand=function(s)
			if GAMESTATE:IsPlayerEnabled(pn) then
				local PlayerUID = PROFILEMAN:GetProfile(pn):GetGUID();
				if ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes3" then
					s:addx(pn==PLAYER_1 and -500 or 500):sleep(0.5):decelerate(0.5):addx(pn==PLAYER_1 and 500 or -500)
					s:linear(0.5);
					s:diffusealpha(1);
				elseif ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes1" or ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="ClosePanes" then
					s:diffusealpha(0);
				end;
			end;
		end,
		CodeMessageCommand=function(self,params)
			local player = params.PlayerNumber
			if player == pn then
				if params.Name=="OpenPanes3"then
					self:linear(0.15);
					self:diffusealpha(1);
				elseif params.Name=="ClosePanes" or params.Name=="OpenPanes1" then
					self:linear(0.15);
					self:diffusealpha(0);
				end;
			end
			local style = GAMESTATE:GetCurrentStyle():GetStyleType()
			local PlayerUID = PROFILEMAN:GetProfile(player):GetGUID();
			if player==pn then
				if params.Name=="OpenPanes1" then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="OpenPanes3"then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="ClosePanes" 
				then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				end;
			end;
		end,
		CurrentSongChangedMessageCommand=function(s)
			if GAMESTATE:GetCurrentSong() then
				s:visible(true)
			else
				s:visible(false)
			end
		end,
	};
	NoPane[#NoPane+1] = loadfile(THEME:GetPathB("ScreenSelectMusic","overlay/NoPane/default.lua"))(pn)..{
		InitCommand=function(s)
			s:xy(pn==PLAYER_1 and SCREEN_LEFT+110 or SCREEN_RIGHT-110,_screen.cy+250)
		end,
		OnCommand=function(s)
			if GAMESTATE:IsPlayerEnabled(pn) then
				local PlayerUID = PROFILEMAN:GetProfile(pn):GetGUID();
				if ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="ClosePanes" then
					s:addx(pn==PLAYER_1 and -500 or 500):sleep(0.5):decelerate(0.5):addx(pn==PLAYER_1 and 500 or -500)
					s:linear(0.5);
					s:diffusealpha(1);
				elseif ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes1" or ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes3" then
					s:diffusealpha(0);
				end;
			end;
		end,
		CodeMessageCommand=function(self,params)
			local player = params.PlayerNumber
			if player == pn then
				if params.Name=="ClosePanes"then
					self:linear(0.15);
					self:diffusealpha(1);
				elseif params.Name=="OpenPanes3" or params.Name=="OpenPanes1" then
					self:linear(0.15);
					self:diffusealpha(0);
				end;
			end
			local style = GAMESTATE:GetCurrentStyle():GetStyleType()
			local PlayerUID = PROFILEMAN:GetProfile(player):GetGUID();
			if player==pn then
				if params.Name=="OpenPanes1" then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="OpenPanes3"then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="ClosePanes" then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				end;
			end;
		end,
	};
	detail[#detail+1] = loadfile(THEME:GetPathB("ScreenSelectMusic","overlay/detail/default.lua"))(pn)..{
		InitCommand=function(s)
			s:xy(pn==PLAYER_1 and SCREEN_LEFT+160 or SCREEN_RIGHT-160,_screen.cy+230)
		end,
		OnCommand=function(s)
			if GAMESTATE:IsPlayerEnabled(pn) then
				local PlayerUID = PROFILEMAN:GetProfile(pn):GetGUID();
				if ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes1" then
					s:addx(pn==PLAYER_1 and -500 or 500):sleep(0.5):decelerate(0.5):addx(pn==PLAYER_1 and 500 or -500)
					s:linear(0.5);
					s:diffusealpha(1);
				elseif ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes3" or ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="ClosePanes" then
					s:diffusealpha(0);
				elseif ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes2" then
					if GAMESTATE:IsCourseMode() == false then
						s:diffusealpha(0);
					end
				end;
			end;
		end,
		CodeMessageCommand=function(self,params)
			local player = params.PlayerNumber
			if player == pn then
				if params.Name=="OpenPanes1"then
					self:linear(0.15);
					self:diffusealpha(1);
				elseif params.Name=="ClosePanes" or params.Name=="OpenPanes3" or params.Name=="OpenPanes2" then
					self:linear(0.15);
					self:diffusealpha(0);
				elseif  params.Name=="OpenPanes2" then
					if GAMESTATE:IsCourseMode() == false then
						self:linear(0.15);
						self:diffusealpha(0);
					end
				end;
			end
			local style = GAMESTATE:GetCurrentStyle():GetStyleType()
			local PlayerUID = PROFILEMAN:GetProfile(player):GetGUID();
			if player==pn then
				if params.Name=="OpenPanes1" then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="OpenPanes2"then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="OpenPanes3"then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="ClosePanes" 
				then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				end;
			end;
		end,
		CurrentSongChangedMessageCommand=function(s)
			if GAMESTATE:GetCurrentSong() then
				s:visible(true)
			else
				s:visible(false)
			end
		end,
	};
end

local TwoPart = Def.ActorFrame{
	StartSelectingStepsMessageCommand=function(s) s:AddChildFromPath(THEME:GetPathB("ScreenSelectMusic","overlay/TwoPartDiff")) end,
	SongUnchosenMessageCommand=function(s) 
		s:sleep(0.2):queuecommand("Remove")
	end,
	RemoveCommand=function(s) s:RemoveChild("TwoPartDiff") end,
};

return Def.ActorFrame{
	OffCommand=function(s) s:finishtweening() end,
	TwoPart;
	loadfile(THEME:GetPathB("ScreenSelectMusic","overlay/deco/Info"))()..{
		OnCommand=function(s) s:diffusealpha(0):sleep(0.4):linear(0.05):diffusealpha(0.75):linear(0.1):diffusealpha(0.25):linear(0.1):diffusealpha(1) end,
	};
	loadfile(THEME:GetPathB("ScreenSelectMusic","overlay/deco/mode"))()..{
		OnCommand=function(s) s:diffusealpha(0):sleep(0.4):linear(0.05):diffusealpha(0.75):linear(0.1):diffusealpha(0.25):linear(0.1):diffusealpha(1) end,
	};
	diff;
	detail;
	score;
	Radar;
	doors;
	NoPane;
}