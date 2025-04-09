# 🚗 mira_mechanic

## Description
A simple, extensible script for repairing vehicles inside (or outside) a mechanic shop. Designed for servers using ESX and ox scripts.

## 🔧 Features
- Repair conditions based on damage level
- Required items for repair (doors, wheels, fixboxes)
- Repairs outside of a mechanic shop require a mechanic vehicle nearby
- Each mechanic job can have its own defined workshop location

## Dependencies
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_inventory](https://github.com/overextended/ox_inventory)
- [ox_target](https://github.com/overextended/ox_target)
- [es_extended](https://github.com/esx-framework/esx_core/tree/main/%5Bcore%5D/es_extended)


## ⚙️ Installation

1. Download latest release or clone this repository into your server's resources folder:
    ```bash
    git clone https://github.com/cjmirang/mira_mechanic.git
    ```

2. Add it to your `server.cfg`:
    ```cfg
    ensure mira_mechanic
    ```

3. Add items to your ox_inventory\data\items.lua file
```lua
["screwdriver"] = {
		label = "Screwdriver",
		weight = 1,
		stack = false,
},
["fixbox"] = {
		label = "Fixbox",
		weight = 1,
		stack = true,
},
["sponge"] = {
		label = "sponge",
		weight = 1,
		stack = true,
},
["vehicledoor"] = {
		label = "vehicledoor",
		weight = 1,
		stack = true,
},
["vehiclewheel"] = {
		label = "vehiclewheel",
		weight = 1,
		stack = true,
},
```

4. Add items images to your ox_inventory\web\images folder from mira_mechanic\ITEMS\images

5. Dependencies required:
    - `ox_lib`
    - `ox_inventory`
    - `ox_target`
    - `es_extended` (ESX)

## 🛠️ Configuration

Open `config.lua` to customize:

  ```lua
  Config.ItemNames -- set item names u have set in ox_inventory
  Config.RepairTime -- set progressbar lenght for repair
  Config.WashTime -- set progressbar lenght for wash
  Config.Locales -- set any language u want
```


## Support
DM me directly on discord: mira0423

## Credits
- Author: mira0423
- Version: 1.0.0

## License
This script is licensed under the MIT License - see the LICENSE file for details.
