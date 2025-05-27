--!Type(UI)

--!SerializeField
local scoreCount : number = 0

--!Bind
local titleLabel : UILabel = nil
--!Bind
local progressSlider : UISlider = nil
--!Bind
local playerWinLabel : UILabel = nil

progressSlider.highValue = scoreCount

function UpdateMeter(arg)
    progressSlider:SetValueWithoutNotify(arg)
    titleLabel:SetPrelocalizedText(tostring(arg) .. " / " .. tostring(scoreCount), true)
end

function WinTrue(name)
    playerWinLabel:SetPrelocalizedText(name .. " WON!")
end

UpdateMeter(0)