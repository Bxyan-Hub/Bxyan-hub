-- Servicios necesarios
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Crear la ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BxyanHubGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Marco principal (Ancho y compacto)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 140)
mainFrame.Position = UDim2.new(0.5, -160, 0.3, -70)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
mainFrame.BorderSizePixel = 2
mainFrame.Parent = screenGui

local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 10)
cornerMain.Parent = mainFrame

-- Fondo con puntos rojos neón
local backgroundPattern = Instance.new("Folder")
backgroundPattern.Name = "NeonDots"
backgroundPattern.Parent = mainFrame

math.randomseed(tick())
for i = 1, 15 do
	local dot = Instance.new("Frame")
	dot.Size = UDim2.new(0, 3, 0, 3)
	dot.Position = UDim2.new(math.random(5, 95) / 100, 0, math.random(10, 90) / 100, 0)
	dot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	dot.BorderSizePixel = 0
	dot.Parent = backgroundPattern

	local dotCorner = Instance.new("UICorner")
	dotCorner.CornerRadius = UDim.new(1, 0)
	dotCorner.Parent = dot
end

-- Título
local titleShadow = Instance.new("TextLabel")
titleShadow.Size = UDim2.new(1, 0, 0, 25)
titleShadow.Position = UDim2.new(0, 2, 0, 2)
titleShadow.BackgroundTransparency = 1
titleShadow.Text = "Bxyan Hub 😶‍🌫️"
titleShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
titleShadow.TextSize = 14
titleShadow.Font = Enum.Font.SourceSansBold
titleShadow.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 25)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Bxyan Hub 😶‍🌫️"
titleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = mainFrame

-- Arrastrar ventana en celular
local dragging, dragInput, dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(
			startPos.X.Scale, 
			startPos.X.Offset + delta.X, 
			startPos.Y.Scale, 
			startPos.Y.Offset + delta.Y
		)
	end
end)

local btnWidth = 140
local btnHeight = 32

-- Botón 1: Teacher Esp
local btnTeacher = Instance.new("TextButton")
btnTeacher.Name = "TeacherEspBtn"
btnTeacher.Size = UDim2.new(0, btnWidth, 0, btnHeight)
btnTeacher.Position = UDim2.new(0, 15, 0, 35)
btnTeacher.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btnTeacher.BorderColor3 = Color3.fromRGB(255, 0, 0)
btnTeacher.Text = "Teacher: OFF"
btnTeacher.TextColor3 = Color3.fromRGB(255, 255, 255)
btnTeacher.TextSize = 13
btnTeacher.Font = Enum.Font.SourceSansBold
btnTeacher.Parent = mainFrame

local cornerBtn1 = Instance.new("UICorner")
cornerBtn1.CornerRadius = UDim.new(0, 5)
cornerBtn1.Parent = btnTeacher

-- Botón 2: Copy Alert
local btnCopyAlert = Instance.new("TextButton")
btnCopyAlert.Name = "CopyAlertBtn"
btnCopyAlert.Size = UDim2.new(0, btnWidth, 0, btnHeight)
btnCopyAlert.Position = UDim2.new(1, -15 - btnWidth, 0, 35)
btnCopyAlert.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btnCopyAlert.BorderColor3 = Color3.fromRGB(255, 0, 0)
btnCopyAlert.Text = "Alert: OFF"
btnCopyAlert.TextColor3 = Color3.fromRGB(255, 255, 255)
btnCopyAlert.TextSize = 13
btnCopyAlert.Font = Enum.Font.SourceSansBold
btnCopyAlert.Parent = mainFrame

local cornerBtn2 = Instance.new("UICorner")
cornerBtn2.CornerRadius = UDim.new(0, 5)
cornerBtn2.Parent = btnCopyAlert

-- Etiqueta de estado inferior
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 80)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Estado: Inactivo"
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.TextSize = 13
statusLabel.Font = Enum.Font.SourceSansItalic
statusLabel.Parent = mainFrame

-- Etiqueta de Alerta superior ("Copy" / "Alert No copy")
local alertTextLabel = Instance.new("TextLabel")
alertTextLabel.Name = "CopyAlertDisplay"
alertTextLabel.Size = UDim2.new(0, 300, 0, 40)
alertTextLabel.Position = UDim2.new(0.5, -150, 0, 15)
alertTextLabel.BackgroundTransparency = 1
alertTextLabel.Text = ""
alertTextLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
alertTextLabel.TextSize = 22
alertTextLabel.Font = Enum.Font.SourceSansBold
alertTextLabel.Visible = false
alertTextLabel.Parent = screenGui

----------------------------------------------------
-- TEACHER ESP
----------------------------------------------------
local teacherEspEnabled = false

btnTeacher.MouseButton1Click:Connect(function()
	teacherEspEnabled = not teacherEspEnabled
	if teacherEspEnabled then
		btnTeacher.Text = "Teacher: ON"
		btnTeacher.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
		statusLabel.Text = "Estado: ESP Profesor Activo"
	else
		btnTeacher.Text = "Teacher: OFF"
		btnTeacher.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		statusLabel.Text = "Estado: Inactivo"
		for _, obj in pairs(Workspace:GetDescendants()) do
			if obj.Name == "TeacherHighlight" then
				obj:Destroy()
			end
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if teacherEspEnabled then
		for _, obj in pairs(Workspace:GetDescendants()) do
			if obj:IsA("Model") and (obj:FindFirstChild("Humanoid")) and (string.match(obj.Name:lower(), "teacher") or string.match(obj.Name:lower(), "profesor")) then
				if not obj:FindFirstChild("TeacherHighlight") then
					local highlight = Instance.new("Highlight")
					highlight.Name = "TeacherHighlight"
					highlight.Adornee = obj
					highlight.FillColor = Color3.fromRGB(255, 0, 0)
					highlight.FillTransparency = 0.5
					highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
					highlight.OutlineTransparency = 0
					highlight.Parent = obj
				end
			end
		end
	end
end)

----------------------------------------------------
-- DETECTOR DE RADAR / MIRADA DEL PROFESOR
----------------------------------------------------
local function isTeacherLookingAtPlayer()
	local character = player.Character
	if not character or not character:FindFirstChild("HumanoidRootPart") then return false end
	local rootPart = character.HumanoidRootPart

	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and (string.match(obj.Name:lower(), "teacher") or string.match(obj.Name:lower(), "profesor")) then
			local teacherRoot = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
			if teacherRoot then
				local distance = (teacherRoot.Position - rootPart.Position).Magnitude
				if distance < 35 then
					local lookVector = teacherRoot.CFrame.LookVector
					local directionToPlayer = (rootPart.Position - teacherRoot.Position).Unit
					local dotProd = lookVector:Dot(directionToPlayer)
					if dotProd > 0.25 then
						return true 
					end
				end
			end
		end
	end
	return false
end

----------------------------------------------------
-- COPY ALERT
----------------------------------------------------
local copyAlertEnabled = false

btnCopyAlert.MouseButton1Click:Connect(function()
	copyAlertEnabled = not copyAlertEnabled
	if copyAlertEnabled then
		btnCopyAlert.Text = "Alert: ON"
		btnCopyAlert.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
		alertTextLabel.Visible = true
	else
		btnCopyAlert.Text = "Alert: OFF"
		btnCopyAlert.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		alertTextLabel.Visible = false
	end
end)

RunService.RenderStepped:Connect(function()
	if copyAlertEnabled then
		local inDanger = isTeacherLookingAtPlayer()
		if inDanger then
			alertTextLabel.Text = "Alert No copy"
			alertTextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
		else
			alertTextLabel.Text = "Copy"
			alertTextLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
		end
	end
end)
