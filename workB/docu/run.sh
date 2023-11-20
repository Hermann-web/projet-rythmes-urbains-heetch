pandoc readme.md -o readme.pdf --pdf-engine=lualatex --table-of-contents   --variable=fontsize:12pt --highlight-style=pygments  --metadata=title:"Matrice Origine-Destination (OD) : Détermination des Flux" --metadata=subtitle:"Projet Rythmes Urbains Heetch" --metadata=author:"Hermann Agossou; Salma Khmassi; Mohamed Lamine Bamba" --variable "geometry=margin=0.8in"


#pandoc OD_jour.md -o OD_jour.pdf --pdf-engine=lualatex --table-of-contents   --variable=fontsize:12pt --highlight-style=pygments  --metadata=title:"Matrice Origine-Destination (OD) : Détermination des Flux" --metadata=subtitle:"OD Journalière : Analyse des Déplacements par Jour" --metadata=author:"Hermann Agossou; Salma Khmassi; Mohamed Lamine Bamba" --variable "geometry=margin=0.8in"
