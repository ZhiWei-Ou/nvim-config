# Nvim configuration

This is my neovim configuration.

# How to use

Frist, download neovim

> [!NOTE] 
> If you have neovim installed, you can skip this step.
> But it's better to ensure that the neovim version is larger than `NVIM v0.11.4`

- Linux
```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
```

- MacOS
```bash
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
tar xzf nvim-macos-arm64.tar.gz
./nvim-macos-arm64/bin/nvim
```

Second, clone this repo
- SSH
```bash
git clone -b main git@github.com:ZhiWei-Ou/nvim-config.git ~/.config/nvim
```
- HTTPS
```bash
git clone -b main https://github.com/ZhiWei-Ou/nvim-config.git ~/.config/nvim
```

# Documents
see `docs`
