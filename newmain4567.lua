
--/° Services °/--
  
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Players = game:GetService("Players")


--/° Variables °/--

local Dozer = {
    Name = "Dozer",
    Themes = {
        Dark = {
            ["Main"] = Color3.fromRGB(16,16,16),
            ["Stroke"] = Color3.fromRGB(174,174,174),
            ["Text"] = Color3.fromRGB(255,255,255),
            ["EditorText"] = Color3.fromRGB(204,204,204)
        }
    },
    SyntaxColor = {
        -- [Color3.fromRGB(131, 241, 132)] = {
        --     "'.-'", '".-"',     I DONT KNOW   WHY IT DOESNT WORK      AAAAAAAAAHHH HELP
        -- }, 
        -- [Color3.fromRGB(248, 109, 124)] = {
        --     [[local]], [[function]], [[return]], [[error]], [[print]], [[self]], [[if]], [[else]], [[elseif]], [[then]], [[end]], [[do]], [[for]], [[break]], [[repeat]], [[until]], [[not]], [[and]]
        -- },
        -- [Color3.fromRGB(255, 198, 0)] = {
        --     [[true]], [[false]], [[nil]], [[warn]],
        -- },
        -- [Color3.fromRGB(253, 251, 172)] = {
        --     [[Connect]], [[WaitForChild]], [[FindFirstChild]], [[GetService]], [[GetDescendants]], [[GetChildren]], [[GetPropertyChangedSignal]], [[loadstring]], [[HttpGet]], [[Create]], [[SendKeyEvent]]
        -- },
        -- [Color3.fromRGB(132, 214, 247)] = {
        --     [[new]], [[game]], [[ipairs]], [[pairs]], [[script]], [[wait]], [[math]], [[random]], [[Instance]], [[Parent]], [[task]], [[table]], [[remove]], [[Size]], [[Position]], [[BackgroundColor3]], [[TextColor3]], [[AnchorPoint]], [[Vector2]], [[Color3]], [[BorderSizePixel]], [[BorderColor3]], [[Thickness]], [[Color]], [[Transparency]], [[BackgroundTransparency]], [[TextTrasparency]], [[TextTruncate]], [[TextWrapped]], [[TextScaled]], [[Text ]], [[TextSize]], [[Font]], [[Active]], [[Name]], [[UDim2]], [[UDim]], [[CanvasSize]], [[CanvasPosition]]
        -- },
        
        -- new ↓
        
        keyword = Color3.fromRGB(248, 109, 124),
        comment = Color3.fromRGB(104,104,104),
        string = Color3.fromRGB(173, 241, 149),
        number = Color3.fromRGB(255, 198, 0),
        
        functionCall = Color3.fromRGB(253, 251, 172)
    }
}

local _version = "1.0.0"

local _fullName = Dozer.Name .. " v" .. _version

local GUI_CurrentTheme = "Dark"
local GUI_Transparency = 0
local GUI_StrokeTransparency = 0.7
local GUI_Font = Font.new("rbxassetid://12187365364")

local Player = Players.LocalPlayer
local PlayerGui = game.CoreGui

local Mouse = Player:GetMouse()

local Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/src/Icons.lua"))().assets
local Changelogs = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlikSusFootages/MyExecutor/main/changelog.lua"))()
local Lexer = loadstring(game:HttpGet("https://raw.githubusercontent.com/lunarmodules/Penlight/master/lua/pl/lexer.lua"))()

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

local function CreateRipple(x, y, button, color)
    local relativeX = x - button.AbsolutePosition.X
    local relativeY = y - button.AbsolutePosition.y
    
    local ripple = Instance.new("Frame")
    ripple.Name = "Ripple"
    ripple.BackgroundColor3 = color
    ripple.BackgroundTransparency = 0.5
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0, relativeX, 0, relativeY)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.ClipsDescendants = true
    ripple.Parent = button

    local rippleCorner = Instance.new("UICorner")
    rippleCorner.CornerRadius = UDim.new(1, 0)
    rippleCorner.Parent = ripple

    local TargetSize = UDim2.new(0, 300, 0, 300)

    local Tween = TweenService:Create(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = TargetSize, BackgroundTransparency = 1})
    Tween:Play()

    Tween.Completed:Connect(function()
        ripple:Destroy()
    end)
end



--/° Main °/--

function Dozer:Start()
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
                        }),
                        Create("Frame",{
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1,0,1,-50),
                            Position = UDim2.new(0,0,1,0),
                            AnchorPoint = Vector2.new(0,1),
                            Name = "Content"
                        }, {
                            Create("Frame", {
                                Size = UDim2.new(1,0,1,-60),
                                BackgroundTransparency = 1,
                            }, {
                                Create("ScrollingFrame", {
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(1,0,1,0),
                                    ElasticBehavior = "Never",
                                    CanvasSize = UDim2.new(0,0,0,0),
                                    ScrollBarThickness = 4,
                                    BorderSizePixel = 0
                                }, {
                                    Create("TextBox", {
                                        BackgroundTransparency = 1,
                                        Size = UDim2.new(1,-30,1,0),
                                        Position = UDim2.new(0,30,0,0),
                                        ClearTextOnFocus = false,
                                        MultiLine = true,
                                        PlaceholderText = "print('Enter your script here!')",
                                        Text = "",
                                        TextColor3 = UsingTheme.EditorText,
                                        TextSize = 15,
                                        Font = "Code",
                                        TextXAlignment = "Left",
                                        TextYAlignment = "Top",
                                        AutomaticSize = "XY",
                                        ShowNativeInput = true,
                                    }),
                                    Create("TextLabel", {
                                        Size = UDim2.new(1,-30,1,0),
                                        Position = UDim2.new(0,30,0,0),
                                        RichText = true,
                                        BackgroundTransparency = 1,
                                        TextSize = 15,
                                        TextColor3 = UsingTheme.EditorText,
                                        Font = "Code",
                                        Text = "",
                                        TextXAlignment = "Left",
                                        TextYAlignment = "Top",
                                    }),
                                    Create("TextLabel", {
                                        Size = UDim2.new(0,15,1,0),
                                        BackgroundTransparency = 1,
                                        TextSize = 15,
                                        TextColor3 = UsingTheme.Stroke,
                                        Font = "Code",
                                        Text = "1",
                                        TextXAlignment = "Right",
                                        TextYAlignment = "Top",
                                        Name = "LineNumbers"
                                    })
                                }),
                                Create("UIPadding", {
                                    PaddingTop = UDim.new(0,12),
                                    PaddingLeft = UDim.new(0,16),
                                    PaddingRight = UDim.new(0,16),
                                    PaddingBottom = UDim.new(0,12),
                                }),
                                Create("Frame", {
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(1, -4+16+16, 1, -4+12+12),
                                    Position = UDim2.fromScale(0.5,0.5),
                                    AnchorPoint = Vector2.new(0.5,0.5),
                                }, {
                                    Create("UIStroke", {
                                        Color = UsingTheme.Stroke,
                                        Thickness = 2,
                                        ApplyStrokeMode = "Border",
                                        Transparency = GUI_StrokeTransparency
                                    }),
                                    Create("UICorner", {
                                        CornerRadius = UDim.new(0, 10)
                                    })
                                }),
                            }),
                            Create("Frame", {
                                Size = UDim2.new(1,0,0,50),
                                BackgroundTransparency = 1,
                                AnchorPoint = Vector2.new(0,1),
                                Position = UDim2.new(0,0,1,0),
                                Name = "BottomFrame"
                            }, {
                                Create("UIListLayout", {
                                    Padding = UDim.new(0,10),
                                    FillDirection = "Horizontal",
                                    SortOrder= "LayoutOrder"
                                }),
                                Create("CanvasGroup", {
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(0.23,-5,1,0),
                                    Name = "Execute"
                                }, {
                                    Create("TextButton", {
                                        Text = "Execute",
                                        Size = UDim2.new(1,0,1,0),
                                        Position = UDim2.new(0,0,1,0),
                                        AnchorPoint = Vector2.new(0,1),
                                        BackgroundColor3 = UsingTheme.Text,
                                        TextColor3 = UsingTheme.Main,
                                        TextSize = 20,
                                        FontFace = GUI_Font,
                                        Name = "Execute",
                                        AutoButtonColor = false,
                                        BorderSizePixel = 0
                                    }),
                                    Create("UICorner", {
                                        CornerRadius = UDim.new(0,12)
                                    })
                                }),
                                Create("CanvasGroup", {
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(0.3,-5,1,0),
                                    Name = "ExecuteClipboard"
                                }, {
                                    Create("TextButton", {
                                        Text = "ExecuteClipboard",
                                        Size = UDim2.new(1,0,1,0),
                                        Position = UDim2.new(0,0,1,0),
                                        AnchorPoint = Vector2.new(0,1),
                                        BackgroundColor3 = UsingTheme.Text,
                                        TextColor3 = UsingTheme.Main,
                                        TextSize = 20,
                                        FontFace = GUI_Font,
                                        Name = "ExecuteClipboard",
                                        AutoButtonColor = false,
                                        BorderSizePixel = 0
                                    }),
                                    Create("UICorner", {
                                        CornerRadius = UDim.new(0,12)
                                    })
                                }),
                                Create("CanvasGroup", {
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(0.23,-5,1,0),
                                    Name = "Clear"
                                }, {
                                    Create("TextButton", {
                                        Text = "Clear",
                                        Size = UDim2.new(1,0,1,0),
                                        Position = UDim2.new(0,0,1,0),
                                        AnchorPoint = Vector2.new(0,1),
                                        BackgroundTransparency = 1,
                                        BackgroundColor3 = UsingTheme.Stroke,
                                        TextColor3 = UsingTheme.Text,
                                        TextSize = 20,
                                        FontFace = GUI_Font,
                                        Name = "Clear",
                                        BorderSizePixel = 0,
                                        AutoButtonColor = false
                                    }, {
                                        Create("Frame", {
                                            Size = UDim2.new(1, -4, 1, -4),
                                            Position = UDim2.fromScale(0.5,0.5),
                                            AnchorPoint = Vector2.new(0.5,0.5),
                                            BackgroundTransparency = 1,
                                        }, {
                                            Create("UICorner", {
                                                CornerRadius = UDim.new(0, 11),
                                            }),
                                            Create("UIStroke", {
                                                Color = UsingTheme.Stroke,
                                                Thickness = 2,
                                                Transparency = GUI_StrokeTransparency,
                                            })
                                        }),
                                    }),
                                    Create("UICorner", {
                                        CornerRadius = UDim.new(0,12)
                                    }),
                                }),
                                Create("CanvasGroup", {
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(0.23,-5,1,0),
                                    Name = "Paste"
                                }, {
                                    Create("TextButton", {
                                        Text = "Paste",
                                        Size = UDim2.new(1,0,1,0),
                                        Position = UDim2.new(0,0,1,0),
                                        AnchorPoint = Vector2.new(0,1),
                                        BackgroundTransparency = 1,
                                        BackgroundColor3 = UsingTheme.Stroke,
                                        TextColor3 = UsingTheme.Text,
                                        TextSize = 20,
                                        FontFace = GUI_Font,
                                        Name = "Paste",
                                        BorderSizePixel = 0,
                                        AutoButtonColor = false
                                    }, {
                                        Create("Frame", {
                                            Size = UDim2.new(1, -4, 1, -4),
                                            Position = UDim2.fromScale(0.5,0.5),
                                            AnchorPoint = Vector2.new(0.5,0.5),
                                            BackgroundTransparency = 1,
                                        }, {
                                            Create("UICorner", {
                                                CornerRadius = UDim.new(0, 11),
                                            }),
                                            Create("UIStroke", {
                                                Color = UsingTheme.Stroke,
                                                Thickness = 2,
                                                Transparency = GUI_StrokeTransparency,
                                            })
                                        }),
                                    }),
                                    Create("UICorner", {
                                        CornerRadius = UDim.new(0,12)
                                    }),
                                }),
                                
                                
                            })
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
                        }),
                        Create("Frame", {
                            Name = "Content",
                            Size = UDim2.new(1,0,1,-50),
                            Position = UDim2.new(0,0,1,0),
                            AnchorPoint = Vector2.new(0,1),
                            BackgroundTransparency = 1,
                        }, {
                            Create("Frame", {
                                Size = UDim2.new(1,-60,0,50),
                                BackgroundTransparency = 1,
                                BorderSizePixel = 0,
                            }, {
                                Create("TextBox", {
                                    Size = UDim2.new(1,-40,1,0),
                                    BackgroundTransparency = 1,
                                    BorderSizePixel = 0,
                                    Text = "",
                                    PlaceholderText = "Enter your script name",
                                    TextColor3 = UsingTheme.Text,
                                    TextSize = 20,
                                    FontFace = GUI_Font,
                                    TextXAlignment = "Left",
                                    ClearTextOnFocus = false,
                                    Position = UDim2.fromScale(0.5,0),
                                    AnchorPoint = Vector2.new(0.5,0)
                                }),
                                Create("UICorner", {
                                    CornerRadius = UDim.new(0,12)
                                }),
                                Create("Frame", {
                                    Size = UDim2.new(1,-4,1,-4),
                                    Position = UDim2.new(0,2,0,2),
                                    BackgroundTransparency = 1,
                                }, {
                                    Create("UIStroke", {
                                        Thickness = 2,
                                        Color = UsingTheme.Stroke,
                                        Transparency = GUI_StrokeTransparency
                                    }),
                                    Create("UICorner", {
                                        CornerRadius = UDim.new(0,10)
                                    })
                                })
                            }),
                            Create("ImageButton", {
                                Image = GetIcon("plus"),
                                BackgroundColor3 = UsingTheme.Text,
                                BorderSizePixel = 0,
                                Size = UDim2.new(0,50,0,50),
                                Position = UDim2.new(1,0,0,0),
                                AnchorPoint = Vector2.new(1,0),
                                ImageColor3 = UsingTheme.Main,
                                ImageRectOffset = Vector2.new(-70,-70),
                                ImageRectSize = Vector2.new(395,395),
                                AutoButtonColor = false,
                                ScaleType = "Slice"
                            }, {
                                Create("UICorner", {
                                    CornerRadius = UDim.new(0,12)
                                })
                            }),
                            Create("Frame", {
                                Size = UDim2.new(1,0,1,-60),
                                Position = UDim2.new(0,0,1,0),
                                AnchorPoint = Vector2.new(0,1),
                                BackgroundTransparency = 1,
                                BorderSizePixel = 0,
                                Name = "Content"
                            }, {
                                Create("ScrollingFrame", {
                                    Size = UDim2.new(1,0,1,0),
                                    CanvasSize = UDim2.new(0,0,0,0),
                                    BackgroundTransparency = 1,
                                    ElasticBehavior = "Never",
                                    ScrollBarThickness = 0,
                                    ScrollingDirection = "Y"
                                }, {
                                    Create("UIListLayout", {
                                        FillDirection = "Vertical",
                                        Padding = UDim.new(0, 8)
                                    })
                                })
                            })
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
                    TextColor3 = UsingTheme.Stroke,
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
        
        -- syntax highlighting

        local function Colorize(keyword, color)
            local color2 = "rgb(" .. math.floor(color.r*255 + 0.5) .. ", " .. math.floor(color.g*255 + 0.5) .. ", " .. math.floor(color.b*255 + 0.5) .. ")"
            return tostring([=[<font color=']=] .. color2 .. [=['>]=] .. keyword .. [=[</font>]=])
        end
        
        
        local Executorr = RightFrames.Executor.Content.Frame
        
        Executorr.ScrollingFrame.TextBox:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            local TextBoxXSize = (Executorr.ScrollingFrame.TextBox.AbsoluteSize.X)
            Executorr.ScrollingFrame.CanvasSize = UDim2.new(0,(TextBoxXSize), 0, Executorr.ScrollingFrame.TextBox["AbsoluteSize"]["Y"])
            
        end)
        
        
        Executorr.ScrollingFrame.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
            local formatedText = Executorr.ScrollingFrame.TextBox.Text
            for token, src in Lexer.lua(Executorr.ScrollingFrame.TextBox.Text) do
                if Dozer.SyntaxColor[token] then
                    formatedText = string.gsub(formatedText, src, function()
                        return Colorize(src, Dozer.SyntaxColor[token])
                    end)
                elseif string.match(formatedText, "^%w+%s*%(.-%)$") then
                    formatedText = string.gsub(formatedText, src, function()
                        return Colorize(src, Dozer.SyntaxColor["functionCall"])
                    end)
                end
            end
            
            Executorr.ScrollingFrame.TextLabel.Text = formatedText
            
            --LineNumbers
            local liness = Executorr.ScrollingFrame.TextBox.Text:split("\n")
            local numberText = ""
            for i=1, #liness do
                numberText = numberText .. i .. "\n"
                if i > 100 or i < 1000 then
                    Executorr.ScrollingFrame.LineNumbers.Size = UDim2.new(0,25,1,0)
                    Executorr.ScrollingFrame.TextLabel.Size = UDim2.new(1,-40,1,0)
                    Executorr.ScrollingFrame.TextLabel.Position = UDim2.new(0,40,0,0)
                    Executorr.ScrollingFrame.TextBox.Size = UDim2.new(1,-40,1,0)
                    Executorr.ScrollingFrame.TextBox.Position = UDim2.new(0,40,0,0)
                elseif i > 1000 then
                    Executorr.ScrollingFrame.LineNumbers.Size = UDim2.new(0,35,1,0)
                    Executorr.ScrollingFrame.TextLabel.Size = UDim2.new(1,-50,1,0)
                    Executorr.ScrollingFrame.TextLabel.Position = UDim2.new(0,50,0,0)
                    Executorr.ScrollingFrame.TextBox.Size = UDim2.new(1,-50,1,0)
                    Executorr.ScrollingFrame.TextBox.Position = UDim2.new(0,50,0,0)
                elseif i < 100 then
                    Executorr.ScrollingFrame.LineNumbers.Size = UDim2.new(0,15,1,0)
                    Executorr.ScrollingFrame.TextLabel.Size = UDim2.new(1,-30,1,0)
                    Executorr.ScrollingFrame.TextLabel.Position = UDim2.new(0,15,0,0)
                    Executorr.ScrollingFrame.TextBox.Size = UDim2.new(1,-30,1,0)
                    Executorr.ScrollingFrame.TextBox.Position = UDim2.new(0,30,0,0)
                end
            end
            Executorr.ScrollingFrame.LineNumbers.Text = numberText
        end)
        
        Executorr.ScrollingFrame.TextBox.Focused:Connect(function()
            TweenService:Create(Executorr.Frame.UIStroke, TweenInfo.new(0.15), {Transparency = 0}):Play()
            Executorr.ScrollingFrame.TextLabel.Visible = false
        end)
        Executorr.ScrollingFrame.TextBox.FocusLost:Connect(function()
            TweenService:Create(Executorr.Frame.UIStroke, TweenInfo.new(0.15), {Transparency = GUI_StrokeTransparency}):Play()
            Executorr.ScrollingFrame.TextLabel.Visible = true
        end)
        
        
        local ExecutorButtons = Executorr.Parent.BottomFrame
        
        ExecutorButtons.Execute.Execute.MouseButton1Click:Connect(function()
            runcode(Executorr.ScrollingFrame.TextBox.Text)
        end)
        ExecutorButtons.ExecuteClipboard.ExecuteClipboard.MouseButton1Click:Connect(function()
            executeclipboard()
        end)
        
        ExecutorButtons.Clear.Clear.MouseButton1Click:Connect(function()
            Executorr.ScrollingFrame.TextBox.Text = ""
            Executorr.ScrollingFrame.CanvasPosition = Vector2.new(0,0)
        end)
        ExecutorButtons.Paste.Paste.MouseButton1Click:Connect(function()
            Executorr.ScrollingFrame.TextBox.Text = fromclipboard()
        end)
        
        for _, Button in pairs(ExecutorButtons:GetChildren()) do
            if Button.Name == "Clear" or Button.Name == "Paste" then
                ExecutorButtons[Button.Name][Button.Name].MouseEnter:Connect(function()
                    TweenService:Create(ExecutorButtons[Button.Name][Button.Name], TweenInfo.new(0.15), {BackgroundTransparency = .7}):Play()
                end)
                ExecutorButtons[Button.Name][Button.Name].MouseLeave:Connect(function()
                    TweenService:Create(ExecutorButtons[Button.Name][Button.Name], TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
                end)
                ExecutorButtons[Button.Name][Button.Name].MouseButton1Click:Connect(function()
                    CreateRipple(Mouse.X, Mouse.Y, ExecutorButtons[Button.Name], UsingTheme.Text)
                end)
            elseif Button.Name == "Execute" or Button.Name == "ExecuteClipboard" then
                ExecutorButtons[Button.Name][Button.Name].MouseEnter:Connect(function()
                    TweenService:Create(ExecutorButtons[Button.Name][Button.Name], TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(Button[Button.Name].BackgroundColor3.r*255 -55, Button[Button.Name].BackgroundColor3.g*255 -55, Button[Button.Name].BackgroundColor3.b*255 -55)}):Play()
                end)
                ExecutorButtons[Button.Name][Button.Name].MouseLeave:Connect(function()
                    TweenService:Create(ExecutorButtons[Button.Name][Button.Name], TweenInfo.new(0.15), {BackgroundColor3 = UsingTheme.Text}):Play()
                end)
                ExecutorButtons[Button.Name][Button.Name].MouseButton1Click:Connect(function()
                    CreateRipple(Mouse.X, Mouse.Y, ExecutorButtons[Button.Name], UsingTheme.Main)
                end)
            end
        end
        
        
        local SavedScriptss = RightFrames.SavedScripts.Content
        
        SavedScriptss.Content.ScrollingFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            SavedScriptss.Content.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, SavedScriptss.Content.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)
        end)
        
        if #GUI_Settings.Scripts < 1 then
            local NoScriptMessage = Create("TextLabel", {
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                FontFace = GUI_Font,
                Text = "No scripts founded. Add a new script",
                TextColor3 = UsingTheme.Stroke,
                TextSize = 20,
                Parent = SavedScriptss.Content.ScrollingFrame
            })
        else
            for name, script in pairs(GUI_Settings.Scripts) do
                local ScriptCard = Create("TextLabel", {
                    Size = UDim2.new(1,0,0,60),
                    BackgroundTransparency = 1,
                    Text = name,
                    TextSize = 20,
                    TextColor3 = UsingTheme.Text,
                    TextXAlignment = "Left",
                    Parent = SavedScriptss.Content.ScrollingFrame
                }, {
                    Create("UIPadding", {
                        PaddingLeft = UDim.new(0, 16),
                        PaddingRight = UDim.new(0, 16),
                    })
                })
            end
        end
        
        SavedScriptss.Content.ImageButton.MouseButton1Click:Connect(function()
            CreateRipple(Mouse.X, Mouse.Y, SavedScriptss.Content.ImageButton, UsingTheme.Main)
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

Dozer:Start()

return Dozer