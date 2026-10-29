# Pane actif plus visible

**Décision** : colorful-winsep colore en orange (accent Ayu) la bordure du pane actif, trait fin, sans animation ; les
autres séparateurs (`WinSeparator`) sont atténués. `NormalNC` éclaircit légèrement les panes inactifs, et
`cursorline` n'est active que dans le pane actif (buffers de fichiers seulement).

Explorer : snacks place déjà son curseur sur le fichier du pane actif (`follow_file`, actif par défaut) ;
`SnacksPickerListCursorLine` a un fond rouge franc pour que cette ligne se voie. Limite : en naviguant dans l'explorer,
la marque suit le curseur ; elle revient sur le fichier en retournant dans un pane.
