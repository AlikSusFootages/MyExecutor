
--/° Services °/--

local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/src/Icons.lua"))().assets


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
local GUI_Transparency = 0.4
local GUI_StrokeTransparency = 0.7
local GUI_Font = "Gotham"

local Player = Players.LocalPlayer
local PlayerGui = game.CoreGui



--/° Other °/--

getgenv().identifyexecutor = function() return _fullName end
getgenv().getexecutorname = function() return _fullName end

local GUI_Settings = {
    UISettings = {
        Theme = GUI_CurrentTheme,
        Language = "En"
    },
    Scripts = {},
    
}

if not isfolder("Dozer") then
    makefolder("Dozer")
end
if not isfile("Dozer/Settings.json") then
    writefile("Dozer/Settings.json", tostring(HttpService:JSONEncode(GUI_Settings)))
end


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

local function GetIcon(Name) 
    if Name ~= nil and Icons["lucide-" .. Name] then 
        return Icons["lucide-" .. Name] 
    end 
    return nil 
end

local function ChangeTheme(Theme)
    GUI_Settings.UISettings.Theme = Theme
    writefile("Dozer/Settings.json", tostring(HttpService:JSONEncode(GUI_Settings)))
end

local function ChangeLanguage(Language)
    GUI_Settings.UISettings.Language = Language
    writefile("Dozer/Settings.json", tostring(HttpService:JSONEncode(GUI_Settings)))
end

local function AddScript(Name, Script)
    GUI_Settings.Scripts[Name] = Script
    writefile("Dozer/Settings.json", tostring(HttpService:JSONEncode(GUI_Settings)))
end
local function DelScript(Name)
    GUI_Settings.Scripts[Name] = nil
    writefile("Dozer/Settings.json", tostring(HttpService:JSONEncode(GUI_Settings)))
end



--/° Main °/--

if game:isLoaded() then
    local UsingTheme = Dozer.Themes[GUI_CurrentTheme]
    local ScreenGui = Create("ScreenGui", {
        Name = "Dozer Executor v" .. _version,
        ZIndexBehavior = "Sibling",
        Enabled = true,
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        Parent = PlayerGui,
        DisplayOrder = 9999
    }, {
        Create("TextButton", {
            Name = "OpenButton",
            Size = UDim2.fromOffset(60,60),
            Position = UDim2.fromOffset(10,46),
            TextColor3 = UsingTheme.Text,
            BackgroundColor3 = UsingTheme.Main,
            BorderSizePixel = 0,
            Text = "Open"
        }),
        Create("Frame", {
            BackgroundColor3 = Color3.fromRGB(0,3,6),
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            ZIndex = 99999
        }, {
            Create("Frame", {
                BackgroundColor3 = UsingTheme.Main,
                BackgroundTransparency = GUI_Transparency - 0.1,
                Size = UDim2.new(0, 340, 1, 0),
                BorderSizePixel = 0,
                Name = "Sidebar",
                AnchorPoint = Vector2.new(1,0)
            }, {
                Create("UIPadding", {
                    PaddingTop = UDim.new(0, 30),
                    PaddingLeft = UDim.new(0, 45),
                    PaddingRight = UDim.new(0, 45),
                    PaddingBottom = UDim.new(0, 30),
                }),
                Create("TextLabel", {
                    Font = GUI_Font .. "Medium",
                    Text = "Dozer",
                    TextColor3 = UsingTheme.Text,
                    BackgroundTransparency = 1,
                    TextSize = 40,
                    Size = UDim2.new(1,0,0,50),
                    TextXAlignment = "Left",
                    TextYAlignment = "Top",
                    Position = UDim2.fromOffset(0, 0)
                }),
                Create("ImageButton", {
                    Image = GetIcon("x"),
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(1,0),
                    Size = UDim2.fromOffset(30,30),
                    Position = UDim2.new(1,0,0,6),
                    Name = "CloseButton"
                }),
                Create("Frame", {
                    Size = UDim2.new(0,1,1,60),
                    Position = UDim2.new(1,45,0,-30),
                    BorderSizePixel = 0,
                    BackgroundTransparency = GUI_StrokeTransparency,
                    BackgroundColor3 = UsingTheme.Stroke,
                    AnchorPoint = Vector2.new(1,0),
                }),
                Create("TextButton", {
                    Text = "",
                    BackgroundTransparency = 1,
                    BackgroundColor3 = UsingTheme.Stroke,
                    AutoButtonColor = false,
                    Size = UDim2.new(1,0,0,60),
                    Position = UDim2.new(0,0,1,0),
                    AnchorPoint = Vector2.new(0,1)
                }, {
                    Create("ImageLabel", {
                        Image = "https://www.roblox.com/headshot-thumbnail/image?userId=".. Player.UserId .."&width=420&height=420&format=png"
                    })
                }),
                Create("Frame", {
                    Size = UDim2.new(1,0,1,-100),
                    Position = UDim2.new(0,0,0,35),
                    BackgroundTransparency = 0.9,
                    BorderSizePixel = 0
                })
            })
        })
    })
    ScreenGui.OpenButton.MouseButton1Click:Connect(function()
        TweenService:Create(ScreenGui.Frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.4}):Play()
        TweenService:Create(ScreenGui.Frame.Sidebar, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {AnchorPoint = Vector2.new(0,0)}):Play()
    end)
    ScreenGui.Frame.Sidebar.CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(ScreenGui.Frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 1}):Play()
        TweenService:Create(ScreenGui.Frame.Sidebar, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {AnchorPoint = Vector2.new(1,0)}):Play()
    end)
end