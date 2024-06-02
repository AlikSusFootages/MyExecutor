
--/° Services °/--

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")


--/° Variables °/--

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

local _version = "1.0.0"

local _fullName = Dozer.Name .. " v" .. _version

local GUI_CurrentTheme = "Dark"
local GUI_Transparency = 0.7
local GUI_Font = "Gotham"

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui



--/° Other °/--

getgenv().identifyexecutor = function() return name end
getgenv().getexecutorname = function() return name end



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
    local UsingTheme = Dozer.Themes[GUI_CurrentTheme]
    local ScreenGui = Create("ScreenGui", {
        Name = "Dozer Executor v" .. _version,
        ZIndexBehavior = "Sibling",
        Enabled = true,
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        Parent = PlayerGui
    }, {
        Create("Frame", {
            BackgroundColor3 = Color3.fromRGB(0,3,6),
            BackgroundTransparency = GUI_Transparency,
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
        }, {
            Create("Frame", {
                BackgroundColor3 = UsingTheme.Main,
                BackgroundTransparency = GUI_Transparency,
                Size = UDim2.new(0, 340, 1, 0),
                BorderSizePixel = 0
            }, {
                Create("UIPadding", {
                    PaddingTop = UDim.new(0, 30),
                    PaddingLeft = UDim.new(0, 45),
                    PaddingRight = UDim.new(0, 45),
                    PaddingBottom = UDim.new(0, 30),
                }),
                Create("TextLabel", {
                    Font = "Gotham",
                    Text = "Dozer",
                    TextSize = 50,
                    Size = UDim2.new(1,0,0,50),
                    TextXAlignment = "Left",
                    TextYAlignment = "Top",
                })
            })
        })
    })
end