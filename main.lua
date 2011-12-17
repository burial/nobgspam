local mod = CreateFrame('frame')
mod:SetScript('OnEvent', function(self, event, ...) return self[event](self, ...) end)
mod:RegisterEvent('ADDON_LOADED')

function mod:ADDON_LOADED(addon)
  if addon == 'nobgspam' then
    self:UnregisterEvent('ADDON_LOADED')

    RaidBossEmoteFrame.RealShow = RaidBossEmoteFrame.Show
    RaidBossEmoteFrame.RealHide = RaidBossEmoteFrame.Hide

    local NOP = function() end
    RaidBossEmoteFrame.Show = NOP
    RaidBossEmoteFrame.Hide = NOP

    self:RegisterEvent('PLAYER_ENTERING_WORLD')
    self:PLAYER_ENTERING_WORLD()

    return true
  end
end

function mod:PLAYER_ENTERING_WORLD()
  local _, instanceType = IsInInstance()
  if instanceType == 'pvp' then -- battleground
    RaidBossEmoteFrame:RealHide()
  else
    RaidBossEmoteFrame:RealShow()
  end

  return true
end
