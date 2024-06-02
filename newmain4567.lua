
--/° Services °/--

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")


--/° Variables °/--

local _version = "1.0.0"

local Player = Players.LocalPlayer
local Dozer = {
    Name = "Dozer",
    Themes = {
        Dark = {
            ["Main"] = Color3.fromRGB(16,16,16),
            ["Stroke"] = Color3.fromRGB(174,174,174),
            ["Text"] = Color3.fromRGB(255,255,255),
        }
    }
}


--/° Functions °/--

local function Create(Name, Properties, Children)
	local Object = Instance.new(Name)
	for i, v in next, Properties or {} do
		Object[i] = v
	end
	for i, v in next, Children or {} do
		v.Parent = Object
	end
	return Object
end


if game:isLoaded() then
    local ScreenGui = Create("ScreenGui", {
        Name = "Dozer Executor v" .. _version,
    })
end