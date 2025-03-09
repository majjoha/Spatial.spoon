--- === Spatial ===
---
--- Minimalist spoon for showing the number of spaces and currently active space
--- on macOS.
---
--- Example configuration using `SpoonInstall.spoon`:
--- ````lua
--- -- Use `SpoonInstall` to install and load the Spatial spoon
--- spoon.SpoonInstall:andUse("Spatial", {
---   -- Automatically start the spoon after installation
---   start = true,
---   config = {
---     -- Optionally provide a custom configuration
---     activeSpaceIcon = function(spaceNumber)
---       return string.format("[ %d ]", spaceNumber)
---     end,
---     inactiveSpaceIcon = function(spaceNumber)
---       return string.format(" %d ", spaceNumber)
---     end
---   }
--- })
--- ```
---
--- Download: [https://github.com/majjoha/Spatial.spoon](https://github.com/majjoha/Spatial.spoon)
local obj = {}
obj.__index = obj

-- Metadata
obj.name = "Spatial"
obj.version = "1.0.0"
obj.author = "Mathias Jean Johansen <mathias@mjj.io>"
obj.homepage = "https://github.com/majjoha/Spatial.spoon"
obj.license = "ISC - https://opensource.org/licenses/ISC"

obj.logLevel = "nothing"
obj.logger = hs.logger.new("Spatial", obj.logLevel)

obj.activeSpaceIcon = function(index)
  -- Default: Highlight active space using the format `[ SPACE_ID ]`
  return string.format("[ %d ]", index)
end

obj.inactiveSpaceIcon = function(index)
  -- Default: Normal numbering for inactive spaces using the format ` ID `
  return string.format(" %d ", index)
end

obj.menuBarItem = nil
obj.spacesWatcher = nil

--- Spatial:start()
--- Method
--- Starts Spatial
---
--- Parameters
---  * None
---
--- Returns:
---  * The Spatial object
function obj:start()
  self.logger.d("Starting Spatial")

  if self.menubarItem then
    self:stop()
  end
  self.menuBarItem = hs.menubar.new(true, "Spatial")

  -- Update on space change
  self.spacesWatcher = hs.spaces.watcher.new(hs.fnutils.partial(
                                               self.updateMenuBar, self))
  self.spacesWatcher:start()
  self:updateMenuBar()

  return self
end

--- Spatial:stop()
--- Method
--- Stops Spatial
---
--- Parameters:
---  * None
---
--- Returns:
---  * The Spatial object
function obj:stop()
  self.logger.d("Stopping Spatial")

  if self.menubarItem then
    self.logger.d("Deleting menu bar item")
    self.menuBarItem:delete()
    self.menuBarItem = nil
  end

  if self.spacesWatcher then
    self.logger.d("Stopping spaces watcher")
    self.spacesWatcher:stop()
    self.spacesWatcher = nil
  end

  return self
end

--- Spatial:updateMenuBar()
--- Method
--- Updates the state of the menu bar
---
--- Parameters:
---  * None
---
--- Returns:
---  * None
function obj:updateMenuBar()
  -- Get the main screen
  local screen = hs.screen.mainScreen()

  -- Get spaces for the screen
  local spaceIDs = hs.spaces.spacesForScreen(screen)

  -- Get current space ID
  local currentSpace = hs.spaces.focusedSpace()

  -- Set the text for the menu bar item
  local menuBarItemText = ""

  for i, spaceID in ipairs(spaceIDs) do
    if spaceID == currentSpace then
      -- Highlight current space
      menuBarItemText = menuBarItemText .. "" .. self.activeSpaceIcon(i) .. ""
    else
      menuBarItemText = menuBarItemText .. "" .. self.inactiveSpaceIcon(i) .. ""
    end
  end

  self.menuBarItem:setTitle(menuBarItemText)
end

return obj
