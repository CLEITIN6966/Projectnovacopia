-- // Project Nova V9 \\ -- | [ Made by ThroughTheFireAndFlames#9925 :3 ]

--[[---------------------------------------------------------------------------------------------------
    This script updates a lot, Use this loadstring to be in the latest version:

    getgenv().ToggleUI = "J"-- //  Key Toggle "J" set by default however you can change it.
    getgenv().ProjectNova = "https://raw.githubusercontent.com/Lvl9999/TheStrongestBattlegrounds/main/ProjectNovaV9";

    pcall(function()
        loadstring(game:HttpGet(getgenv().ProjectNova))();
    end)
]]-----------------------------------------------------------------------------------------------------

--// Auto Loader \\--
repeat task.wait() until game:IsLoaded();

--// Anti Kick Idle \\--
task.spawn(function()
    if not getgenv().AntiAfk == true then
        while true do task.wait(1100);
            pcall(function()
                game:GetService("VirtualInputManager"):SendKeyEvent(true,"RightBracket",false,game);
            end)
        end
        getgenv().AntiAfk = true;
    end
end)

--// Settings Manager \\--
getgenv().Configurations = function()
    pcall(function()
        -- [Farming Scripts]
        getgenv().AutoKillLowestHealthPlr = false;
        getgenv().AutoKillNearestPlr = false;
        getgenv().AutoGiveKills = false;

        -- [Miscellaneous Scripts]
        getgenv().AutoMocking = false;
        getgenv().AutoDashEffect = false;
        getgenv().AutoFuckingGoku = false;
        getgenv().AutoReturnSafeZone = false;
        getgenv().AutoGarouCounterBait = false;
        getgenv().AutoAtomicCounterBait = false;

        -- [Fighting Scripts]
        getgenv().AutoTeleportPunching = false;
        getgenv().AutoAimlocking = false;
        getgenv().AutoBlocking = false;
        getgenv().AutoDodging = false;
        getgenv().AutoVoiding = false;
        getgenv().AutoNoSlow = false;

        -- [Movement Scripts]
        getgenv().WalkspeedBypass = false;
        getgenv().JumpPowerBypass = false;

        -- [Esp Scripts]
        getgenv().EspPlayers = false;
    end)
end

getgenv().Configurations();
-----------------------------------[[ Main Ui Libs ]]------------------------------------------------------------------
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Lvl9999/DrRay/main/Backup"))();
local BoredLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Lvl9999/Bored/main/Backup"))();
-----------------------------------------------------------------------------------------------------------------------

local MainWindow = DrRayLibrary:Load("Project Nova   V9","Default");
local HomeTab = DrRayLibrary.newTab("Home","http://www.roblox.com/asset/?id=9405923687");

--// Apply Custom UI Color \\--
game:GetService("CoreGui").DrRay.TopBar.BackgroundColor3 = Color3.new(0,0,0);
game:GetService("CoreGui").DrRay.MainBar.BackgroundColor3 = Color3.new(0,0,0);
game:GetService("CoreGui").DrRay.TopBar.TopBar.BackgroundColor3 = Color3.new(0,0,0);
game:GetService("CoreGui").DrRay.TopBar.ProfileMenu.Clock.BackgroundTransparency = 0.75;
game:GetService("CoreGui").DrRay.TopBar.ProfileMenu.PlayerProfile.BackgroundTransparency = 0.75;
game:GetService("CoreGui").DrRay.TopBar.ProfileMenu.Title.BackgroundTransparency = 0.75;
game:GetService("CoreGui").DrRay.TopBar.TopBarClose.BackgroundTransparency = 0.55;
game:GetService("CoreGui").DrRay.TopBar.TopBarClose.idk.Visible = false;

--// Loaded Notification \\--
BoredLibrary.prompt("Project Nova V9","Successfully Loaded :3",3);

---------------------------------[[ Main Source Code 💞 ]]------------------------------------------------------------
HomeTab.newLabel("Local Player Scripts   📢");
HomeTab.newToggle("Super Walkspeed","",false,function(Value)
    getgenv().WalkspeedBypass = Value

    -- Got From https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source
    task.spawn(function()
        while getgenv().WalkspeedBypass == true and game:GetService("Players").LocalPlayer do
            pcall(function()
                local chr = game:GetService("Players").LocalPlayer.Character
                if chr then
                   local hum = chr:FindFirstChildWhichIsA("Humanoid");
                    if hum and hum.Parent then
                        local hb = game:GetService("RunService").Heartbeat
                        local delta = hb:Wait()
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection * 12 * delta * 10);
                        else
                            chr:TranslateBy(hum.MoveDirection * delta * 10);
                        end
                    end
                end
            end)
            task.wait(0.0015);
        end
    end)
end)

HomeTab.newToggle("Super JumpPower","",false,function(Value)
    getgenv().JumpPowerBypass = Value

    task.spawn(function()
        while getgenv().JumpPowerBypass == true do
            pcall(function()
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetState() == Enum.HumanoidStateType.Jumping then
                    game.Players.LocalPlayer.Character.Humanoid.RootPart.CFrame = game.Players.LocalPlayer.Character.Humanoid.RootPart.CFrame * CFrame.new(0,190,0);
                end
            end)
            task.wait(0.0015);
        end
    end)
end)

HomeTab.newLabel("Visual Scripts   👁️");
HomeTab.newToggle("Esp Players","",false,function(Value)
    getgenv().EspPlayers = Value

    local Folder = workspace.Live

    local function CreateBilboard(X)
        local Head = X:FindFirstChild("Head");
        if not Head then return end

        local BillboardGui = Instance.new("BillboardGui");
        local TextLabel = Instance.new("TextLabel");

        BillboardGui.Parent = Head
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Size = UDim2.new(0,100,0,50);
        BillboardGui.StudsOffset = Vector3.new(0, 2, 0);

        TextLabel.Parent = BillboardGui
        TextLabel.BackgroundColor3 = Color3.new(1,1,1);
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(1,0,1,0);
        TextLabel.Text = X.Name
        TextLabel.TextColor3 = Color3.fromRGB(255,255,0);
        TextLabel.TextScaled = true
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.TextStrokeTransparency = 0
        TextLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0);
        TextLabel.Visible = false

        return BillboardGui, TextLabel
    end

    local function UseESP(X)
        local Head = X:FindFirstChild("Head");
        if not Head then return end

        local BillboardGui, TextLabel = CreateBilboard(X)
        local RenderSteppedCon

        local function DisconnectCons()
            if BillboardGui then
                BillboardGui:Destroy();
            end
            if RenderSteppedCon then
                RenderSteppedCon:Disconnect();
                RenderSteppedCon = nil
            end
        end

        RenderSteppedCon = game:GetService("RunService").RenderStepped:Connect(function()
            local HeadPosition, HeadOnScreen = workspace.CurrentCamera:WorldToViewportPoint(Head.Position);
            if HeadOnScreen then
                TextLabel.Visible = getgenv().EspPlayers
            else
                TextLabel.Visible = false
            end
        end)

        X.AncestryChanged:Connect(function(_,b)
            if not b then
                DisconnectCons();
            end
        end)
    end

    local function isPlayer(X)
        return game.Players:GetPlayerFromCharacter(X) ~= nil
    end

    local function XAdded(X)
        if isPlayer(X) and X:IsA("Model") and X:FindFirstChild("Head") then
            UseESP(X);
        end
        X.ChildAdded:Connect(function(v)
            if isPlayer(v) and v:IsA("Model") and v:FindFirstChild("Head") then
                UseESP(v);
            end
        end)
    end

    for _,X in ipairs(Folder:GetChildren()) do
        if isPlayer(X) and X:IsA("Model") and X:FindFirstChild("Head") then
            XAdded(X);
        end
    end

    Folder.ChildAdded:Connect(function(v)
        task.wait(0.5);XAdded(v);
    end)
end)

HomeTab.newLabel("Quick Scripts   🚀");
HomeTab.newButton("Animation Grabber","",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Lvl9999/AnimationGrabber/main/Universal"))();
end)

HomeTab.newButton("Infinite Yield","",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))();
end)

HomeTab.newButton("Remote Spy","",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))();
end)

HomeTab.newButton("Dark Explorer","",function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua'))();
end)

HomeTab.newButton("Teleport Maker","",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/GSgUCJmq"))();
end)

HomeTab.newLabel("Project Nova Hub Stuff");
HomeTab.newButton("Reload Project Nova","",function()
    getgenv().ProjectNova = "https://raw.githubusercontent.com/Lvl9999/TheStrongestBattlegrounds/main/ProjectNovaV9";

    pcall(function()
        game:GetService("CoreGui").DrRay:Destroy();loadstring(game:HttpGet(getgenv().ProjectNova))();
    end)
end)

HomeTab.newButton("Goodbye Project Nova   👋","",function()
    task.spawn(function()pcall(function()game:GetService("CoreGui").DrRay:Destroy();end);end);getgenv().Configurations();
    BoredLibrary.prompt("Project Nova V9","Goodbye :)",0.5);
end)

HomeTab.newInput("Report Bugs / Feedback","Type here anything you want me to know :)",function(text)
    getgenv().Message = text
    getgenv().WebHook = "https://discord.com/api/webhooks/1259740492434903170/IviFL-3fPu7F6JpdkYtH98M3DMh74eURxDee_MSjD6kv9EKBnW9M70wa89UUERs3vvmx";

    task.spawn(function()
        if getgenv().Message ~= "" then
            local data = {content = "",embeds = {{author = {name = game.Players.LocalPlayer.Name,},title = "Reported:",description = getgenv().Message,type = "rich",color = tonumber(0xff0000),footer = {text = string.format("Reported at %s",os.date("%Y-%m-%d %X"))}}}};
            local request = http_request or request or HttpPost or syn.request
            request({Url = getgenv().WebHook,Body = game:GetService("HttpService"):JSONEncode(data),Method = "POST",Headers = {["content-type"] = "application/json"}});
            BoredLibrary.prompt("Project Nova V9","Message Sent   ✅",1.5);
        end
    end)
end)

local MiscellaneousTab = DrRayLibrary.newTab("Misc","http://www.roblox.com/asset/?id=9405930424");

MiscellaneousTab.newLabel("Miscellaneous Scripts   📌");
MiscellaneousTab.newToggle("Auto Roast Dead Players (Funny)","",false,function(Value)
    getgenv().AutoMocking = Value

    -- // Thanks to ChatGPT the goat
    local AntagonizeList = {

    }
    
    local LPlayer = game.Players.LocalPlayer
    local CRoot
    
    local function UpdateCRoot()
        local LChar = LPlayer.Character
        if LChar then
            CRoot = LChar:FindFirstChild("HumanoidRootPart");
            if not CRoot then
                LChar.ChildAdded:Wait();
                CRoot = LChar:WaitForChild("HumanoidRootPart");
            end
        end
    end
    
    local function FindNearest()
        local Dist = 65
        local NearestPlr = nil
    
        for _,v in pairs(game.Workspace.Live:GetChildren()) do
            local Humanoid = v:FindFirstChildOfClass("Humanoid");
            local HumanoidRoot = v:FindFirstChild("HumanoidRootPart");
    
            if Humanoid and HumanoidRoot and v ~= LPlayer.Character then
                if Humanoid.Health == 0 then
                    local Mag = (CRoot.Position - HumanoidRoot.Position).magnitude
                    if Mag < Dist then
                        Dist = Mag
                        NearestPlr = HumanoidRoot
                    end
                end
            end
        end
    
        return NearestPlr
    end

    task.spawn(function()
        while getgenv().AutoMocking == true  do
            pcall(function()UpdateCRoot();
                if CRoot then
                    local Found = FindNearest();
                    if Found then                    
                        local args = { AntagonizeList[math.random(1,#AntagonizeList)],"All"};
                        game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args));
                    end
                end
            end)
            task.wait(2.85);
        end
    end)
    
    LPlayer.CharacterAdded:Connect(function()
        task.wait(3);UpdateCRoot();
    end)
end)

MiscellaneousTab.newToggle("Auto Dash Effects (Use No Slow)","",false,function(Value)
    getgenv().AutoDashEffect = Value

    task.spawn(function()
        while getgenv().AutoDashEffect == true do
            pcall(function()
                local args = {[1] = {["Dash"] = Enum.KeyCode.S,["Key"] = Enum.KeyCode.Q,["Goal"] = "KeyPress"}} ;
                game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args));
            end)
            task.wait(0.15);
        end
    end)
end)

MiscellaneousTab.newToggle("Auto Frick Goku's Gyatt (Sus)","",false,function(Value)
    getgenv().AutoFuckingGoku = Value

    task.spawn(function()
        if getgenv().AutoFuckingGoku == true then
            local FuckAnimation = Instance.new("Animation");FuckAnimation.AnimationId = "rbxassetid://148840371" local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(FuckAnimation);k:Play();k:AdjustSpeed(6);
        else
            for i,v in ipairs((game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("AnimationController")):GetPlayingAnimationTracks()) do
                v:Stop();
            end
        end
    end)
    
    task.spawn(function()
        if getgenv().AutoFuckingGoku == true then
            local GahDamn = "http://www.roblox.com/asset/?id=8448213216"
            local Sound = Instance.new("Sound");Sound.Name = "Sound";Sound.SoundId = GahDamn
            Sound.Volume = 10;Sound.Looped = false;Sound.Archivable = false;Sound.Parent = game.Workspace;Sound:Play();
    
            local Claps = "http://www.roblox.com/asset/?id=9114758204"
            local Sound = Instance.new("Sound");Sound.Name = "Sound";Sound.SoundId = Claps
            Sound.Volume = 10;Sound.Looped = true;Sound.Archivable = false;Sound.Parent = game.Workspace;Sound:Play();
        else
            for i,v in ipairs(workspace:children()) do
                if v:isA("Sound") then
                    v:Destroy();
                end
            end
        end
    end)
    
    task.spawn(function()
        while getgenv().AutoFuckingGoku == true do
   
