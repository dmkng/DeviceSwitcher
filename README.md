# DeviceSwitcher
Script that allows conveniently switching the specified device on or off.

Originally created for ThinkPad's touch screen and to be used with ThinkPad's User Defined Function (star) key, but you can use it in any other scenario without any problems.

DeviceSwitcher is designed so that you can have multiple copies with different configuration installed and running at the same time.

## How to use
- Download latest release's source code archive [here](https://github.com/dmkng/DeviceSwitcher/releases/latest).
- Extract it to some location where it won't bother you, for example the root of your system drive (it's commonly the `C:\` drive).
- Open the `main.ps1` file with an editor of your choice and tweak the configuration variables at the top of the file according to your needs.
- Double click the `start.cmd` file to run DeviceSwitcher in the background, to stop it you can double click the `stop.cmd` file.
- If DeviceSwitcher is running, then you can double click the `switch.cmd` file to switch the configured device on or off.
  <br>
  If you have a ThinkPad, then you can make it run when pressing the User Defined Function (star) key.
- **Optional:** Double click the `!INSTALL.cmd` file to make DeviceSwitcher automatically run in the background at system boot, to undo it you can double click the `!UNINSTALL.cmd` file.
  <br>
  **Do NOT move DeviceSwitcher's files to another location when it is still installed, otherwise it will break. If you really want to, then first uninstall it, move it and install it again**.

## TODO
- Add built-in hotkey binding
- Replace signals with sockets
