return Def.Actor{
	OnCommand=function(self)
		ChangeGame()
		ChangeLanguage()
		local coins = GAMESTATE:GetCoins()
			if coins >= 1 then
				GAMESTATE:InsertCoin(-coins)
			end
	end;
}
