
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
        Language = "En",
        Transparency = GUI_Transparency
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
                BackgroundTransparency = GUI_Transparency - 0.2,
                Size = UDim2.new(0, 300, 1, 0),
                BorderSizePixel = 0,
                Name = "Sidebar",
                Active = true,
                AnchorPoint = Vector2.new(1,0)
            }, {
                Create("UIPadding", {
                    PaddingTop = UDim.new(0, 30),
                    PaddingLeft = UDim.new(0, 45),
                    PaddingRight = UDim.new(0, 45),
                    PaddingBottom = UDim.new(0, 25),
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
                    AnchorPoint = Vector2.new(0,1),
                }, {
                    Create("ImageLabel", {
                        Image = "https://www.roblox.com/headshot-thumbnail/image?userId=".. Player.UserId .."&width=420&height=420&format=png",
                        Size = UDim2.fromOffset(60,60),
                        Position = UDim2.new(0,0,0.5,0),
                        AnchorPoint = Vector2.new(0,0.5),
                        BackgroundTransparency = 1,
                    }, {
                        Create("UICorner", {
                            CornerRadius = UDim.new(1,1)
                        })
                    }),
                    Create("TextLabel", {
                        Text = Player.DisplayName,
                        Position = UDim2.new(0,70,0,6),
                        BackgroundTransparency = 1,
                        TextSize = 20,
                        Font = GUI_Font .. "Medium",
                        TextColor3 = UsingTheme.Text,
                        TextXAlignment = "Left",
                        TextYAlignment = "Top",
                        Size = UDim2.new(1,-70,0,20),
                        TextTruncate = "AtEnd"
                    }),
                    Create("TextLabel", {
                        Text = Player.Name,
                        Position = UDim2.new(0,70,1,-6),
                        BackgroundTransparency = 1,
                        TextSize = 18,
                        AnchorPoint = Vector2.new(0,1),
                        Font = GUI_Font .. "Medium",
                        TextColor3 = UsingTheme.Stroke,
                        TextXAlignment = "Left",
                        TextYAlignment = "Top",
                        Size = UDim2.new(1,-70,0,20),
                        TextTruncate = "AtEnd"
                    })
                }),
                Create("Frame", {
                    Size = UDim2.new(1,0,1,-150),
                    Position = UDim2.new(0,0,0,70),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Name = "Navbar"
                }, {
                    Create("UIListLayout", {
                        FillDirection = "Vertical",
                        Padding = UDim.new(0,28),
                        SortOrder = "LayoutOrder",
                    }),
                    Create("TextButton", {
                        Text = "Info",
                        Name = "Info",
                        TextColor3 = UsingTheme.Text,
                        TextSize = 22,
                        Font = GUI_Font,
                        Size = UDim2.new(1,0,0,26),
                        BackgroundTransparency = 1,
                        TextXAlignment = "Left"
                    }, {
                        Create("UIPadding", {
                            PaddingLeft = UDim.new(0,32)
                        }),
                        Create("ImageLabel", {
                            Size = UDim2.fromOffset(24,24), 
                            Image = GetIcon("info"),
                            Position = UDim2.new(0, -32, 0.5, 0),
                            AnchorPoint = Vector2.new(0,0.5),
                            BackgroundTransparency = 1
                        })
                    }),
                    Create("TextButton", {
                        Text = "Executor",
                        Name = "Executor",
                        TextColor3 = UsingTheme.Stroke,
                        TextSize = 22,
                        Font = GUI_Font,
                        Size = UDim2.new(1,0,0,26),
                        BackgroundTransparency = 1,
                        TextXAlignment = "Left"
                    }, {
                        Create("UIPadding", {
                            PaddingLeft = UDim.new(0,32)
                        }),
                        Create("ImageLabel", {
                            Size = UDim2.fromOffset(24,24), 
                            Image = GetIcon("scroll"),
                            Position = UDim2.new(0, -32, 0.5, 0),
                            AnchorPoint = Vector2.new(0,0.5),
                            BackgroundTransparency = 1,
                            ImageColor3 = UsingTheme.Stroke
                        })
                    }),
                    Create("TextButton", {
                        Text = "Search Scripts",
                        Name = "ScriptSearch",
                        TextColor3 = UsingTheme.Stroke,
                        TextSize = 22,
                        Font = GUI_Font,
                        Size = UDim2.new(1,0,0,26),
                        BackgroundTransparency = 1,
                        TextXAlignment = "Left"
                    }, {
                        Create("UIPadding", {
                            PaddingLeft = UDim.new(0,32)
                        }),
                        Create("ImageLabel", {
                            Size = UDim2.fromOffset(24,24), 
                            Image = GetIcon("file-search-2"),
                            Position = UDim2.new(0, -32, 0.5, 0),
                            AnchorPoint = Vector2.new(0,0.5),
                            BackgroundTransparency = 1,
                            ImageColor3 = UsingTheme.Stroke
                        })
                    }),
                    Create("TextButton", {
                        Text = "Settings",
                        Name = "Settings",
                        TextColor3 = UsingTheme.Stroke,
                        TextSize = 22,
                        Font = GUI_Font,
                        Size = UDim2.new(1,0,0,26),
                        BackgroundTransparency = 1,
                        TextXAlignment = "Left"
                    }, {
                        Create("UIPadding", {
                            PaddingLeft = UDim.new(0,32)
                        }),
                        Create("ImageLabel", {
                            Size = UDim2.fromOffset(24,24), 
                            Image = GetIcon("settings"),
                            Position = UDim2.new(0, -32, 0.5, 0),
                            AnchorPoint = Vector2.new(0,0.5),
                            BackgroundTransparency = 1,
                            ImageColor3 = UsingTheme.Stroke
                        })
                    })
                })
            }),
            Create("Frame", {
                Size = UDim2.new(1, -300, 1, 0),
                Position = UDim2.new(1,0,0,0),
                AnchorPoint = Vector2.new(1,0),
                BackgroundTransparency = 1,
                Name = "RightFrames"
            }, {
                -- Info
                Create("TextLabel", {
                    BackgroundTransparency = GUI_Transparency -0.2,
                    BackgroundColor3 = UsingTheme.Main,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -40, 1, -40),
                    Position = UDim2.new(0.5,0,0.5,0),
                    AnchorPoint = Vector2.new(0.5,0.5),
                    TextXAlignment = "Left",
                    TextYAlignment = "Top",
                    TextColor3 = UsingTheme.Text,
                    TextSize = 38,
                    Text = "Info",
                    Font = GUI_Font .. "Medium",
                    Name = "Info",
                    Visible = true
                }, {
                    Create("UICorner", {
                        CornerRadius = UDim.new(0, 14)
                    }),
                    Create("UIStroke", {
                        Thickness = 1,
                        Color = UsingTheme.Stroke,
                        Transparency = GUI_StrokeTransparency,
                        ApplyStrokeMode = "Border"
                    }),
                    Create("UIPadding", {
                        PaddingTop = UDim.new(0, 20),
                        PaddingLeft = UDim.new(0, 25),
                        PaddingRight = UDim.new(0, 25),
                        PaddingBottom = UDim.new(0, 20),
                    })
                }),
                -- Executor
                Create("TextLabel", {
                    BackgroundTransparency = GUI_Transparency -0.2,
                    BackgroundColor3 = UsingTheme.Main,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -40, 1, -40),
                    Position = UDim2.new(0.5,0,0.5,0),
                    AnchorPoint = Vector2.new(0.5,0.5),
                    TextXAlignment = "Left",
                    TextYAlignment = "Top",
                    TextColor3 = UsingTheme.Text,
                    TextSize = 38,
                    Text = "Executor",
                    Font = GUI_Font .. "Medium",
                    Name = "Executor",
                    Visible = false
                }, {
                    Create("UICorner", {
                        CornerRadius = UDim.new(0, 14)
                    }),
                    Create("UIStroke", {
                        Thickness = 1,
                        Color = UsingTheme.Stroke,
                        Transparency = GUI_StrokeTransparency,
                        ApplyStrokeMode = "Border"
                    }),
                    Create("UIPadding", {
                        PaddingTop = UDim.new(0, 20),
                        PaddingLeft = UDim.new(0, 25),
                        PaddingRight = UDim.new(0, 25),
                        PaddingBottom = UDim.new(0, 20),
                    })
                }),
                -- Script Search
                Create("TextLabel", {
                    BackgroundTransparency = GUI_Transparency -0.2,
                    BackgroundColor3 = UsingTheme.Main,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -40, 1, -40),
                    Position = UDim2.new(0.5,0,0.5,0),
                    AnchorPoint = Vector2.new(0.5,0.5),
                    TextXAlignment = "Left",
                    TextYAlignment = "Top",
                    TextColor3 = UsingTheme.Text,
                    TextSize = 38,
                    Text = "Script Search",
                    Font = GUI_Font .. "Medium",
                    Name = "ScriptSearch",
                    Visible = false
                }, {
                    Create("UICorner", {
                        CornerRadius = UDim.new(0, 14)
                    }),
                    Create("UIStroke", {
                        Thickness = 1,
                        Color = UsingTheme.Stroke,
                        Transparency = GUI_StrokeTransparency,
                        ApplyStrokeMode = "Border"
                    }),
                    Create("UIPadding", {
                        PaddingTop = UDim.new(0, 20),
                        PaddingLeft = UDim.new(0, 25),
                        PaddingRight = UDim.new(0, 25),
                        PaddingBottom = UDim.new(0, 20),
                    })
                }),
                -- Settings
                Create("TextLabel", {
                    BackgroundTransparency = GUI_Transparency -0.2,
                    BackgroundColor3 = UsingTheme.Main,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -40, 1, -40),
                    Position = UDim2.new(0.5,0,0.5,0),
                    AnchorPoint = Vector2.new(0.5,0.5),
                    TextXAlignment = "Left",
                    TextYAlignment = "Top",
                    TextColor3 = UsingTheme.Text,
                    TextSize = 38,
                    Text = "Settings",
                    Font = GUI_Font .. "Medium",
                    Name = "Settings",
                    Visible = false
                }, {
                    Create("UICorner", {
                        CornerRadius = UDim.new(0, 14)
                    }),
                    Create("UIStroke", {
                        Thickness = 1,
                        Color = UsingTheme.Stroke,
                        Transparency = GUI_StrokeTransparency,
                        ApplyStrokeMode = "Border"
                    }),
                    Create("UIPadding", {
                        PaddingTop = UDim.new(0, 20),
                        PaddingLeft = UDim.new(0, 25),
                        PaddingRight = UDim.new(0, 25),
                        PaddingBottom = UDim.new(0, 20),
                    })
                })
            })
        })
    })
    
    --/° Scripts °/--
    
    ScreenGui.OpenButton.MouseButton1Click:Connect(function()
        TweenService:Create(ScreenGui.Frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.4}):Play()
        TweenService:Create(ScreenGui.Frame.Sidebar, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {AnchorPoint = Vector2.new(0,0)}):Play()
    end)
    ScreenGui.Frame.Sidebar.CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(ScreenGui.Frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 1}):Play()
        TweenService:Create(ScreenGui.Frame.Sidebar, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {AnchorPoint = Vector2.new(1,0)}):Play()
    end)
    
    local Navbar = ScreenGui.Frame.Sidebar.Navbar
    local RightFrames = ScreenGui.Frame.RightFrames
    
    for i,b in next, Navbar:GetChildren() do
        if b:IsA("TextButton") then
            b.MouseButton1Click:Connect(function()
                for i,v in next, RightFrames:GetChildren() do
                    v.Visible = false
                    if string.find(v.Name, b.Name) then
                        v.Visible = true
                    end
                end
            end)
            b.MouseButton1Click:Connect(function()
                for i,v in next, Navbar:GetChildren() do 
                    if v:IsA("TextButton") then
                        TweenService:Create(v, TweenInfo.new(0.15), {TextColor3 = UsingTheme.Stroke}):Play()
                        TweenService:Create(v.ImageLabel, TweenInfo.new(0.15), {ImageColor3 = UsingTheme.Stroke}):Play()
                    end
                end
                TweenService:Create(b, TweenInfo.new(0.15), {TextColor3 = UsingTheme.Text}):Play()
                TweenService:Create(b.ImageLabel, TweenInfo.new(0.15), {ImageColor3 = UsingTheme.Text}):Play()
            end)
        end
    end
    
    local Sidebar = script.Parent.Frame.Sidebar
    local RightFrames = script.Parent.Frame.RightFrames
    
    require(13699518434):BlurFrame(Sidebar)
    for i,v in next, RightFrames:GetChildren() do
        require(13699518434):BlurFrame(v)
    end
    
end