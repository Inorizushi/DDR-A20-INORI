local playMode = GAMESTATE:GetPlayMode()
if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
	curStage = playMode;
end;
local sStage = GAMESTATE:GetCurrentStage();
local tRemap = {
	Stage_1st		= 1,
	Stage_2nd		= 2,
	Stage_3rd		= 3,
	Stage_4th		= 4,
	Stage_5th		= 5,
	Stage_6th		= 6,
};

if tRemap[sStage] == PREFSMAN:GetPreference("SongsPerPlay") then
	sStage = "Stage_Final";
else
	sStage = sStage;
end;

local t = Def.ActorFrame{}; 
local song = GAMESTATE:GetCurrentSong();


function isExtraSavior(STitle)
	
	return false;
	
end;

function isExtraExclusive(STitle)

	return false;

end;

--Sound
t[#t+1] = Def.ActorFrame {
	LoadActor("../_door_close") .. {
		OnCommand=cmd(sleep,0.0;queuecommand,"Play");
		PlayCommand=cmd(play);
	};
	LoadActor("SoundStage") .. {};
};


--Wyvern-D

local arrow_st=1.2;
local dt = 0.1;

t[#t+1] = Def.ActorFrame {

	LoadActor( "../_door_Stagein/bg" )..{
		InitCommand = cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffusealpha,0;linear,0.1;diffusealpha,1);
	};

	LoadActor( "../_door_Silver/back_silver2" )..{
		--OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
		OnCommand = function(self)
		
			self:zoom(1.3);
			self:x(SCREEN_CENTER_X);
			self:y(SCREEN_CENTER_Y);
			self:diffusealpha(0);
				
			self:sleep(dt);
			self:linear(0.2);
				
				self:zoom(1.2);
				self:diffusealpha(1);
				
			--self:sleep(dt);
			self:decelerate(1);
				
				self:zoom(1);
			end;
		};
		
		LoadActor( "../_door_Silver/bs_add" )..{
			--OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
			OnCommand = function(self)
			
				self:blend('BlendMode_Add');
				self:zoom(1.3);
				self:x(SCREEN_CENTER_X);
				self:y(SCREEN_CENTER_Y);
				self:diffusealpha(0);
				self:sleep(dt);
				self:linear(0.2);
				self:zoom(1.2);
				self:diffusealpha(0.4);
				
				self:decelerate(1);
				self:zoom(1);
				self:diffusealpha(0);
			end;
		};


		--White flash
		LoadActor( "../_door/whiteflash" )..{
			OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomx,0;sleep,dt;sleep,0.3;linear,0.134;zoomx,1;linear,0.099;zoom,3);
		};
		
		LoadActor( "../ScreenGameplay out/ring_light" )..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-200;zoom,2.5);
	OnCommand=function(self)
		self:diffusealpha(0);
		self:zoom(3);
		self:sleep(dt);
		self:linear(0.264);
		self:diffusealpha(0.15);
		self:zoom(2.5);
		self:blend('BlendMode_Add');
		self:linear(5);
		self:rotationz(-100);
	end;
};

LoadActor( "../ScreenGameplay out/particle" )..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,0.2);
	OnCommand=function(self)
		self:blend('BlendMode_Add');
		self:diffusealpha(0);
		self:sleep(dt);
		self:linear(0.7);
		self:addx(100);
		self:addy(-60);
		self:diffusealpha(0.6);
		self:linear(0.7);
		self:addx(100);
		self:addy(-60);
		self:diffusealpha(0);
	end;
};
LoadActor( "../ScreenGameplay out/particle" )..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,0.2);
	OnCommand=function(self)
		self:blend('BlendMode_Add');
		self:diffusealpha(0);
		self:sleep(dt);
		self:linear(0.7);
		self:addx(-60);
		self:addy(-100);
		self:diffusealpha(0.6);
		self:linear(0.7);
		self:addx(-60);
		self:addy(-100);
		self:diffusealpha(0);
	end;
};
LoadActor( "../ScreenGameplay out/particle" )..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,0.2);
	OnCommand=function(self)
		self:blend('BlendMode_Add');
		self:diffusealpha(0);
		self:sleep(dt);
		self:linear(0.7);
		self:addx(100);
		self:addy(100);
		self:diffusealpha(0.6);
		self:linear(0.7);
		self:addx(100);
		self:addy(100);
		self:diffusealpha(0);
	end;
};

	LoadActor("lines") ..{
		--OnCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,0.7;sleep,arrow_st+0.7;diffusealpha,0.6;decelerate,0.03;zoom,0.95,diffusealpha,0.6;blend,('BlendMode_Add'));
		InitCommand = function(self)
			self:x(SCREEN_CENTER_X);
			self:y(SCREEN_CENTER_Y);
			self:rotationz(0);
			self:zoom(0.3);
			self:blend('BlendMode_Add');
			self:diffusealpha(0);
		end;
		OnCommand=function(self)
			self:sleep(arrow_st-0.6);
			self:decelerate(0.6);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(0.4);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(0.4);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(0.4);
			self:decelerate(0.2);
			self:zoom(1.02);
		end;
	};

	LoadActor( "../_door_Silver/door_silver_1a" )..{
		--OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
		OnCommand = function(self)
			self:zoom(2.3);
			self:x(SCREEN_CENTER_X);
			self:y(SCREEN_CENTER_Y);
			self:sleep(dt);
			self:decelerate(0.8);
			self:zoom(1);
			self:decelerate(0.4);
			self:addy(-20);
		end;
	};
	LoadActor( "../_door_Silver/door_silver_1b" )..{
		--OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
		OnCommand = function(self)
			self:zoom(2.3);
			self:x(SCREEN_CENTER_X);
			self:y(SCREEN_CENTER_Y);
			self:sleep(dt);
			self:decelerate(0.8);
			self:zoom(1);
			self:diffusealpha(0.7);
			self:linear(0.3);
			self:diffusealpha(0);
		end;
	};
		LoadActor( "../_door_Silver/door_silver_1a" )..{
		--OnCommand=cmd(zoom,-1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
		OnCommand = function(self)
			self:zoom(-2.3);
			self:x(SCREEN_CENTER_X);
			self:y(SCREEN_CENTER_Y);
			self:sleep(dt);
			self:decelerate(0.8);
			self:zoom(-1);
			self:decelerate(0.4);
			self:addy(20);
		end;
	};
	LoadActor( "../_door_Silver/door_silver_1b" )..{
		--OnCommand=cmd(zoom,-1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
		OnCommand = function(self)
			self:zoom(-2.3);
			self:x(SCREEN_CENTER_X);
			self:y(SCREEN_CENTER_Y);
			self:sleep(dt);
			self:decelerate(0.8);
			self:zoom(-1);
			self:diffusealpha(0.7);
			self:linear(0.3);
			self:diffusealpha(0);
		end;
	};


	LoadActor( "../_door_Stagein/arrow" )..{
		InitCommand = function(self)
			self:x(SCREEN_CENTER_X);
			self:y(SCREEN_CENTER_Y);
			self:vertalign(bottom);
			self:rotationz(0);
			self:zoom(0.7);
			self:blend('BlendMode_Add');
		end;
		OnCommand=function(self)
			self:sleep(arrow_st-0.6);
			self:rotationz(0);
			self:decelerate(0.6);
			self:rotationz(720);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(1);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(1);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(1);
			self:decelerate(0.2);
			self:addy(-155);
			self:zoom(1);
		end;
	};
	LoadActor( "../_door_Stagein/arrow" )..{
		InitCommand = function(self)
			self:x(SCREEN_CENTER_X);
			self:y(SCREEN_CENTER_Y);
			self:vertalign(bottom);
			self:rotationz(90);
			self:zoom(0.7);
			self:blend('BlendMode_Add');
		end;
		OnCommand=function(self)
			self:sleep(arrow_st-0.6);
			self:rotationz(90+0);
			self:decelerate(0.6);
			self:rotationz(90+720);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(1);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(1);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(1);
			self:decelerate(0.2);
			self:addx(490);
			self:zoom(1);
		end;
	};
	LoadActor( "../_door_Stagein/arrow" )..{
		InitCommand = function(self)
			self:x(SCREEN_CENTER_X);
			self:y(SCREEN_CENTER_Y);
			self:vertalign(bottom);
			self:rotationz(180);
			self:zoom(0.7);
			self:blend('BlendMode_Add');
		end;
		OnCommand=function(self)
			self:sleep(arrow_st-0.6);
			self:rotationz(180+0);
			self:decelerate(0.6);
			self:rotationz(180+720);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(1);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(1);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(1);
			self:decelerate(0.2);
			self:addy(155);
			self:zoom(1);
		end;
	};
	LoadActor( "../_door_Stagein/arrow" )..{
		InitCommand = function(self)
			self:x(SCREEN_CENTER_X);
			self:y(SCREEN_CENTER_Y);
			self:vertalign(bottom);
			self:rotationz(270);
			self:zoom(0.7);
			self:blend('BlendMode_Add');
		end;
		OnCommand=function(self)
			self:sleep(arrow_st-0.6);
			self:rotationz(270+0);
			self:decelerate(0.6);
			self:rotationz(270+720);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(1);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(1);
			self:sleep(0.06);
			self:diffusealpha(0);
			self:sleep(0.06);
			self:diffusealpha(1);
			self:decelerate(0.2);
			self:addx(-490);
			self:zoom(1);
		end;
	};

};



--Default
t[#t+1] = Def.ActorFrame {
--Scanlines
	LoadActor("scanlines")..{
		InitCommand=cmd(Center;diffusealpha,0.5);
		OnCommand=cmd(zoom,1.8;sleep,0.033;linear,0.083;zoom,1.0);
	};
	LoadActor("scanlines")..{
		InitCommand=cmd(Center;diffusealpha,0.5);
		OnCommand=cmd(zoom,2;sleep,0.133;linear,0.083;zoom,1.0);
	};
--BlackBg
	--LoadActor("topbg") .. {
	--	OnCommand=cmd(zoom,2.125;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_TOP-2;sleep,1;diffusealpha,1;sleep,0.033;linear,0.083;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_TOP;);
	--};
	LoadActor("../_door_Stagein/doorside_base1") .. {
		OnCommand=cmd(zoom,1;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_TOP-40;sleep,1;diffusealpha,1;sleep,0.033;linear,0.133;zoom,1;x,SCREEN_CENTER_X;y,SCREEN_TOP+180;);
	};
	LoadActor("../_door_Stagein/doorside_line") .. {
		OnCommand=cmd(zoom,1;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_TOP-40;sleep,1;diffusealpha,0;sleep,0.033;linear,0.133;zoom,1;x,SCREEN_CENTER_X;y,SCREEN_TOP+180;accelerate,0.3;diffusealpha,1);
	};
	--LoadActor("glowtop") .. {
	--	OnCommand=cmd(zoom,2.125;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_TOP-2;sleep,1;diffusealpha,1;sleep,0.033;linear,0.083;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_TOP+84;);
	--};
	LoadActor("../_door_Stagein/doorside_base1") .. {
		OnCommand=cmd(zoom,-1;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+40;sleep,1;diffusealpha,1;sleep,0.033;linear,0.133;zoom,-1;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-180;);
	};
	LoadActor("../_door_Stagein/doorside_line") .. {
		OnCommand=cmd(zoom,-1;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+40;sleep,1;diffusealpha,0;sleep,0.033;linear,0.133;zoom,-1;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-180;accelerate,0.3;diffusealpha,1);
	};
	--LoadActor("bottombg") .. {
	--	OnCommand=cmd(zoom,2.125;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+7;sleep,1;diffusealpha,1;sleep,0.033;linear,0.083;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-76;);
	--};
	--LoadActor("topbar") .. {
	--	OnCommand=cmd(zoom,2.125;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_TOP+9;sleep,1;diffusealpha,1;sleep,0.033;linear,0.083;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_TOP+58;);
	--};
	--LoadActor("bottombar") .. {
	--	OnCommand=cmd(zoom,1.125;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-4;sleep,1;diffusealpha,1;sleep,0.033;linear,0.083;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-59;);
	--};
	--LoadActor("glowtop") .. {
	--	OnCommand=cmd(zoom,-1.125;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-4;sleep,1;diffusealpha,1;sleep,0.033;linear,0.083;zoom,-1.125;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-59;);
	--};
	--LoadActor("bottombar") .. {
	--	OnCommand=cmd(zoom,-1.125;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-4;sleep,1;diffusealpha,1;sleep,0.033;linear,0.083;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-99;);
	--};
	
	--[[
	
	LoadActor("lightsUpper") .. {
		OnCommand=cmd(diffusealpha,0;blend,Blend.Add;FullScreen;Center;sleep,1.034;linear,0.3;diffusealpha,1;diffuseshift;effectcolor1,color("1,1,1,1");effectcolor2,color("1,1,1,0.9");effectperiod,0.02);
	};
	LoadActor("lightsLower") .. {
		OnCommand=cmd(diffusealpha,0;blend,Blend.Add;FullScreen;Center;sleep,0.834;linear,0.3;diffusealpha,1;diffuseshift;effectcolor1,color("1,1,1,1");effectcolor2,color("1,1,1,0.7");effectperiod,0.03);
	};
	LoadActor("lightsUpper") .. {
		OnCommand=cmd(diffusealpha,0;blend,Blend.Add;FullScreen;Center;sleep,1.034;linear,0.3;diffusealpha,0.3);
	};
	LoadActor("lightsLower") .. {
		OnCommand=cmd(diffusealpha,0;blend,Blend.Add;FullScreen;Center;sleep,0.834;linear,0.3;diffusealpha,0.3);
	};
	
	]]--
	
};




t[#t+1] = Def.ActorFrame {
	--LoadActor("sidebar") .. {
	--	OnCommand=cmd(diffusealpha,0;x,SCREEN_RIGHT+59;y,SCREEN_CENTER_Y-12;sleep,1.034;diffusealpha,1;sleep,0.833;linear,0.083;zoom,1;x,SCREEN_RIGHT-78;y,SCREEN_CENTER_Y-18;);
	--};
	--LoadActor("sidebar") .. {
	--	OnCommand=cmd(diffusealpha,0;x,SCREEN_LEFT-59;y,SCREEN_CENTER_Y-12;zoomx,-1;sleep,1.034;diffusealpha,1;sleep,0.833;linear,0.083;zoom,1;x,SCREEN_LEFT+78;y,SCREEN_CENTER_Y-18;zoomx,-1;);
	--};
	
};

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+166;zoom,1.7);
	LoadActor("jacket-bg")..{
		InitCommand=cmd(zoomy,0.0129;zoomx,1.3;diffusealpha,0;sleep,1.267+0.5;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.0645;addy,-8;sleep,0.017;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.1741;addy,-17;sleep,0.033;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.2806;addy,-17;zoomx,1.265;sleep,0.017;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.407;zoomx,1.245;addy,-17;sleep,0.017;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.527;addy,-18;zoomx,1.201;sleep,0.017;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.7;zoomx,1.126;addy,-25;sleep,0.034;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.790;zoomx,1.116;addy,-18;sleep,0.017;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.952;zoomx,1.066;addy,-25;sleep,0.017;diffusealpha,1;sleep,0.017;diffusealpha,0;);
	};
	
};
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+19;zoom,1.7);
	LoadActor("jacket-bg")..{
		InitCommand=cmd(diffusealpha,0;sleep,1.617+0.5;zoomy,1.033;zoomx,1.033;addy,-3;sleep,0.034;diffusealpha,1;sleep,0.017;diffusealpha,0;sleep,0.016;diffusealpha,1;sleep,0.018;diffusealpha,0;sleep,0.017;diffusealpha,1;sleep,0.016;diffusealpha,0;sleep,0.018;diffusealpha,1;sleep,0.017;diffusealpha,0;sleep,0.016;diffusealpha,1;sleep,0.018;diffusealpha,0;sleep,0.150;zoomx,1.72;zoomy,0.335;addy,98;diffusealpha,1;sleep,0.017;diffusealpha,0;sleep,0.017;);
	};	
};

--stage word
--[[
if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
	local STitle = song:GetDisplayFullTitle();
	--Extra Savior
		if isExtraSavior(STitle) then
			t[#t+1] = Def.ActorFrame {
				LoadActor("Savior")..{};
			};
		else
			--Extra Exclusive
			if isExtraExclusive(STitle) then
				t[#t+1] = Def.ActorFrame {
					LoadActor("Exclusive")..{};
				};
			else
				--Normal stage indicator
				t[#t+1] = Def.ActorFrame {
					--LoadActor("StageDisplay")..{};
				};
			end
		end
else

	--Normal stage indicator
	t[#t+1] = Def.ActorFrame {
		LoadActor("StageDisplay")..{};
	};


end
]]--

--Normal stage indicator
	t[#t+1] = Def.ActorFrame {
		LoadActor("StageDisplay")..{};
	};


--t[#t+1] = Def.Quad{
--	OnCommand=cmd(diffuse,color("#000000");Center;setsize,486,486;diffusealpha,0;zoom,1;sleep,1.9+0.5;linear,0.2;diffusealpha,1;zoom,1);
--	};
--song jacket--
t[#t+1] = Def.ActorFrame {
	OnCommand=cmd(playcommand,'Set';Center;diffusealpha,0;zoom,1;sleep,1.9+0.5;linear,0.2;diffusealpha,1;zoom,1;sleep,3;diffusealpha,1);
	Def.Sprite {
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			local course = GAMESTATE:GetCurrentCourse();
			if song then
				if song:HasJacket() then
					self:LoadBackground(song:GetJacketPath());
					self:setsize(480,480);
				elseif song:HasBanner() then
					self:LoadFromSongBanner(GAMESTATE:GetCurrentSong());
					self:setsize(480,480);
				else
					self:Load(THEME:GetPathG("","Common fallback jacket"));
					self:setsize(480,480);
				end;
			elseif course then
				
					self:LoadBackground(course:GetBannerPath());
					self:setsize(480,480);
			else
					self:Load(THEME:GetPathG("","Common fallback jacket"));
					self:setsize(480,480);
			end;
		end;
	};
};

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	LoadActor("jacket-wbg2")..{
		InitCommand=cmd(blend,'BlendMode_Add';diffusealpha,0;zoom,1.55*2;sleep,1.6+0.7;linear,0.01;diffusealpha,1;zoom,1.55*2;sleep,0.03;diffusealpha,1;zoom,1.85*2;sleep,0.1;accelerate,0.04;diffusealpha,0;zoom,2.55*2;);
	};	
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "con_label" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-96;sleep,1.25;linear,0.401;zoom,0.8;addy,4;sleep,0.216;linear,0.033;zoomx,3;zoomy,0);
	}
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "prog_bg" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-74;sleep,1.25;linear,0.401;zoom,0.8;sleep,0.216;linear,0.033;zoomx,3;zoomy,0);
	}
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "progbar" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-74;cropright,1;sleep,1.25;linear,0.401;zoom,0.8;cropright,0;sleep,0.216;linear,0.033;zoomx,3;zoomy,0);
	}
};

--stage word
if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
	local STitle = song:GetDisplayFullTitle();
	--Extra Savior
		if isExtraSavior(STitle) then
			t[#t+1] = Def.ActorFrame {
				LoadActor("Savior")..{};
			};
		elseif isExtraExclusive(STitle) then
				t[#t+1] = Def.ActorFrame {
					LoadActor("Exclusive")..{};
				};
		end
end


--White Flare

t[#t+1] = Def.ActorFrame {
	Def.Quad{
		OnCommand=cmd(Center;FullScreen;diffusecolor,Color.White;draworder,1;diffusealpha,0;sleep,0.164;linear,0.2;diffusealpha,0.7;linear,0.3;diffusealpha,0;);
	};
};
--White flash
t[#t+1] = LoadActor( "../_door/whiteflash" )..{
			OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,0;sleep,0.164;zoom,1.5;linear,0.134;linear,0.299;zoom,5);
		};




return t
