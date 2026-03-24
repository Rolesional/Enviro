local run_service = game:GetService("RunService")
local player_gui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local remote = require(game:GetService("ReplicatedStorage").Shared.Remotes).MinigameGameAction
local last_fired = 0

run_service.Heartbeat:Connect(function()
    local gui = player_gui:FindFirstChild("PopcornBurstGui"); if not gui then return end
    local elements = gui:GetDescendants()
    for _, obj in pairs(elements) do
        if obj:IsA("UIStroke") and obj.Color == Color3.fromRGB(0, 255, 100) then
            if obj.Transparency < .5 then
                local now = tick()
                if now - last_fired > .1 then
                    remote:FireServer("AttemptPop", workspace:GetServerTimeNow())
                    last_fired = now
                    break
                end
            end
        end
    end
end)
