# Ctrl+V pour le bloc visuel

**Constat** : Windows Terminal lie `ctrl+v` à `Terminal.PasteFromClipboard` : nvim ne reçoit jamais la touche.
**À faire (côté Windows Terminal)** : retirer cette liaison ; coller avec `ctrl+shift+v`.
En attendant, `<C-q>` fait la même chose dans nvim.
