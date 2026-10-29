# Shared terminal and editor theme

To install all configurations, apply the current palette, and enable the user timer:

```bash
bash ~/dotfiles/install.sh
```

The installer creates the required directories and symlinks, installs TPM if
missing, and enables the timer through `theme install-timer`. If Neovim is
available, it also installs missing plugins, including the theme. Otherwise,
plugins are installed when you first launch the editor. Running the installer
again preserves the selected theme mode and existing correct symlinks; it does
not overwrite regular configuration files. The timer requires a running systemd
user session.

```bash
~/dotfiles/scripts/theme light        # keep light mode until explicitly changed
~/dotfiles/scripts/theme dark         # keep dark mode until explicitly changed
~/dotfiles/scripts/theme auto         # return to the schedule
~/dotfiles/scripts/theme status       # show the saved mode and applied theme
~/dotfiles/scripts/theme install-timer
```

You can add `scripts/` to PATH or create a symlink to `scripts/theme` in a directory
already on PATH. No `sudo` is required.

The schedule is configured in `themes/schedule.conf`: by default, light mode runs
from 08:00 to 20:00 in the computer's local time. The timer checks the schedule
every minute, when the systemd user manager starts, and after a missed run.
Changing the schedule does not require reinstalling the timer. The timer does
not override a manual selection.

Alacritty uses the existing GitHub Light palette or the VS Code Dark+ palette.
The script generates `alacritty/themes/current.toml`, which is ignored by Git.
Alacritty reloads it without restarting. When tmux is running, the script updates
its colors and reapplies the `tmux-dotbar` styling. It targets the current tmux
server when invoked from inside tmux, or the server using the default socket
when invoked by the timer.

Neovim uses the `vscode.nvim` plugin with Light+ and Dark+ variants. On the first
launch, allow lazy.nvim to finish installing the plugin. Open editors check the
shared theme state every two seconds and whenever they gain focus.

Theme state is stored in `${XDG_STATE_HOME:-~/.local/state}/dotfiles-theme/`.
The `mode` file contains `auto`, `light`, or `dark`; the `current` file contains
the applied palette. The service configuration assumes the repository is located
at `~/dotfiles`, as do the other configurations in this repository.

To inspect or disable the timer:

```bash
systemctl --user status dotfiles-theme.timer
journalctl --user -u dotfiles-theme.service
systemctl --user disable --now dotfiles-theme.timer
```

Disabling the timer preserves the current palette. Manual `theme light` and
`theme dark` commands continue to work. To resume automatic switching, select
`theme auto` and enable the timer again.
