# Spatial
Minimalist spoon for showing the number of spaces and currently active space on
macOS.

## Installation
### Using [`SpoonInstall`](https://www.hammerspoon.org/Spoons/SpoonInstall.html):
```lua
hs.loadSpoon("SpoonInstall")

-- Use `SpoonInstall` to install and load the Spatial spoon
spoon.SpoonInstall:andUse("Spatial", {
  -- Automatically start the spoon after installation
  start = true,
  config = {
    -- Optionally provide a custom configuration
    activeSpaceIcon = function(spaceNumber)
      return string.format("[ %d ]", spaceNumber)
    end,
    inactiveSpaceIcon = function(spaceNumber)
      return string.format(" %d ", spaceNumber)
    end
  }
})
```

## License
See [LICENSE](https://github.com/majjoha/voxctl/blob/main/LICENSE).
