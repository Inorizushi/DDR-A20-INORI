local song = GAMESTATE:GetCurrentSong();
local t = Def.ActorFrame{};
local dt = 1.235;
--nt = 3.604 --fct = 4.872

if not GAMESTATE:IsDemonstration() then



	t[#t+1] = Def.ActorFrame {


--Sound
--LoadActor("../_failed") .. {
--	OnCommand=cmd(sleep,dt;queuecommand,"Play");
--	PlayCommand=cmd(play);
--};

	-- Cleared song --
    LoadActor("../ClearedSwoosh") .. {
		OnCommand=cmd(sleep,dt;queuecommand,"Play");
		PlayCommand=cmd(play);
	};

--Sound
--LoadActor("../__swooshDDRA") .. {
--	OnCommand=cmd(sleep,dt;queuecommand,"Play");
--	PlayCommand=cmd(play);
--};

--LoadActor("silver_bga") .. {
--	OnCommand=cmd(sleep,dt;queuecommand,"Play");
--	PlayCommand=cmd(play);
--};

LoadActor( "silver_bga" )..{
	InitCommand=cmd(FullScreen;diffusealpha,0);
	OnCommand=cmd(sleep,dt;linear,0.3;diffusealpha,1);
};



		--Black BG
		--Def.Quad{
		--	OnCommand=cmd(Center;FullScreen;diffusecolor,Color.Black;diffusealpha,0;sleep,dt;sleep,0.434;linear,0.033;diffusealpha,1;);
		--};
		Def.Quad{
			OnCommand=cmd(Center;FullScreen;diffusecolor,color("#00f6ff");diffusealpha,0;sleep,dt;sleep,0.434;linear,0.033;diffusealpha,1;linear,0.5;diffusealpha,0.1);
		};
		Def.Quad{
			OnCommand=cmd(blend,Blend.Add;Center;FullScreen;diffusecolor,Color.Blue;diffusealpha,0;sleep,dt;sleep,0.434;linear,0.033;diffusealpha,1;linear,0.3;diffusealpha,0);
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
		
		LoadActor( "ring_light" )..{
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

--for prt =0,10,1 do
LoadActor( "particle" )..{
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
LoadActor( "particle" )..{
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
LoadActor( "particle" )..{
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
--end;

		--Up side
		--BG
		LoadActor( "../_door_Silver/door_silver_a" )..{
			--OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
			OnCommand = function(self)
				self:zoom(2.3);
				self:x(SCREEN_CENTER_X);
				self:y(SCREEN_CENTER_Y);
				self:sleep(dt);
				self:decelerate(1);
				self:zoom(1);
			end;
		};
		LoadActor( "../_door_Silver/door_silver_b" )..{
			--OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
			OnCommand = function(self)
				self:zoom(2.3);
				self:x(SCREEN_CENTER_X);
				self:y(SCREEN_CENTER_Y);
				self:sleep(dt);
				self:decelerate(1);
				self:zoom(1);
				self:diffusealpha(0.7);
				self:linear(0.3);
				self:diffusealpha(0);
			end;
		};
		--LoadActor( "../_door_Silver/door_silver_a" )..{
		--	OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP-99;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
		--};

	

	}



	
t[#t+1] =	LoadActor( "Stage Cleared BG" )..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomx,3.5;zoomy,1.5);
	OnCommand=function(self)
		self:diffusealpha(0):zoomx(5):zoomy(3):sleep(dt):linear(0.264):diffusealpha(1):zoomx(2.5):zoomy(1.5):blend('BlendMode_Add')
	end;
	};
	
	t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(CenterX;diffuseshift;effectcolor1,1,1,1,0;effectcolor2,1,1,1,0.9;effectperiod,2.5);
	--AnimateCommand=cmd(diffuseshift;effectcolor1,1,1,1,0;effectcolor2,1,1,1,0.9;effectperiod,0.5);
	--LoadActor(THEME:GetPathB("","_door/glow"))..{
	--	InitCommand=cmd(y,SCREEN_TOP+172;zoom,1.5);
	--	OnCommand=cmd(addy,-232;sleep,dt;linear,0.283;addy,232;diffusealpha,1;);
	--};
	--LoadActor(THEME:GetPathB("","_door/glow"))..{
	--	InitCommand=cmd(y,SCREEN_BOTTOM-172;zoomy,-1;diffusealpha,0;zoom,-1.5);
	--	OnCommand=cmd(addy,232;sleep,dt;linear,0.283;addy,-232;diffusealpha,1;);
	--};
};

	if not GAMESTATE:IsCourseMode() and song:GetDisplayFullTitle() == "Tohoku EVOLVED" then
		-- t[#t+1] = Def.ActorFrame {
			
			-- LoadActor( "tohoku" )..{--Left
				-- OnCommand=cmd(zoom,1.5;x,SCREEN_LEFT-556;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.116;linear,0.217;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
			-- };
			
			-- LoadActor( "tohoku" )..{--Right
				-- OnCommand=cmd(zoom,1.5;x,SCREEN_RIGHT+556;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.116;linear,0.217;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
			-- };
			
			-- LoadActor( "tohoku" )..{--Glow
				-- OnCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.283;diffusealpha,0.5;zoom,1.7;linear,0.017;diffusealpha,1;linear,0.133;diffusealpha,0;zoom,2.25);
			-- };
		-- }
		t[#t+1] = Def.ActorFrame {
			--Left
			LoadActor( "cleared" )..{
				OnCommand=cmd(zoom,1.7;x,SCREEN_LEFT-556;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.116;linear,0.217;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
			};
			--Right
			LoadActor( "cleared" )..{
				OnCommand=cmd(zoom,1.7;x,SCREEN_RIGHT+556;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.116;linear,0.217;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
			};
			--Glow
			LoadActor( "cleared" )..{
				OnCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.283;diffusealpha,0.5;zoom,2.0;linear,0.017;diffusealpha,1;linear,0.133;diffusealpha,0;zoom,2.25);
			};
			--LoadActor( "glow_cleared" )..{
			--	OnCommand=cmd(zoom,1.5;diffusealpha,0;blend,Blend.Add;diffuseshift;effectperiod,0.55;effectcolor1,color("1,1,1,1");effectcolor2,color("0.5,0.5,0.5,1");
			--	diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,dt;linear,0.217;diffusealpha,1;);
			--};
		}
	else
		t[#t+1] = Def.ActorFrame {
			--Left
			LoadActor( "cleared" )..{
				OnCommand=cmd(zoom,1.7;x,SCREEN_LEFT-556;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.116;linear,0.217;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
			};
			--Right
			LoadActor( "cleared" )..{
				OnCommand=cmd(zoom,1.7;x,SCREEN_RIGHT+556;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.116;linear,0.217;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
			};
			--Glow
			LoadActor( "cleared" )..{
				OnCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.283;diffusealpha,0.5;zoom,2.0;linear,0.017;diffusealpha,1;linear,0.133;diffusealpha,0;zoom,2.25);
			};
			--LoadActor( "glow_cleared" )..{
			--	OnCommand=cmd(zoom,1.5;diffusealpha,0;blend,Blend.Add;diffuseshift;effectperiod,0.55;effectcolor1,color("1,1,1,1");effectcolor2,color("0.5,0.5,0.5,1");
			--	diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,dt;linear,0.217;diffusealpha,1;);
			--};
		}
	end

end

return t;