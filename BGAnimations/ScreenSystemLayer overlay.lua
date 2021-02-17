local function OverlayBlack()
	local t = Def.ActorFrame{};
	t[#t+1] = Def.Quad{
		InitCommand=cmd(y,SCREEN_BOTTOM;x,SCREEN_CENTER_X;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT*1/5;diffusecolor,color("0.0,0.0,0.2,1");diffusealpha,0.2;fadetop,1);
	};
	t[#t+1] = Def.Quad{
		InitCommand=cmd(y,SCREEN_TOP;x,SCREEN_CENTER_X;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT*1/5;diffusecolor,color("0.0,0.0,0.2,1");diffusealpha,0.2;fadebottom,1);
	};
	return t;
end;



local function PaseliText_P1()
	--Text of "EXTRA PASELI : XX"
	local text = LoadFont("Common Normal") .. {
		InitCommand = cmd(x,SCREEN_CENTER_X-632;y,SCREEN_BOTTOM-11.5;zoom,0.62;strokecolor,color("0.3,0.3,0.3,1");playcommand,"Refresh");
		RefreshCommand = function(self)
			self:horizalign(left)
			--self:settext("EXTRA PASELI: 0")
			self:settext("")
		end;
		UpdateVisibleCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local bShow = true;
			if screen then
				local sClass = screen:GetName();
				bShow = THEME:GetMetric( sClass, "ShowCreditDisplay" );
			end;
			self:visible( bShow );
		end;
		CoinInsertedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		RefreshCreditTextMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		PlayerJoinedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		ScreenChangedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
	};
	return text;
end;

local function PaseliText_P2()
	--Text of "EXTRA PASELI : XX"
	local text = LoadFont("Common Normal") .. {
		InitCommand = cmd(x,SCREEN_CENTER_X+630;y,SCREEN_BOTTOM-11.5;zoom,0.62;strokecolor,color("0.3,0.3,0.3,1");playcommand,"Refresh");
		RefreshCommand = function(self)
			self:horizalign(right)
			--self:settext("EXTRA PASELI: 0")
			self:settext("")
		end;
		UpdateVisibleCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local bShow = true;
			if screen then
				local sClass = screen:GetName();
				bShow = THEME:GetMetric( sClass, "ShowCreditDisplay" );
			end;
			self:visible( bShow );
		end;
		CoinInsertedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		RefreshCreditTextMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		PlayerJoinedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		ScreenChangedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
	};
	return text;
end;



local function CreditsText()
	local text = LoadFont("Common Normal") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-11.5;zoom,0.62;strokecolor,color("0.3,0.3,0.3,1");playcommand,"Refresh");
		RefreshCommand=function(self)
		--Other coin modes
			if GAMESTATE:IsEventMode() then self:settext('EVENT MODE') return end
			--if GAMESTATE:IsEventMode() then self:settext('CREDIT : 0') return end
			if GAMESTATE:GetCoinMode()=='CoinMode_Free' then self:settext('FREE PLAY') return end
			if GAMESTATE:GetCoinMode()=='CoinMode_Home' then self:settext('HOME MODE') return end
		--Normal pay
			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			local credits=math.floor(coins/coinsPerCredit)
			local remainder=math.mod(coins,coinsPerCredit)
			local s='CREDIT : '
			if credits > 1 then
				s='CREDIT : '..credits
			elseif credits == 1 then
				s=s..credits
			else
				s=s..0
			end
			--self:horizalign(left)
			self:settext(s)
		end;
		UpdateVisibleCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local bShow = true;
			if screen then
				local sClass = screen:GetName();
				bShow = THEME:GetMetric( sClass, "ShowCreditDisplay" );
			end;

			self:visible( bShow );
		end;
		CoinInsertedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		RefreshCreditTextMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		PlayerJoinedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		ScreenChangedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
	};
	return text;
end;

local function CoinsText()
	local text = LoadFont("Common Normal") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X+281;y,SCREEN_BOTTOM-11.5;zoom,0.62;strokecolor,color("0.3,0.3,0.3,1");horizalign,center;playcommand,"Refresh");
		RefreshCommand=function(self)
			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			local remainder=math.mod(coins,coinsPerCredit)
			local s='COIN(S) : '
			if coinsPerCredit > 1 then
				s=s..remainder..'/'..coinsPerCredit
			else
				s=''
			end

			if GAMESTATE:GetCoinMode() == 'CoinMode_Pay' then
				self:visible(true);
			else
				self:visible(false);
			end

			self:settext(s)
		end;
		UpdateVisibleCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local bShow = true;
			if screen then
				local sClass = screen:GetName();
				bShow = THEME:GetMetric( sClass, "ShowCreditDisplay" );
			end;

			self:visible( bShow );
		end;
		CoinInsertedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		RefreshCreditTextMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		PlayerJoinedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		ScreenChangedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
	};
	return text;
end;

local function NetworkText()
	local text = LoadFont("Common Normal") .. {
		InitCommand=function (self)
			self:name("NetworkStatus");
			self:settext("-----");
			self:x(SCREEN_CENTER_X-262);
			self:y(SCREEN_BOTTOM-11.5);
			self:horizalign(right);
        	self:zoom(0.62)
			self:strokecolor(color("0.3,0.3,0.3,1"));
		end;
		RefreshCommand=function (self)
		local netConnected = IsNetConnected();
		local loggedOnSMO = IsNetSMOnline();

			if not netConnected then
				self:diffuse(color("#00FF00"));
				self:settext("OFFLINE");
				--self:settext("");
			else
				self:diffuse(color("#00FF00"));
				self:settext("ONLINE");
				--self:settext("");
			end;
		end;
		UpdateVisibleCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local bShow = true;
			if screen then
				local sClass = screen:GetName();
				bShow = THEME:GetMetric( sClass, "ShowCreditDisplay" );
			end

			self:visible( bShow );
		end;
		CoinInsertedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		RefreshCreditTextMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		PlayerJoinedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		ScreenChangedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
	};
	return text;
end;

local t = Def.ActorFrame {}

t[#t+1] = Def.ActorFrame {
 	--CreditsText( PLAYER_1 );
	--CreditsText( PLAYER_2 );
	OverlayBlack();
	NetworkText();
	CreditsText();
	CoinsText();
	PaseliText_P1();
	PaseliText_P2();
};

return t;
