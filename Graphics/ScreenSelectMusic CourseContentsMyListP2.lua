local transform = function(self,offsetFromCenter,itemIndex,numitems)
	self:y( offsetFromCenter * 44 );
end
return Def.CourseContentsList {
	MaxSongs = 10;
    NumItemsToDraw = 20;
	ShowCommand=cmd(zoomy,1);
	HideCommand=cmd(linear,0.3;zoomy,0);
	SetCommand=function(self)
		self:SetFromGameState();
		--self:SetCurrentAndDestinationItem(3);
		self:SetPauseCountdownSeconds(100*100);
		self:SetSecondsPauseBetweenItems( 0.00 );
--		self:SetTransformFromFunction(transform);
		--
		self:SetDestinationItem(4);
		self:SetNumItemsToDraw(8);
		self:SetLoop(false);
		self:SetMask(0,0);

		self:x(SCREEN_CENTER_X+514-45);

	end;
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");

	Display = Def.ActorFrame { 
		InitCommand=cmd(setsize,350,40);

		--LoadActor(THEME:GetPathG("CourseEntryMyDisplay","bar")) .. {
		Def.Quad { 
			SetSongCommand=function(self, params)
				--self:diffuseleftedge( CustomDifficultyToLightColor(params.Difficulty) );
				self:setsize(320,28);
				self:zoomx(1);
				self:x(30);
				self:y(86);
				self:diffuse(color("0.2,0.17,0.17,1"));
				self:diffusealpha(1);
				--(cmd(finishtweening;diffusealpha,0;sleep,0.125*params.Number;linear,0.125;diffusealpha,1;linear,0.05;glow,color("1,1,1,0.5");decelerate,0.1;glow,color("1,1,1,0")))(self);
			end;
		};


		--song title

		LoadFont("_open sans semibold","24px") .. {
			Text="0";
			InitCommand=cmd(x,-125;y,86;maxwidth,210;horizalign,left;zoom,1.3;shadowlength,0);
			SetSongCommand=function(self, params)
			self:diffuse( color("1,1,1,1") );
			
				if params.Secret ==true then
					self:settext("? ? ? ? ? ?");
				else
					if params.Song then
						self:settext(params.Song:GetDisplayFullTitle());
					end;
				end;
				--(cmd(finishtweening;diffusealpha,0;sleep,0.125*params.Number;linear,0.125;diffusealpha,1;))(self);
			end;
		}; 
		
		--artist

		--LoadFont("_open sans semibold","24px") .. {
		--	Text="0";
		--	InitCommand=cmd(x,-70;y,9;maxwidth,320;horizalign,left;zoom,0.55;shadowlength,0);
		--	SetSongCommand=function(self, params)
		--	self:diffuse( color("0,0,0,1") );
		--		if params.Secret ==true then
		--			self:settext("??????");
		--		else
		--			if params.Song then
		--				self:settext(params.Song:GetDisplayArtist());
		--			end;
		--		end;
		--		(cmd(finishtweening;diffusealpha,0;sleep,0.125*params.Number;linear,0.125;diffusealpha,1;))(self);
		--	end;
		--}; 
 
		--song jacket
		
		--Def.Sprite {
		--	Name="SongBanner";
		--	SetSongCommand=function(self, params)
		--		if params.Song then
		--			self:Load(GetSongGPath(params.Song));
		--		else
		--			self:load("UnknownBanner.png");
		--		end
		--		self:scaletoclipped( 40,40 );
		--		self:x(-95);
		--		(cmd(finishtweening;zoomy,0;sleep,0.125*params.Number;linear,0.125;zoomy,1.1;linear,0.05;zoomx,1.1;decelerate,0.1;zoom,1))(self);
		--	end;
		--};

		--entry number
		
		--LoadFont("CourseEntryDisplay","number") .. {
		--	InitCommand=cmd(x,-133;y,0;shadowlength,0;diffuse,color( "0,0,0,1" );strokecolor,color("#999999"));
		--	SetSongCommand=function(self, params) 
		--		self:settext(string.format("%i", params.Number)); 
		--
		--		(cmd(finishtweening;zoom,1;diffusealpha,0;sleep,0.125*params.Number;linear,0.125;diffusealpha,1;linear,0.05;zoomy,1*1;zoomx,1*1.1;glow,color("1,1,1,0.5");decelerate,0.1;zoom,1;glow,color("1,1,1,0")))(self);
		--	end;
		--};


		Def.Quad {
			InitCommand=cmd(x,130+45;y,86;setsize,30,30);
			SetSongCommand=function(self, params)
				self:diffuse( CustomDifficultyToColor(params.Difficulty) );
				--(cmd(finishtweening;zoomy,0;sleep,0.125*params.Number;linear,0.125;zoomy,1.1;linear,0.05;zoomx,1.1;decelerate,0.1;zoom,1))(self);
			end;
		};
 		LoadFont("_geo 95 20px") .. {
			Text="0";
			InitCommand=cmd(zoomx,1.4;zoomy,1.2;x,130+45;y,-12+88;diffuse,color( "1,1,1,1" );strokecolor, color( "0,0,0,1" ));
			SetSongCommand=function(self, params)
				if params.PlayerNumber ~= GAMESTATE:GetMasterPlayerNumber() then return end
				self:settext( params.Meter );
				
				--(cmd(finishtweening;zoomy,0;sleep,0.125*params.Number;linear,0.125;zoomy,1.6;linear,0.05;zoom,1.6;decelerate,0.1;zoom,1.4))(self);
			end;
		}; 
	};
};