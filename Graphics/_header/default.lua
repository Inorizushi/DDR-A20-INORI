return Def.ActorFrame {
	LoadActor( "bg" ) .. {
		InitCommand=cmd(x,0;y,7;zoom,1.77);
		OnCommand=function(self)
			if Screen.String("HeaderText") == 'SELECT MUSIC' or Screen.String("HeaderText") == 'SELECT COURSE' then
				self:diffusealpha(0);
			else
				self:diffusealpha(1);
			end
			(cmd(addy,-52;sleep,0.2;decelerate,0.0833;addy,52))(self);
		end;
		OffCommand=cmd(finishtweening;sleep,0.2;decelerate,0.0833;addy,-52);
	};

	--text login / logout
		LoadActor( "login" ) .. {
		InitCommand=cmd(x,0;y,7;zoomx,0.53;zoomy,0.55);
		OnCommand=function(self)
			if Screen.String("HeaderText") == 'LOGIN' then
				self:diffusealpha(1);
			else
				self:diffusealpha(0);
			end
			(cmd(addy,-52;sleep,0.2;decelerate,0.0833;addy,48))(self);
		end;
		OffCommand=cmd(finishtweening;sleep,0.2;decelerate,0.0833;addy,-52);
	};
		LoadActor( "logout" ) .. {
		InitCommand=cmd(x,0;y,7;zoomx,0.53;zoomy,0.55);
		OnCommand=function(self)
			if Screen.String("HeaderText") == 'LOGOUT' then
				self:diffusealpha(1);
			else
				self:diffusealpha(0);
			end
			(cmd(addy,-52;sleep,0.2;decelerate,0.0833;addy,48))(self);
		end;
		OffCommand=cmd(finishtweening;sleep,0.2;decelerate,0.0833;addy,-52);
	};
	--texts
	LoadActor( "selectstyle" ) .. {
		InitCommand=cmd(x,0;y,7;zoomx,0.53;zoomy,0.55);
		OnCommand=function(self)
			if Screen.String("HeaderText") == 'SELECT STYLE' then
				self:diffusealpha(1);
			else
				self:diffusealpha(0);
			end
			(cmd(addy,-52;sleep,0.2;decelerate,0.0833;addy,48))(self);
		end;
		OffCommand=cmd(finishtweening;sleep,0.2;decelerate,0.0833;addy,-52);
	};

	
	LoadActor( "selectmode" ) .. {
		InitCommand=cmd(x,0;y,7;zoomx,0.53;zoomy,0.55);
		OnCommand=function(self)
			if Screen.String("HeaderText") == 'SELECT MODE' then
				self:diffusealpha(1);
			else
				self:diffusealpha(0);
			end
			(cmd(addy,-52;sleep,0.2;decelerate,0.0833;addy,48))(self);
		end;
		OffCommand=cmd(finishtweening;sleep,0.2;decelerate,0.0833;addy,-52);
	};

	LoadActor( "results_stage" ) .. {
		--InitCommand=cmd(x,-20;y,7;zoomx,0.53;zoomy,0.55);
		InitCommand=function(self)
			self:x(-20);
			self:y(7);
			self:zoomx(0.53);
			self:zoomy(0.55);
		end;
		OnCommand=function(self)
			local DanniNinteiFolderName = {
				"Danni_Nintei_SP",
				"Danni_Nintei_SP_forPlay",
				"Danni_Nintei_DP",
				"Danni_Nintei_DP_forPlay",
			};
			local isDan = false;
			local grName = "";
	
			if GAMESTATE:IsCourseMode() then
				grName = GAMESTATE:GetCurrentCourse():GetGroupName();
			end;
	
			for i = 1,#DanniNinteiFolderName do
				if grName == DanniNinteiFolderName[i] then
					isDan = true;
				end;
			end;
			
			if isDan then
				self:x(20);
			else
				self:x(-20);
			end;
		
			if Screen.String("HeaderText") == 'RESULTS' then
				self:diffusealpha(1);
			else
				self:diffusealpha(0);
			end
			(cmd(addy,-52;sleep,0.2;decelerate,0.0833;addy,48))(self);
		end;
		OffCommand=cmd(finishtweening;sleep,0.2;decelerate,0.0833;addy,-52);
	};

	LoadActor( "totalresults" ) .. {
		InitCommand=cmd(x,0;y,7;zoomx,0.53;zoomy,0.55);
		OnCommand=function(self)
			if Screen.String("HeaderText") == 'TOTAL RESULTS' then
				self:diffusealpha(1);
			else
				self:diffusealpha(0);
			end
			(cmd(addy,-52;sleep,0.2;decelerate,0.0833;addy,48))(self);
		end;
		OffCommand=cmd(finishtweening;sleep,0.2;decelerate,0.0833;addy,-52);
	};

	LoadActor( "practicesongs" ) .. {
		InitCommand=cmd(x,0;y,7;zoomx,0.53;zoomy,0.55);
		OnCommand=function(self)
			if Screen.String("HeaderText") == 'Practice Songs' then
				self:diffusealpha(1);
			else
				self:diffusealpha(0);
			end
			(cmd(addy,-52;sleep,0.2;decelerate,0.0833;addy,48))(self);
		end;
		OffCommand=cmd(finishtweening;sleep,0.2;decelerate,0.0833;addy,-52);
	};

	LoadActor( "edit" ) .. {
		InitCommand=cmd(x,0;y,7;zoomx,0.53;zoomy,0.55);
		OnCommand=function(self)
			if Screen.String("HeaderText") == 'Edit Song/Steps' then
				self:diffusealpha(1);
			else
				self:diffusealpha(0);
			end
			(cmd(addy,-52;sleep,0.2;decelerate,0.0833;addy,48))(self);
		end;
		OffCommand=cmd(finishtweening;sleep,0.2;decelerate,0.0833;addy,-52);
	};

	LoadActor( "selectcoursemode" ) .. {
		InitCommand=cmd(x,0;y,7;zoomx,0.53;zoomy,0.55);
		OnCommand=function(self)
			if Screen.String("HeaderText") == 'SELECT COURSE MODE' then
				self:diffusealpha(1);
			else
				self:diffusealpha(0);
			end
			(cmd(addy,-52;sleep,0.2;decelerate,0.0833;addy,48))(self);
		end;
		OffCommand=cmd(finishtweening;sleep,0.2;decelerate,0.0833;addy,-52);
	};
	




	--header texts before

	LoadFont("_compacta blk 14px") .. {
		Name="HeaderText";
		Text=Screen.String("HeaderText");
		
		InitCommand=cmd(x,0;y,-45;zoomx,2.5;zoomy,1.75;shadowlength,0;diffuse,1,1,1,1;strokecolor,Color("White"););
		--OnCommand=cmd(skewx,-0.125;strokecolor,Color("Outline");diffusebottomedge,color("0.875,0.875,0.875"));
		OnCommand=function(self)
			if Screen.String("HeaderText") == 'SELECT MUSIC' or Screen.String("HeaderText") == 'SELECT COURSE' then
				self:diffusealpha(0);
			else
				self:diffusealpha(0);
			end
			if Screen.String("HeaderText") == 'RESULTS' then
				self:x(-100);
			end
			if Screen.String("HeaderText") == 'SELECT COURSE MODE' then
				self:zoomx(2);
			end
			(cmd(sleep,0.2;linear,0.0833;y,0))(self);
		end;
		OffCommand=cmd(linear,0.2;y,-38);
		UpdateScreenHeaderMessageCommand=function(self,param)
			self:settext(param.Header);
		end;
	};
	
}
