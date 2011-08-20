mod = CreateFrame('frame')
mod\SetScript('OnEvent', (event, ...) => self[event](self, ...))
mod\RegisterEvent('ADDON_LOADED')

mod.ADDON_LOADED = (addon) =>
  if addon == self\GetName!
    self\UnregisterEvent('ADDON_LOADED')
    self\RegisterEvent('PLAYER_ENTERING_WORLD')
    self\PLAYER_ENTERING_WORLD!
    true
  else
    false

mod.PLAYER_ENTERING_WORLD = =>
  if select(2, IsInInstance!) == 'pvp'
    self\RegisterEvent('CHAT_MSG_RAID_BOSS_EMOTE')
    RaidBossEmoteFrame\UnregisterEvent('CHAT_MSG_RAID_BOSS_EMOTE')
  else
    self\UnregisterEvent('CHAT_MSG_RAID_BOSS_EMOTE')
    RaidBossEmoteFrame\RegisterEvent('CHAT_MSG_RAID_BOSS_EMOTE')
  true

mod.CHAT_MSG_RAID_BOSS_EMOTE = (msg) =>
  DEFAULT_CHAT_FRAME\AddMessage(msg)
  true
