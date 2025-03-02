-- All Rights Reserved
-- Copyright (c) plusmouse 2025

local DRIVE_TREE = 1056
EventUtil.ContinueOnAddOnLoaded("DRIVEButton", function()
  local buttonLDB = LibStub("LibDataBroker-1.1"):NewDataObject("DRIVEButton", {
    type = "launcher",
    text = "DRIVE",
    icon = "interface/icons/inv_misc_punchcards_prismatic",
    OnClick = function()
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
      GenericTraitFrame:SetParent(UIParent);
      GenericTraitFrame:SetPoint("CENTER");
    end,
    OnTooltipShow = function(tooltip)
      tooltip:AddLine("DRIVE")
    end,
  })

  local icon = LibStub("LibDBIcon-1.0")
  icon:Register("DRIVEButton", buttonLDB, {hide = true})

  -- Only show DRIVE button when character has it enabled
  local watcher = CreateFrame("Frame")
  watcher:RegisterEvent("TRAIT_CONFIG_LIST_UPDATED")
  watcher:RegisterEvent("PLAYER_LOGIN")
  watcher:SetScript("OnEvent", function()
    if C_Traits.GetConfigIDByTreeID(DRIVE_TREE) then
      icon:Show("DRIVEButton")
    else
      icon:Hide("DRIVEButton")
    end
  end)

end)
