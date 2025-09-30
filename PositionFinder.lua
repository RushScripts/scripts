pcall(function()
    if not game:IsLoaded() then
        repeat task.wait() until game:IsLoaded()
    end

    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local character = player.Character
    local hrp = character:WaitForChild("HumanoidRootPart")

    if playerGui:FindFirstChild("ScreenGui") then
        playerGui:FindFirstChild("ScreenGui"):Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local FindPosition = Instance.new("TextButton")
    local Position = Instance.new("TextLabel")

    ScreenGui.Name = "ScreenGui"
    ScreenGui.Parent = playerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.Position = UDim2.new(0.395550072, 0, 0.325163394, 0)
    Frame.Size = UDim2.new(0, 338, 0, 213)

    Title.Name = "Title"
    Title.Parent = Frame
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(0, 338, 0, 50)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "Position Finder"
    Title.TextColor3 = Color3.fromRGB(0, 0, 0)
    Title.TextScaled = true
    Title.TextSize = 14
    Title.TextWrapped = true

    FindPosition.Name = "FindPosition"
    FindPosition.Parent = Frame
    FindPosition.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FindPosition.Position = UDim2.new(0.204142019, 0, 0.727699518, 0)
    FindPosition.Size = UDim2.new(0, 200, 0, 50)
    FindPosition.Font = Enum.Font.SourceSansBold
    FindPosition.Text = "Find Position"
    FindPosition.TextColor3 = Color3.fromRGB(0, 0, 0)
    FindPosition.TextScaled = true
    FindPosition.TextSize = 14
    FindPosition.TextWrapped = true

    Position.Name = "Position"
    Position.Parent = Frame
    Position.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Position.BackgroundTransparency = 1
    Position.Position = UDim2.new(0, 0, 0.380281687, 0)
    Position.Size = UDim2.new(0, 338, 0, 50)
    Position.Font = Enum.Font.SourceSansBold
    Position.Text = "Position: "
    Position.TextColor3 = Color3.fromRGB(0, 0, 0)
    Position.TextScaled = true
    Position.TextSize = 14
    Position.TextWrapped = true

    pcall(function()
        local script = Instance.new("LocalScript", FindPosition)
        script.Parent.MouseButton1Click:Connect(function()
            repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local hrp = player.Character:WaitForChild("HumanoidRootPart")
            Position.Text = tostring(hrp.Position)
            setclipboard(Position.Text)
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
end)
