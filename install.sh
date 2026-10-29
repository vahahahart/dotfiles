#!/usr/bin/env bash
set -euo pipefail

repo_dir="$HOME/dotfiles"
config_dir="$HOME/.config"

link_config() {
  local source_file=$1
  local destination=$2

  # The destination may already resolve through a link to the whole directory.
  if [[ "$(readlink -f "$destination" 2>/dev/null || true)" == "$source_file" ]]; then
    return
  fi
  if [[ -e "$destination" && ! -L "$destination" ]]; then
    printf 'Refusing to replace existing config: %s\n' "$destination" >&2
    exit 1
  fi
  ln -sfnT "$source_file" "$destination"
}

mkdir -p "$config_dir/tmux" "$HOME/.codex"
link_config "$repo_dir/nvim" "$config_dir/nvim"
link_config "$repo_dir/tmux/tmux.conf" "$config_dir/tmux/tmux.conf"
link_config "$repo_dir/alacritty" "$config_dir/alacritty"
link_config "$repo_dir/codex/config.toml" "$HOME/.codex/config.toml"

# Install TPM once; repeated installations keep the existing checkout.
tpm_dir="$config_dir/tmux/plugins/tpm"
if [[ ! -d "$tpm_dir" ]]; then
  git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
fi

# Create the active palette and install/enable the user systemd units.
# This preserves an existing manual light/dark choice.
"$repo_dir/scripts/theme" install-timer

# Install missing Neovim plugins, including vscode.nvim, without updating others.
if command -v nvim >/dev/null 2>&1; then
  nvim --headless "+Lazy! install" +qa
else
  printf 'Neovim not found; its plugins will be installed on first launch.\n'
fi

