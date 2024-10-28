local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local onChatted = function(message)
	if (message:sub(1, 1) == "/") then
		local command = message:sub(2)
		
		if (command == "kill-all") then
			local weapon = LocalPlayer.Backpack:FindFirstChild("Remington 870")
			
			if (not weapon) then
				workspace.Remote.ItemHandler:InvokeServer(workspace.PRISON_ITEMS.giver["Remington 870"].ITEMPICKUP)
			end
			
			task.wait(0.1)
			
			for _, target in pairs(Players:GetPlayers()) do
				if (target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("Head")) then
					local a = {
						[1] = {
							["RayObject"] = Ray.new(LocalPlayer.Character.Head.Position, target.Character.Head.Position),
							["Distance"] = (LocalPlayer.Character.Head.Position - target.Character.Head.Position).magnitude,
							["Cframe"] = target.Character.Head.CFrame,
							["Hit"] = target.Character.Head
						}
					}
					
					ReplicatedStorage.ShootEvent:FireServer(a, LocalPlayer.Backpack["Remington 870"])
				end
			end
		end
	end
end

LocalPlayer.Chatted:Connect(onChatted)
