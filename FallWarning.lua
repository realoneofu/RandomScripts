
if getgenv().execThe == true then
    return
end
repeat wait() until game:IsLoaded()
getgenv().execThe = true
local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
local WarningDontDelete = Instance.new("ScreenGui")
local FallWarning = Instance.new("Frame")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local TextLabel = Instance.new("TextLabel")

humanoid.StateChanged:Connect(function(oldState, newState)
	if newState == Enum.HumanoidStateType.Freefall then
	    TextLabel.Visible = true
elseif newState ~= Enum.HumanoidStateType.Freefall then
        TextLabel.Visible = false
        end
	end)
    
--Properties:

WarningDontDelete.Name = "WarningDontDelete"
WarningDontDelete.Parent = game:GetService("CoreGui")
WarningDontDelete.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

FallWarning.Name = "FallWarning"
FallWarning.Parent = WarningDontDelete
FallWarning.AnchorPoint = Vector2.new(0.5, 0)
FallWarning.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FallWarning.BackgroundTransparency = 1.000
FallWarning.Position = UDim2.new(0.5, 0, 0.100000001, 0)
FallWarning.Size = UDim2.new(0.449999988, 0, 0.100000001, 0)
FallWarning.ZIndex = 200

UIAspectRatioConstraint.Parent = FallWarning
UIAspectRatioConstraint.AspectRatio = 8.000
UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height

TextLabel.Parent = FallWarning
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.ZIndex = 202
TextLabel.Font = Enum.Font.GothamBlack
TextLabel.Text = "危险动作，请勿模仿⚠ 若无任何辅助设备，从高处跳下将受到坠落伤害或死亡            Dangerous actions, please do not imitate ⚠Without any auxiliary equipment, jumping from a height will result in fall injury or death"     
TextLabel.TextScaled = true
TextLabel.TextSize = 18.000
TextLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextStrokeTransparency = 0.000
TextLabel.TextWrapped = true
TextLabel.Visible = false
local t = 5;

local tick = tick
local fromHSV = Color3.fromHSV
local RunService = game:GetService("RunService")


RunService:BindToRenderStep("Rainbow", 1000, function()
    local hue = tick() % t / t
    local Color = fromHSV(hue, 1, 1)
    TextLabel.TextColor3 = Color3.new(Color.r,Color.g,Color.b)
end)  

while wait() do
    if WarningDontDelete.Parent == nil then
        game.StarterGui:SetCore("SendNotification", {
Title = "[警告⚠] [WARNING⚠]";
Text = "不允许删除所需的实例                               DELETING THE REQUIRED INSTANCE IS NOT PERMITTED";
Button1 = "[好的] [OK]";
Duration = 5;
})
        getgenv().execThe = false
		wait(0.1)
		loadstring(game:HttpGet("https://raw.githubusercontent.com/realoneofu/RandomScripts/main/FallWarning.lua"))()
        return
    elseif TextLabel.Parent == nil then
        WarningDontDelete:Destroy()
        game.StarterGui:SetCore("SendNotification", {
Title = "[警告⚠] [WARNING⚠]";
Text = "不允许删除所需的实例                               DELETING THE REQUIRED INSTANCE IS NOT PERMITTED";
Button1 = "[好的] [OK]";
Duration = 5;
})
        getgenv().execThe = false
		wait(0.1)
		loadstring(game:HttpGet("https://raw.githubusercontent.com/realoneofu/RandomScripts/main/FallWarning.lua"))()
        return
    elseif FallWarning.Parent == nil then
        WarningDontDelete:Destroy()
        game.StarterGui:SetCore("SendNotification", {
Title = "[警告⚠] [WARNING⚠]";
Text = "不允许删除所需的实例                               DELETING THE REQUIRED INSTANCE IS NOT PERMITTED";
Button1 = "[好的] [OK]";
Duration = 5;
})
        getgenv().execThe = false
		wait(0.1)
		loadstring(game:HttpGet("https://raw.githubusercontent.com/realoneofu/RandomScripts/main/FallWarning.lua"))()
        return
    end
end

