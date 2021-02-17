local glow = Def.ActorFrame{}
local cursor = Def.ActorFrame{};
local diff = Def.ActorFrame{};

for i=1,2 do
	cursor[#cursor+1] = Def.Sprite{
		Texture=THEME:GetPathG("","_shared/cursor"),
		InitCommand=function(s) s:x(i==1 and -114 or 114):zoom(0.6):rotationy(i==2 and 180 or 0) end,
		SetMessageCommand=function(s,p)
			if p.Index then
				s:visible(p.HasFocus)
				if p.HasFocus then
					s:bounce():effectmagnitude(i==1 and 12 or -12,0,0):effectperiod(1)
				else
					s:stopeffect()
				end
			end
		end
	};
end

for _,pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	glow[#glow+1] = loadfile(THEME:GetPathG("MusicWheelItem","Song NormalPart/glow.lua"))(pn)..{
		InitCommand=function(s) s:x(pn==PLAYER_1 and -59 or 65):zoomy(1.1) end,
	};
	diff[#diff+1] = loadfile(THEME:GetPathG("MusicWheelItem","Song NormalPart/diff.lua"))(pn)..{
		InitCommand=function(s) s:xy(pn==PLAYER_1 and -74 or 74,-36) end,
	};
end

return Def.ActorFrame{
	SetMessageCommand=function(self, params)
		if params.Index ~= nil then
			local index = params.Index;

			if index%3 == 0 then
				self:x(-300):y(107);
			elseif index%3 == 1 then
				self:x(0):y(0);
			else
				self:x(300):y(-107);
			end
			self:zoom(params.HasFocus and 2 or 1.7);
		end
	end;
	Def.Sprite{
		Texture=ddrgame.."bg01",
	};
	Def.Sprite{
		Name="Banner",
		InitCommand=function(s) s:xy(3,-8) end,
		SetMessageCommand=function(s,p)
			local song = p.Song;
			if song then
				s:_LoadSCJacket(song)
			end
			s:setsize(104,104)
		end,
	};
	Def.ActorFrame{
		InitCommand=function(s) s:y(68) end,
		Def.Quad{
			InitCommand=function(s)
				s:setsize(175,21):diffuse(Color.Black)
			end,
		};
		Def.BitmapText{
			Font="_helveticaneuelt w1g 75 bd 24px",
			InitCommand=function(s) s:zoom(0.6):maxwidth(260):diffuse(Color.White):strokecolor(color("0.15,0.15,0.0,0.9")) end,
			SetMessageCommand=function(self,params)
				local song = params.Song
				if song then
					self:settext(song:GetDisplayFullTitle())
				end
			end;
		};
	};
	Def.ActorFrame{
		Name="Clear Bases",
		InitCommand=function(s) s:y(-6) end,
		Def.Sprite{
			Texture=ddrgame.."clearbase",
			InitCommand=function(s) s:halign(0):x(57):zoomx(0.75) end,
		};
		Def.Sprite{
			Texture=ddrgame.."clearbase",
			InitCommand=function(s) s:halign(0):x(-51):zoomx(-0.75) end,
		};
		glow;
	};
	Def.ActorFrame{
		Name="Highlights",
		InitCommand=function(s) s:x(-4) end,
		SetMessageCommand=function(self, params)
			if params.Index ~= nil then
				self:visible( params.HasFocus );
			end
		end;
		Def.Sprite{
			Texture=ddrgame.."card hl",
			InitCommand=function(s) s:diffuseramp()
				:effectcolor1(color("1,1,1,0.2")):effectcolor2(color("1,1,1,1")):effectperiod(0.5)
			end,
		};
		Def.ActorFrame{
			Name="cardcursor",
			InitCommand=function(s) s:diffuseramp():effectcolor1(color("1,1,1,0")):effectcolor2(color("1,1,1,1")):effectperiod(0.5) end,
			Def.Sprite{
				Texture=ddrgame.."card cursor.png",
				InitCommand=function(s) s:thump(1):effectmagnitude(1.1,1,0):effectperiod(0.5) end,
			};
		};
	};
	--[[Def.Sprite{
		Texture="New",
		InitCommand=function(s) s:visible(false):xy(58,-52):halign(1,1) end,
		SetMessageCommand=function(s,p)
			local song = p.Song
			if song then
				s:visible(PROFILEMAN:IsSongNew(song))
			end
		end,
	};]]
	diff;
	cursor;
}