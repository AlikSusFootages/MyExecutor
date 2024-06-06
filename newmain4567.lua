
--/° Services °/--
  
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Players = game:GetService("Players")
local Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/src/Icons.lua"))().assets
local Changelogs = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlikSusFootages/MyExecutor/main/changelog.lua"))()

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
local GUI_Font = Font.new("rbxassetid://12187365364")

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
else
    GUI_Settings = HttpService:JSONDecode(readfile("Dozer/Settings.json"))
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

function Start()
    if game:isLoaded() then
        print(" ------ /° Dozer Executor started! °/ ------ ")
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
                Text = "Open",
                FontFace = GUI_Font
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
                        FontFace = GUI_Font ,
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
                            FontFace = GUI_Font,
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
                            FontFace = GUI_Font,
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
                            FontFace = GUI_Font,
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
                            FontFace = GUI_Font,
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
                            Text = "Saved Scripts",
                            Name = "SavedScripts",
                            TextColor3 = UsingTheme.Stroke,
                            TextSize = 22,
                            FontFace = GUI_Font,
                            Size = UDim2.new(1,0,0,26),
                            BackgroundTransparency = 1,
                            TextXAlignment = "Left"
                        }, {
                            Create("UIPadding", {
                                PaddingLeft = UDim.new(0,32)
                            }),
                            Create("ImageLabel", {
                                Size = UDim2.fromOffset(24,24), 
                                Image = "rbxassetid://17754257335",
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
                            FontFace = GUI_Font,
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
                            FontFace = GUI_Font,
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
                    AnchorPoint = Vector2.new(1,1),
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
                        FontFace = GUI_Font ,
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
                            PaddingTop = UDim.new(0, 25),
                            PaddingLeft = UDim.new(0, 30),
                            PaddingRight = UDim.new(0, 30),
                            PaddingBottom = UDim.new(0, 25),
                        }),
                        Create("Frame", {
                            Name = "Content",
                            Size = UDim2.new(1,0,1,-50),
                            Position = UDim2.new(0,0,1,0),
                            AnchorPoint = Vector2.new(0,1),
                            BackgroundTransparency = 1,
                        }, {
                            Create("Frame", {
                                Name = "Left",
                                Size = UDim2.new(0.5,-20,1,0),
                                BackgroundTransparency = 1,
                            }, {
                                Create("TextLabel", {
                                    Text = "Server Statistics",
                                    TextSize = 26,
                                    TextColor3 = UsingTheme.Text,
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(1,0,0,21),
                                    FontFace = GUI_Font ,
                                    TextXAlignment = "Left",
                                    TextYAlignment = "Top",
                                }),
                                Create("TextLabel", {
                                    Text = "Ping",
                                    TextSize = 20,
                                    TextColor3 = UsingTheme.Text,
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(1,0,0,32),
                                    FontFace = GUI_Font,
                                    TextXAlignment = "Left",
                                    TextYAlignment = "Top",
                                    Position = UDim2.new(0,0,0,36)
                                }),
                                Create("TextLabel", {
                                    Text = "",
                                    TextSize = 20,
                                    TextColor3 = UsingTheme.Stroke,
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(1,0,0,32),
                                    FontFace = GUI_Font,
                                    TextXAlignment = "Right",
                                    TextYAlignment = "Top",
                                    Position = UDim2.new(0,0,0,36),
                                    Name = "PingText",
                                }),
                                Create("TextLabel", {
                                    Text = "FPS",
                                    TextSize = 20,
                                    TextColor3 = UsingTheme.Text,
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(1,0,0,20),
                                    FontFace = GUI_Font,
                                    TextXAlignment = "Left",
                                    TextYAlignment = "Top",
                                    Position = UDim2.new(0,0,0,58)
                                }),
                                Create("TextLabel", {
                                    Text = "",
                                    TextSize = 20,
                                    TextColor3 = UsingTheme.Stroke,
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(1,0,0,20),
                                    FontFace = GUI_Font,
                                    TextXAlignment = "Right",
                                    TextYAlignment = "Top",
                                    Position = UDim2.new(0,0,0,58),
                                    Name = "FPSText",
                                }),
                                Create("TextLabel", {
                                    Text = "Players Amount",
                                    TextSize = 20,
                                    TextColor3 = UsingTheme.Text,
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(1,0,0,20),
                                    FontFace = GUI_Font,
                                    TextXAlignment = "Left",
                                    TextYAlignment = "Top",
                                    Position = UDim2.new(0,0,0,80)
                                }),
                                Create("TextLabel", {
                                    Text = "",
                                    TextSize = 20,
                                    TextColor3 = UsingTheme.Stroke,
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(1,0,0,20),
                                    FontFace = GUI_Font,
                                    TextXAlignment = "Right",
                                    TextYAlignment = "Top",
                                    Position = UDim2.new(0,0,0,80),
                                    Name = "PlayersText",
                                }),
                            }),
                            Create("Frame", {
                                Name = "Right",
                                Size = UDim2.new(0.5,-20,1,0),
                                BackgroundTransparency = 1,
                                Position = UDim2.new(1,0,0,0),
                                AnchorPoint = Vector2.new(1,0)
                            }, {
                                Create("TextLabel", {
                                    Text = "Changelogs",
                                    TextColor3 = UsingTheme.Text,
                                    FontFace = GUI_Font ,
                                    TextSize = 26,
                                    TextXAlignment = "Left",
                                    TextYAlignment = "Top",
                                    BackgroundTransparency = 1,
                                }),
                                Create("Frame", {
                                    Size = UDim2.new(1,0,1,-36),
                                    Position = UDim2.fromScale(0,1),
                                    AnchorPoint = Vector2.new(0,1),
                                    BackgroundTransparency = 1,
                                    Name = "Content"
                                }, {
                                    Create("ScrollingFrame", {
                                        CanvasSize = UDim2.new(1,0,1,0),
                                        Size = UDim2.new(1,0,1,0),
                                        BackgroundTransparency = 1,
                                        ElasticBehavior = "Never",
                                        ScrollingDirection = "Y",
                                        ScrollBarThickness = 0
                                    }, {
                                        Create("UIListLayout", {
                                            FillDirection = "Vertical",
                                            Padding = UDim.new(0,8),
                                            SortOrder = "Name"
                                        })
                                    })
                                })
                            })
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
                        FontFace = GUI_Font ,
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
                            PaddingTop = UDim.new(0, 25),
                            PaddingLeft = UDim.new(0, 30),
                            PaddingRight = UDim.new(0, 30),
                            PaddingBottom = UDim.new(0, 25),
                        })
                    }),
                    -- Saved Scripts
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
                        Text = "Saved Scripts",
                        FontFace = GUI_Font ,
                        Name = "SavedScripts",
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
                            PaddingTop = UDim.new(0, 25),
                            PaddingLeft = UDim.new(0, 30),
                            PaddingRight = UDim.new(0, 30),
                            PaddingBottom = UDim.new(0, 25),
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
                        FontFace = GUI_Font ,
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
                            PaddingTop = UDim.new(0, 25),
                            PaddingLeft = UDim.new(0, 30),
                            PaddingRight = UDim.new(0, 30),
                            PaddingBottom = UDim.new(0, 25),
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
                        FontFace = GUI_Font ,
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
                            PaddingTop = UDim.new(0, 25),
                            PaddingLeft = UDim.new(0, 30),
                            PaddingRight = UDim.new(0, 30),
                            PaddingBottom = UDim.new(0, 25),
                        })
                    })
                })
            })
        })
        
        --/° Scripts °/--
        local Navbar = ScreenGui.Frame.Sidebar.Navbar
        local RightFrames = ScreenGui.Frame.RightFrames
        
        
        ScreenGui.OpenButton.MouseButton1Click:Connect(function()
            TweenService:Create(ScreenGui.Frame, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.4}):Play()
            TweenService:Create(ScreenGui.Frame.Sidebar, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {AnchorPoint = Vector2.new(0,0)}):Play()
            TweenService:Create(RightFrames, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {AnchorPoint = Vector2.new(1,0)}):Play()
        end)
        ScreenGui.Frame.Sidebar.CloseButton.MouseButton1Click:Connect(function()
            TweenService:Create(ScreenGui.Frame, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {BackgroundTransparency = 1}):Play()
            TweenService:Create(ScreenGui.Frame.Sidebar, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {AnchorPoint = Vector2.new(1,0)}):Play()
            TweenService:Create(RightFrames, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {AnchorPoint = Vector2.new(1,1)}):Play()
        end)
        
        
        for i,b in next, Navbar:GetChildren() do
            if b:IsA("TextButton") then
                b.MouseButton1Click:Connect(function()
                    for i,v in next, RightFrames:GetChildren() do
                        v.Visible = false
                        v.Position = UDim2.new(0.5, 50, 0.5,0)
                        if string.find(v.Name, b.Name) then
                            TweenService:Create(v, TweenInfo.new(0.2), {Position = UDim2.fromScale(0.5,0.5)}):Play()
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
        
        local LeftFramess = RightFrames.Info.Content.Left
        
        
        local RightFramesss = RightFrames.Info.Content.Right.Content.ScrollingFrame
        
        local order = 0
        for version, content in pairs(Changelogs) do
            local changelog = Create("TextLabel", {
                Parent = RightFramesss,
                Size = UDim2.new(1,0,0,0),
                Text = "v" .. version,
                TextYAlignment = "Top",
                TextXAlignment = "Left",
                TextColor3 = UsingTheme.Text,
                BackgroundTransparency = 1,
                TextSize = 20,
                FontFace = GUI_Font,
                AutomaticSize = "Y",
                Name = order
            }, {
                Create("TextLabel", {
                    Text = content.Date,
                    TextXAlignment = "Right",
                    TextYAlignment = "Top",
                    TextColor3 = UsingTheme.Stroke,
                    TextSize = 20,
                    Size = UDim2.new(1,0,1,0),
                    BackgroundTransparency = 1,
                    FontFace = GUI_Font,
                    AutomaticSize = "Y",
                    Name = "Version"
                }),
                Create("TextLabel", {
                    Text = content.Title,
                    TextXAlignment = "Left",
                    TextYAlignment = "Top",
                    TextSize = 20,
                    FontFace = GUI_Font,
                    TextColor3 = UsingTheme.Text,
                    Size = UDim2.new(1,0,0,0),
                    Position = UDim2.new(0,0,0,22),
                    AnchorPoint = Vector2.new(0,0),
                    BackgroundTransparency = 1,
                    AutomaticSize = "Y",
                    Name = "Title"
                }),
                Create("TextLabel", {
                    Text = content.Content,
                    TextXAlignment = "Left",
                    TextYAlignment = "Top",
                    TextSize = 18,
                    FontFace = GUI_Font,
                    TextColor3 = UsingTheme.Text,
                    Size = UDim2.new(1,0,0,0),
                    Position = UDim2.new(0,0,0,0),
                    AnchorPoint = Vector2.new(0,0),
                    BackgroundTransparency = 1,
                    AutomaticSize = "Y",
                    Name = "Content"
                })
            })
            changelog.Title:GetPropertyChangedSignal("TextBounds"):Connect(function()
                changelog.Title.Size = UDim2.new(1,0,0, changelog.Title.TextBounds.Y)
                changelog.Content.Position = UDim2.new(0,0,0, changelog.Title.TextBounds.Y + 24)
            end)
            changelog.Content:GetPropertyChangedSignal("TextBounds"):Connect(function()
                changelog.Content.Size = UDim2.new(1,0,0, changelog.Content.TextBounds.Y)
            end)
            order = order + 1
        end
        
        RightFramesss.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            RightFramesss.CanvasSize = UDim2.new(0,0,0, RightFramesss.UIListLayout.AbsoluteContentSize.Y)
        end)
        
        while wait(0.1) do
            local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            LeftFramess.PingText.Text = math.floor(ping + 0.5) .. "ms"
            
            local fps = 1 / RunService.RenderStepped:Wait()
            LeftFramess.FPSText.Text = math.floor(fps)
            
            local playersAmount = #Players:GetPlayers()
            LeftFramess.PlayersText.Text = playersAmount
        end
    end
end

Start()