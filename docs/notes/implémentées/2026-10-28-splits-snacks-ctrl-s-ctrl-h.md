# Splits depuis snacks : <C-s> vertical, <C-h> horizontal

**Décision** : dans les pickers et l'explorer, `<C-s>` ouvre en split vertical et `<C-h>` en split horizontal
(défauts snacks : `<C-v>` vertical, `<C-s>` horizontal).

**Pourquoi** : `<C-v>` est intercepté par Windows Terminal (collage). `<C-h>` n'a pas d'usage dans un picker :
l'explorer est déjà la fenêtre la plus à gauche. `<C-v>` reste le bloc visuel dans les fichiers.
**Limite** : si un terminal envoie `^H` pour Backspace, il déclencherait le split dans le champ de saisie
(Windows Terminal envoie `^?`, pas de souci).
