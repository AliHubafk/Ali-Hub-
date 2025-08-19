local Window = Library.CreateLib("AliHub", "RJTheme3")

local Tab = Window:NewTab("Main")

local Section = Tab:NewSection("Speed hack")

Section:NewToggle("Speed hack", "ToggleInfo", function(state)
    if state then
        game.Players.LocalPlayer.Character.Humanoid.Walkspeed = 100
    else
        game.Players.LocalPlayer.Character.Humanoid.Walkspeed = 10
    end
end)

Section:NewSlider("SliderText", "SliderInfo", 100, 10, function(s) -- 100 (Макс. значение) | 0 (Мин. значение)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

local Section = Tab:NewSection("Jump hack")

Section:NewToggle("Jump hack", "ToggleInfo", function(state)
    if state then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    else
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 10
    end
end)
