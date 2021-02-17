local t = Def.ActorFrame {};
local screenName = Var "LoadingScreen"

local footerTextImage

if screenName == "ScreenEvaluationNormal" then
	footerTextImage = "eval"
elseif screenName == "ScreenEvaluationSummary" then
	footerTextImage = "skip"
elseif screenName == "ScreenSelectMusic" then
	footerTextImage = "selmus"
end

t[#t+1] = Def.Sprite{
	Texture=ddrgame.."coopgu_ope_base",
};

if footerTextImage then
	t[#t+1] = Def.Sprite{
		Texture=ddrgame..lang.."_"..footerTextImage,
		InitCommand=function(s) end,
	};
end

return t;