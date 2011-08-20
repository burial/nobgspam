local mod = CreateFrame('frame')
mod:SetScript('OnEvent', function(self, event, ...)
  return self[event](self, ...)
end)
mod:RegisterEvent('ADDON_LOADED')
mod.ADDON_LOADED = function(self, addon)
  if addon == self:GetName() then
    self:UnregisterEvent('ADDON_LOADED')
    self:RegisterEvent('PLAYER_ENTERING_WORLD')
    self:PLAYER_ENTERING_WORLD()
    return true
  else
    return false
  end
end
mod.PLAYER_ENTERING_WORLD = function(self)
  if select(2, IsInInstance()) == 'pvp' then
    self:RegisterEvent('CHAT_MSG_RAID_BOSS_EMOTE')
    RaidBossEmoteFrame:UnregisterEvent('CHAT_MSG_RAID_BOSS_EMOTE')
  else
    self:UnregisterEvent('CHAT_MSG_RAID_BOSS_EMOTE')
    RaidBossEmoteFrame:RegisterEvent('CHAT_MSG_RAID_BOSS_EMOTE')
  end
  return true
end
mod.CHAT_MSG_RAID_BOSS_EMOTE = function(self, msg)
  DEFAULT_CHAT_FRAME:AddMessage(msg)
  return true
end
