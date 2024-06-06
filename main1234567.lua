
local ColorsLoadstring = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlikSusFootages/Tailwindcss-Roblox/main/colors.lua"))()
local Root = script.Parent
local NewGui = require(Root.newmain4567)

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui

local name = "Dozer v0.0.1 BETA"

local openButton = Instance.new("TextButton", gui)
openButton.BackgroundColor3 = Color3.fromRGB(200,200,200)
openButton.Size = UDim2.new(0,50,0,30)
openButton.Text = "Open"

getgenv().identifyexecutor = function() return name end
getgenv().getexecutorname = function() return name end

local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 400, 0, 300)
menu.Position = UDim2.new(0, 0, 0, 0)
menu.BackgroundColor3 = ColorsLoadstring.indigo["600"].RGB
menu.Active = true
menu.Draggable = true
menu.Parent = gui
menu.Visible = false

local clicked = false
openButton.MouseButton1Click:Connect(function()
    if clicked == false then
        menu.Visible = true
        clicked = true
    else
        menu.Visible = false
        clicked = false
    end
end)

local text = Instance.new("TextLabel")
text.TextSize = 15
text.Position = UDim2.new(0, 110, 0, 20)
text.Text = "MrAlikSus's executor"
text.BackgroundTransparency = 1
text.TextColor3 = ColorsLoadstring.white.RGB
text.Parent = menu

local textbox = Instance.new("TextBox")
textbox.Size = UDim2.new(0, 380, 0, 230)
textbox.Position = UDim2.new(0, 10, 0, 60)
textbox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
textbox.Active = true
textbox.Parent = menu
textbox.TextSize = 20
textbox.TextXAlignment = "Left"
textbox.TextYAlignment = "Top"
textbox.Font = "Code"
textbox.PlaceholderText = "Вставьте ваш текст"
textbox.TextColor3 = Color3.fromRGB(178, 178, 178)
textbox.ClearTextOnFocus = false
textbox.Text = ""
textbox.TextWrapped = true
textbox.MultiLine = true

local padding = Instance.new("UIPadding", textbox)
padding.PaddingTop = UDim.new(0, 6)
padding.PaddingLeft = UDim.new(0, 10)
padding.PaddingRight = UDim.new(0, 10)
padding.PaddingBottom = UDim.new(0, 6)

local execute = Instance.new("TextButton")
execute.Size = UDim2.new(0, 100, 0, 50)
execute.Position = UDim2.new(0, 0, 0, 305)
execute.BackgroundColor3 = ColorsLoadstring.indigo["600"].RGB
execute.Text = "Execute"
execute.TextColor3 = ColorsLoadstring.white.RGB
execute.Active = true
execute.Parent = menu

local clear = Instance.new("TextButton")
clear.Size = UDim2.new(0, 100, 0, 50)
clear.Position = UDim2.new(0, 110, 0, 305)
clear.BackgroundColor3 = ColorsLoadstring.indigo["600"].RGB
clear.TextColor3 = ColorsLoadstring.white.RGB
clear.Text = "Clear"
clear.Active = true
clear.Parent = menu

local paste = Instance.new("TextButton")
paste.Size = UDim2.new(0, 100, 0, 50)
paste.Position = UDim2.new(0, 220, 0, 305)
paste.BackgroundColor3 = ColorsLoadstring.indigo["600"].RGB
paste.Text = "Execute clipboard"
paste.TextColor3 = ColorsLoadstring.white.RGB
paste.Active = true
paste.Parent = menu


local corner1 = Instance.new("UICorner")
corner1.CornerRadius = UDim.new(0, 5)
corner1.Parent = menu

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0, 5)
corner2.Parent = textbox

local corner3 = Instance.new("UICorner")
corner3.CornerRadius = UDim.new(0, 5)
corner3.Parent = execute

local corner4 = Instance.new("UICorner")
corner4.CornerRadius = UDim.new(0, 5)
corner4.Parent = clear

local corner5 = Instance.new("UICorner")
corner5.CornerRadius = UDim.new(0, 5)
corner5.Parent = paste



local menuu = menu
local textBox = textbox
local executeButton = execute
local clearr = clear

local function executeScript()
    local scriptText = textBox.Text
    
    -- Запускаем скрипт, введенный в текстовое поле
    local success, result = pcall(function()
        return loadstring(scriptText)()
    end)
    
    -- Если скрипт завершился с ошибкой, выводим сообщение об ошибке
    if not success then
        warn("Error executing script: " .. result)
    end
end

executeButton.MouseButton1Click:Connect(executeScript)


local function clearText()
    game.CoreGui.ScreenGui.Frame.TextBox.Text = ""
end

clearr.MouseButton1Click:Connect(clearText)

paste.MouseButton1Click:Connect(function()
    executeclipboard()
end)