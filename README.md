# Spatial
Minimalist spoon for showing the number of spaces and currently active space on
macOS.

## Installation
### Clone the repository
```sh
# Create the `Spoons` directory if it doesn't exist
mkdir -p ~/.hammerspoon/Spoons

# Clone the repository into the Spoons directory
git clone https://github.com/majjoha/Spatial.spoon.git ~/.hammerspoon/Spoons/Spatial.spoon
```

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

## Inspiration
- [Spaceman](https://github.com/Jaysce/Spaceman)
- [WhichSpace](https://github.com/gechr/WhichSpace)

## License
See [LICENSE](https://github.com/majjoha/voxctl/blob/main/LICENSE).
