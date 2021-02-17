local cursor = Def.ActorFrame{}
local grade = Def.ActorFrame{};
local diff = Def.ActorFrame{}

for i=1,2 do
	cursor[#cursor+1] = Def.Sprite{
		Texture=THEME:GetPathG("MusicWheelItem","Song NormalPart/cursor"),
		InitCommand=function(s)
			s:x(i==1 and -200 or 200):rotationy(i==2 and 180 or 0)
		end,
		SetMessageCommand=function(s,p)
			if p.Index then
				s:visible(p.HasFocus)
				if p.HasFocus then
					s:bounce():effectmagnitude(i==1 and 12 or -12,0,0):effectperiod(0.3)
				else
					s:stopeffect()
				end
			end
		end
	}
end
for _,pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	grade[#grade+1] = Def.ActorFrame{
		LoadActor("grade.lua",pn)
	};
	diff[#diff+1] = Def.ActorFrame{
		LoadActor("diff.lua",pn)..{
			InitCommand=function(s) s:xy(pn==PLAYER_1 and -136 or 136,-62) end,
		}
	};
end

return Def.ActorFrame{
	SetMessageCommand=function(s,p)
		local index = p.Index
		if index then
			if index%3 == 0 then
				s:xy(-300,105)
			elseif index%3 == 1 then
				s:xy(0,0)
			else
				s:xy(300,-105)
			end
			s:zoom(p.HasFocus and 1.3 or 1)
		end
	end,
	Def.ActorFrame{
		InitCommand=function(s) s:diffuseramp():effectcolor1(color("1,1,1,0"))
			:effectcolor2(color("1,1,1,0.75")):effectclock('beatnooffset')
		end,
		Def.Sprite{
			Texture="bright",
			SetMessageCommand=function(s,p)
				if p.Index then
					s:visible(p.HasFocus)
				end
				s:thump(1):effectmagnitude(0.95,0.98,0):effectclock('beatnooffset')
			end,
		};
	};
	Def.Sprite{ Texture="bg01",};
	Def.Sprite{
		Texture="inner",
		SetMessageCommand=function(s,p)
			if p.Index then
				s:visible(p.HasFocus)
			end
			s:diffuseramp():effectcolor1(color("1,1,1,0"))
			:effectcolor2(color("1,1,1,0.75")):effectclock('beatnooffset')
		end,
	};
	Def.Sprite{
		InitCommand=function(s) s:y(-4) end,
		SetMessageCommand=function(s,p)
			local song  = p.Song
			if song then
				if song:HasJacket() then
					s:Load(song:GetJacketPath())
				elseif song:HasBanner() then
					s:Load(song:GetBannerPath())
				elseif song:HasBackground() then
					s:Load(song:GetBackgroundPath())
				else
					s:Load(THEME:GetPathG("","Common fallback jacket"))
				end
				s:scaletoclipped(180,180)
			end
		end,
	};
	Def.BitmapText{
		Font="_open sans semibold 24px",
		InitCommand=function(s) s:y(123):maxwidth(235):DiffuseAndStroke(Color.White,color("0.15,0.15,0.0,0.9")) end,
		SetMessageCommand=function(s,p)
			local song = p.Song
			local index = p.Index
			if song then
				s:settext(song:GetDisplayFullTitle())
			else
				s:settext("")
			end
		end,
	};
	cursor;
	Def.Sprite{
		Texture="bgNew",
		SetMessageCommand=function(s,p)
			s:visible(false)
			if p.Song then
				if PROFILEMAN:IsSongNew(p.Song) then
					s:visible(true)
				end
			end
		end
	};
	grade;
	diff;
}