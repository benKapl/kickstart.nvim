# Presse-papiers sous WSL : win32yank

**Décision** : sous WSL, si `win32yank.exe` est dans le PATH, il sert de provider au presse-papiers
(`lua/config/options.lua`), au lieu de clip.exe / powershell.

**Pourquoi** : clip.exe casse l'UTF-8 (accents) et le passage par powershell est lent.
