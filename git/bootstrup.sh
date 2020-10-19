echo "[include]
	path=.gitconfig_impl" >> "$HOME/.gitconfig"
ln -s "$(pwd)/.gitconfig_impl" "$HOME/.gitconfig_impl"
