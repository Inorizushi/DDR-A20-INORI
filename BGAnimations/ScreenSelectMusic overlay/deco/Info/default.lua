local Crstext = THEME:GetString("MusicWheel","CustomItemCrsText");

local AnimPlayed = true

return Def.ActorFrame{
  InitCommand=cmd(xy,_screen.cx,_screen.cy-274);
  CurrentSongChangedMessageCommand=function(s)
    if GAMESTATE:GetCurrentSong() then
      s:queuecommand("Show"):queuecommand("Set")
    else
      s:queuecommand("Hide")
    end
  end,
  ShowCommand=function(s)
    if AnimPlayed == false then 
      s:diffusealpha(0):linear(0.05):diffusealpha(0.75)
      :linear(0.1):diffusealpha(0.25):linear(0.1):diffusealpha(1)
      s:queuecommand("UpdateShow")
    end
  end,
  UpdateShowCommand=function(s) AnimPlayed = true end,
  HideCommand=function(s)
    if AnimPlayed == true then
      s:diffusealpha(1):sleep(0.05):diffusealpha(0):sleep(0.05):diffusealpha(0.5)
      :sleep(0.05):diffusealpha(0):sleep(0.05):diffusealpha(0.25):sleep(0.05)
      :linear(0.05):diffusealpha(0)
      s:queuecommand("UpdateHide")
    end
  end,
  UpdateHideCommand=function(s) AnimPlayed = false end,
  Def.ActorFrame{
    Name="BPMBar";
    InitCommand=cmd(xy,-20,44);
    LoadActor(ddrgame.."music_select_bpm_base.png");
    LoadActor("music_select_bpm_word_bpm.png")..{
      InitCommand=cmd(xy,70,10);
    };
    Def.Sprite{
  		Texture="_meter 2x2.png";
  		InitCommand=cmd(xy,46,16;effectclock,'beatnooffset';SetAllStateDelays,1);
  	};
    LoadFont("Bpm")..{
    	InitCommand=cmd(zoom,1.4;xy,124,1);
    	SetCommand=function(self)
    		local song = GAMESTATE:GetCurrentSong();
    		if song then
    			local bpmtext;
    			bpmtext = song:GetDisplayBpms();
    			if bpmtext[1] == bpmtext[2] then
    				bpmtext = round(bpmtext[1],0);
    			else
    				bpmtext = string.format("%d\nx%3d",round(bpmtext[1],0),round(bpmtext[2],0));
    			end
    			self:horizalign(right);
    			self:vertalign(top);
    			self:settext(bpmtext);
    			self:visible(true);
    		else
    			self:visible(false);
    		end
    	end;
    };
  };
  Def.ActorFrame{
    InitCommand=function(s) s:xy(-2,-1) end,
    Name="SongArtist Bar";
    LoadActor(ddrgame.."ms_info_base_shadow.png")..{
      OnCommand=cmd(diffuseshift;effectcolor1,color("1,1,1,1");effectcolor2,color("1,1,1,0.5");effectperiod,1.5);
    };
    LoadActor("ms_info_base.png")..{
      InitCommand=function(s) s:diffusealpha(0.75) end,
    };
    LoadActor(ddrgame.."ms_info_base_line.png");
    Def.ActorFrame{
      InitCommand=cmd(xy,-90,-7);
      LoadActor("ms_info_song_name_base.png");
      LoadFont("_helveticaneuelt w1g 95 blk 24px")..{
        Name="Title";
        InitCommand=cmd(x,-238;halign,0;maxwidth,460;diffuse,color("0,0,0,1"));
        SetCommand=function(s)
          local song = GAMESTATE:GetCurrentSong()
          local mw = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
          if not mw then return end
          if song then
            if song:GetDisplaySubTitle() == "" then
            s:settext(song:GetDisplayMainTitle())
            else
            s:settext(song:GetDisplayFullTitle())
            end
          elseif mw:GetSelectedType('WheelItemDataType_Section') then
            local group = mw:GetSelectedSection()
            if group then
            s:settext(GAMESTATE:GetSortOrder('SortOrder_Group') and SongAttributes.GetGroupName(group) or "")
            end
          else
            s:settext("")
          end
        end
      };
      LoadFont("_helveticaneuelt w1g 95 blk 24px")..{
        Name="Artist";
        InitCommand=cmd(xy,-238,28;halign,0;maxwidth,440;zoomx,0.78;zoomy,0.65);
        SetCommand=function(s)
          local song = GAMESTATE:GetCurrentSong()
          if song then
            s:settext(song:GetDisplayArtist())
          else
            s:settext("")
          end
        end
      };
    };
    LoadActor("ms_info_base.png")..{
      InitCommand=cmd(MaskSource,true);
    };
    LoadActor("ms_info_base_rader.png")..{
      InitCommand=cmd(diffusealpha,0.5;blend,Blend.Add;MaskDest;ztestmode,"ZTestMode_WriteOnFail");
      OnCommand=cmd(queuecommand,"Anim");
      AnimCommand=cmd(x,-400;sleep,4;linear,1.5;x,300;queuecommand,"Anim");
    };
    Def.ActorFrame{
      Name="InfoTab";
      InitCommand=cmd(xy,-314,-32);
      LoadActor(ddrgame.."ms_info_tab_base.png");
      LoadActor("ms_info.png")..{
        InitCommand=cmd(x,-8);
      };
    };
  };
  Def.ActorFrame{
    InitCommand=cmd(xy,242,18);
    LoadActor(ddrgame.."00di_jk_frame_old.png");
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
  };
};
