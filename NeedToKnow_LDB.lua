--[[
    NeedToKnow_LDB - Adds Lib Data Broker functionality to NeedToKnow.
    Version - 1.1
    Copyright (C) 2017  Axpen

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

local NeedToKnow_LDB = CreateFrame("Frame", "NeedToKnow_LDB")

-- -----------------------
-- Libraries
-- -----------------------

local LDB = LibStub("LibDataBroker-1.1", true)
local LDBIcon = LDB and LibStub("LibDBIcon-1.0", true)
local LDBIconRegistered = false

-- --------------
-- Event Register
-- --------------
NeedToKnow_LDB:RegisterEvent("ADDON_LOADED")
NeedToKnow_LDB:SetScript("OnEvent", function(_, event, ...)
  NeedToKnow_LDB[event]()
end)

-- -------------
-- Event Handler
-- -------------

function NeedToKnow_LDB:ADDON_LOADED()
  if LDB then
    NeedToKnow_LDBLauncher = LDB:NewDataObject("NeedToKnow_LDB", {
      type = "launcher",
      icon = "Interface\\ICONS\\Spell_Nature_MentalQuickness",
      OnClick = function(clickedframe, button)
        -- Show config on right click, toggle config/play mode on left click
        if button == "RightButton" then
          -- Double function call to counter a "bug"?
          InterfaceOptionsFrame_OpenToCategory("NeedToKnow")
          InterfaceOptionsFrame_OpenToCategory("NeedToKnow")
          else
            NeedToKnow.LockToggle()
          end
      end,
      OnTooltipShow = function(tt)
        -- NeedToKnow_LDB.defaultTitle
        tt:AddLine("NeedToKnow")
        tt:AddLine("|cff7fffffLeft-Click|r to toggle play mode")
        tt:AddLine("|cff7fffffRight-click|r to open the options menu")
      end,
    })

        -- TODO: Add minimap icon support?
        -- LDBIcon:Register("NeedToKnow_LDB", NeedToKnow_LDBLauncher, db.MinimapIcon)
        LDBIconRegistered = true
  end
end
