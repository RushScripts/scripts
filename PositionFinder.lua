pcall(function()
    if not game:IsLoaded() then
        repeat task.wait() until game:IsLoaded()
    end

    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

    if playerGui:FindFirstChild("PositionFinderGui") then
        playerGui.PositionFinderGui:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PositionFinderGui"
    ScreenGui.Parent = playerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Frame = Instance.new("Frame")
    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.Position = UDim2.new(0.395, 0, 0.325, 0)
    Frame.Size = UDim2.new(0, 338, 0, 213)

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Frame
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(0, 338, 0, 50)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "Position Finder"
    Title.TextColor3 = Color3.fromRGB(0, 0, 0)
    Title.TextScaled = true

    local FindPosition = Instance.new("TextButton")
    FindPosition.Name = "FindPosition"
    FindPosition.Parent = Frame
    FindPosition.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FindPosition.Position = UDim2.new(0.204, 0, 0.728, 0)
    FindPosition.Size = UDim2.new(0, 200, 0, 50)
    FindPosition.Font = Enum.Font.SourceSansBold
    FindPosition.Text = "Find Position"
    FindPosition.TextColor3 = Color3.fromRGB(0, 0, 0)
    FindPosition.TextScaled = true

    local Position = Instance.new("TextLabel")
    Position.Name = "Position"
    Position.Parent = Frame
    Position.BackgroundTransparency = 1
    Position.Position = UDim2.new(0, 0, 0.38, 0)
    Position.Size = UDim2.new(0, 338, 0, 50)
    Position.Font = Enum.Font.SourceSansBold
    Position.Text = "Position: "
    Position.TextColor3 = Color3.fromRGB(0, 0, 0)
    Position.TextScaled = true

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ScreenGui
    ToggleButton.AnchorPoint = Vector2.new(0.5, 0.5)
    ToggleButton.Position = UDim2.new(0.9, 0, 0.2, 0)
    ToggleButton.Size = UDim2.new(0, 60, 0, 60)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    ToggleButton.Font = Enum.Font.SourceSansBold
    ToggleButton.Text = "ON"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextScaled = true
    ToggleButton.AutoButtonColor = true
    ToggleButton.ClipsDescendants = true
    ToggleButton.TextWrapped = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = ToggleButton

    local toggled = true

    ToggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            ToggleButton.Text = "ON"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            Frame.Visible = true
        else
            ToggleButton.Text = "OFF"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
            Frame.Visible = false
        end
    end)

    pcall(function()
        local script = Instance.new("LocalScript", FindPosition)
        script.Parent.MouseButton1Click:Connect(function()
            repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local hrp = player.Character:WaitForChild("HumanoidRootPart")
            Position.Text = tostring(hrp.Position)
            local code = "game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(" .. tostring(hrp.Position) .. ")"
            setclipboard(code)
        end)
    end)

    pcall(function()
        local script = Instance.new("LocalScript", Frame)
        local UIS = game:GetService("UserInputService")
        local frame = script.Parent
        local dragToggle, dragStart, startPos
        local dragSpeed = 0.35
        local function updateInput(input)
            local delta = input.Position - dragStart
            local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            game:GetService("TweenService"):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
        end
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragToggle = true
                dragStart = input.Position
                startPos = frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragToggle = false
                    end
                end)
            end
        end)
        UIS.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                if dragToggle then
                    updateInput(input)
                end
            end
        end)
    end)

    pcall(function()
        local script = Instance.new("LocalScript", ToggleButton)
        local UIS = game:GetService("UserInputService")
        local frame = script.Parent
        local dragToggle, dragStart, startPos
        local dragSpeed = 0.35
        local function updateInput(input)
            local delta = input.Position - dragStart
            local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            game:GetService("TweenService"):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
        end
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragToggle = true
                dragStart = input.Position
                startPos = frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragToggle = false
                    end
                end)
            end
        end)
        UIS.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                if dragToggle then
                    updateInput(input)
                end
            end
        end)
    end)
end)
