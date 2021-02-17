--various functions that help us work with chaquetes.........


function GetJacketPath(item, fallback)
	--i.e. 
	if item.HasJacket and item:HasJacket() then
		return item:GetJacketPath()
	elseif item:HasBackground() then
		return item:GetBackgroundPath()
	elseif item:HasBanner() then
		return item:GetBannerPath()
	else
		return fallback or THEME:GetPathG("Common","fallback jacket")
	end
end

function Sprite:_LoadSCJacket(...)
	return self:Load(GetJacketPath(...))
end

function GetGroupJacketPath(groupName, fallback)
	local paths = {
		"/Songs/"..groupName.."/jacket.png",
		"/Songs/"..groupName.."/jacket.jpg",
		"/AdditionalSongs/"..groupName.."/jacket.png",
		"/AdditionalSongs/"..groupName.."/jacket.jpg"
	}
	for path in ivalues(paths) do
		if FILEMAN:DoesFileExist(path) then
			return path
		end
	end
	return fallback or THEME:GetPathG("Common","fallback jacket")
end


function Sprite:_LoadSCBanner(...)
	return self:Load(GetBannerPath(...))
end

function Sprite:_LoadGBanner(...)
	return self:Load(GetGroupBannerPath(...))
end
