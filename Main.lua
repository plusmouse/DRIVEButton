-- All Rights Reserved
-- Copyright (c) plusmouse 2025

local DRIVE_TREE = 1056
local function OpenDRIVE()
  if GenericTraitFrame and GenericTraitFrame:IsShown() then
    GenericTraitFrame:Hide()
    return
  end
  C_AddOns.LoadAddOn("Blizzard_GenericTraitUI");
  if tIndexOf(UISpecialFrames, "GenericTraitFrame") == nil then
    table.insert(UISpecialFrames, "GenericTraitFrame")
  end
  GenericTraitFrame:SetTreeID(DRIVE_TREE);
  GenericTraitFrame:Show();
  GenericTraitFrame:SetPoint("CENTER");
end

EventUtil.ContinueOnAddOnLoaded("DRIVEButton", function()
  DRIVE_BUTTON_MINIMAP = DRIVE_BUTTON_MINIMAP or {}

  local buttonLDB = LibStub("LibDataBroker-1.1"):NewDataObject("DRIVEButton", {
    type = "launcher",
    text = "DRIVE",
    icon = "interface/icons/inv_misc_punchcards_prismatic",
    OnClick = OpenDRIVE,
    OnTooltipShow = function(tooltip)
      tooltip:AddLine("DRIVE")
    end,
  })

  local registered = false
  -- Only show DRIVE button when character has it enabled
  local watcher = CreateFrame("Frame")
  watcher:RegisterEvent("TRAIT_CONFIG_LIST_UPDATED")
  watcher:RegisterEvent("PLAYER_LOGIN")
  watcher:RegisterEvent("TRAIT_CONFIG_CREATED")
  watcher:SetScript("OnEvent", function()
    if registered then
      return
    end
    if C_Traits.GetConfigIDByTreeID(DRIVE_TREE) then
      local icon = LibStub("LibDBIcon-1.0")
      icon:Register("DRIVEButton", buttonLDB, DRIVE_BUTTON_MINIMAP)
      SlashCmdList["DRIVEButton"] = OpenDRIVE
      SLASH_DRIVEButton1 = "/drive"
      registered = true
    end
  end)

end)
