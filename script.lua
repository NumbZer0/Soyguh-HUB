local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove UI antiga
local oldGui = PlayerGui:FindFirstChild("soyguhMOD")
if oldGui then oldGui:Destroy() end

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "soyguhMOD"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- Função de arrastar
local function makeDraggable(frame)
    local dragging = false
    local dragInput, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            local screenSize = workspace.CurrentCamera.ViewportSize
            local newX = startPos.X.Scale + delta.X / screenSize.X
            local newY = startPos.Y.Scale + delta.Y / screenSize.Y

            local frameSize = frame.Size
            local maxX = 1 - frameSize.X.Scale
            local maxY = 1 - frameSize.Y.Scale

            newX = math.clamp(newX, 0, maxX)
            newY = math.clamp(newY, 0, maxY)

            frame.Position = UDim2.new(newX, 0, newY, 0)
        end
    end)
end

-- UI Principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 250)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)
Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(100, 100, 100)

-- Título
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "soyguhMOD"
title.Position = UDim2.new(0, 0, 0, 0)

-- Tabs
local tabButtons = Instance.new("Frame")
tabButtons.Parent = mainFrame
tabButtons.Size = UDim2.new(1, -20, 0, 35)
tabButtons.Position = UDim2.new(0, 10, 0, 45)
tabButtons.BackgroundTransparency = 1

local stylesTabButton = Instance.new("TextButton")
stylesTabButton.Parent = tabButtons
stylesTabButton.Size = UDim2.new(0.5, -5, 1, 0)
stylesTabButton.Position = UDim2.new(0, 0, 0, 0)
stylesTabButton.Text = "Styles"
stylesTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
stylesTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stylesTabButton.Font = Enum.Font.GothamBold
stylesTabButton.TextSize = 18
Instance.new("UICorner", stylesTabButton).CornerRadius = UDim.new(0, 8)

local vulnTabButton = stylesTabButton:Clone()
vulnTabButton.Parent = tabButtons
vulnTabButton.Position = UDim2.new(0.5, 5, 0, 0)
vulnTabButton.Text = "VULN"

-- Styles Tab
local stylesTab = Instance.new("Frame")
stylesTab.Parent = mainFrame
stylesTab.Size = UDim2.new(1, -20, 1, -90)
stylesTab.Position = UDim2.new(0, 10, 0, 85)
stylesTab.BackgroundTransparency = 1

local masterStyleBtn = Instance.new("TextButton")
masterStyleBtn.Parent = stylesTab
masterStyleBtn.Size = UDim2.new(1, 0, 0, 40)
masterStyleBtn.Position = UDim2.new(0, 0, 0, 0)
masterStyleBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
masterStyleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
masterStyleBtn.Font = Enum.Font.GothamBold
masterStyleBtn.TextSize = 20
masterStyleBtn.Text = "Master Style"
Instance.new("UICorner", masterStyleBtn).CornerRadius = UDim.new(0, 10)

masterStyleBtn.MouseButton1Click:Connect(function()
    pcall(function()
        LocalPlayer.PlayerStats.Style.Value = "Loki"
    end)
end)

local kingStyleBtn = masterStyleBtn:Clone()
kingStyleBtn.Parent = stylesTab
kingStyleBtn.Position = UDim2.new(0, 0, 0, 50)
kingStyleBtn.Text = "King Style"

kingStyleBtn.MouseButton1Click:Connect(function()
    pcall(function()
        LocalPlayer.PlayerStats.Style.Value = "King"
    end)
end)

-- VULN Tab
local vulnTab = Instance.new("Frame")
vulnTab.Parent = mainFrame
vulnTab.Size = stylesTab.Size
vulnTab.Position = stylesTab.Position
vulnTab.BackgroundTransparency = 1
vulnTab.Visible = false

-- No Cooldown
local noCooldown = false
local noCooldownConnection = nil

local noCooldownBtn = Instance.new("TextButton")
noCooldownBtn.Parent = vulnTab
noCooldownBtn.Size = UDim2.new(1, 0, 0, 40)
noCooldownBtn.Position = UDim2.new(0, 0, 0, 0)
noCooldownBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
noCooldownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noCooldownBtn.Font = Enum.Font.GothamBold
noCooldownBtn.TextSize = 20
noCooldownBtn.Text = "No Cooldown [OFF]"
Instance.new("UICorner", noCooldownBtn).CornerRadius = UDim.new(0, 10)

noCooldownBtn.MouseButton1Click:Connect(function()
    noCooldown = not noCooldown
    if noCooldown then
        noCooldownBtn.Text = "No Cooldown [ON]"
        noCooldownBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        noCooldownConnection = RunService.Heartbeat:Connect(function()
            pcall(function()
                for _, v in pairs(LocalPlayer:GetDescendants()) do
                    if v:IsA("NumberValue") and string.lower(v.Name):find("cooldown") then
                        v.Value = 0
                    end
                end
            end)
        end)
    else
        noCooldownBtn.Text = "No Cooldown [OFF]"
        noCooldownBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        if noCooldownConnection then
            noCooldownConnection:Disconnect()
            noCooldownConnection = nil
        end
    end
end)

-- Inf Stamina
local infStamina = false
local infStaminaConnection = nil

local infStaminaBtn = Instance.new("TextButton")
infStaminaBtn.Parent = vulnTab
infStaminaBtn.Size = UDim2.new(1, 0, 0, 40)
infStaminaBtn.Position = UDim2.new(0, 0, 0, 50)
infStaminaBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
infStaminaBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
infStaminaBtn.Font = Enum.Font.GothamBold
infStaminaBtn.TextSize = 20
infStaminaBtn.Text = "Inf Stamina [OFF]"
Instance.new("UICorner", infStaminaBtn).CornerRadius = UDim.new(0, 10)

infStaminaBtn.MouseButton1Click:Connect(function()
    infStamina = not infStamina
    if infStamina then
        infStaminaBtn.Text = "Inf Stamina [ON]"
        infStaminaBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        infStaminaConnection = RunService.Heartbeat:Connect(function()
            pcall(function()
                local stamina = LocalPlayer.PlayerStats:FindFirstChild("Stamina")
                if stamina and stamina:IsA("NumberValue") then
                    stamina.Value = 100
                end
            end)
        end)
    else
        infStaminaBtn.Text = "Inf Stamina [OFF]"
        infStaminaBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        if infStaminaConnection then
            infStaminaConnection:Disconnect()
            infStaminaConnection = nil
        end
    end
end)

-- Sistema de abas
stylesTabButton.MouseButton1Click:Connect(function()
    stylesTab.Visible = true
    vulnTab.Visible = false
    stylesTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    vulnTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

vulnTabButton.MouseButton1Click:Connect(function()
    stylesTab.Visible = false
    vulnTab.Visible = true
    stylesTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    vulnTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)

-- Toggle UI
local toggleFrame = Instance.new("Frame")
toggleFrame.Name = "ToggleFrame"
toggleFrame.Size = UDim2.new(0, 60, 0, 28)
toggleFrame.Position = UDim2.new(0, 20, 0, 20)
toggleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
toggleFrame.BorderSizePixel = 0
toggleFrame.Parent = screenGui
toggleFrame.Active = true
Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0, 14)

local switchBtn = Instance.new("Frame")
switchBtn.Parent = toggleFrame
switchBtn.Size = UDim2.new(1, 0, 1, 0)
switchBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
Instance.new("UICorner", switchBtn).CornerRadius = UDim.new(0, 14)

local toggleCircle = Instance.new("Frame")
toggleCircle.Parent = switchBtn
toggleCircle.Size = UDim2.new(0, 26, 0, 26)
toggleCircle.Position = UDim2.new(0, 2, 0, 1)
toggleCircle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(0, 13)

local uiVisible = true
local function updateToggle()
    if uiVisible then
        switchBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        toggleCircle:TweenPosition(UDim2.new(1, -28, 0, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        mainFrame.Visible = true
    else
        switchBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        toggleCircle:TweenPosition(UDim2.new(0, 2, 0, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        mainFrame.Visible = false
    end
end

switchBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        uiVisible = not uiVisible
        updateToggle()
    end
end)

-- Ativa drag
makeDraggable(mainFrame)
makeDraggable(toggleFrame)

updateToggle()
