# steps
- definitions
    - heure de pointe
    - **carteB**: pour chaque jour (une couleur), trouver le flux le plux important : fixer un seuil points pour le filtre

- **workA: determiner une heure de pointe par quartier**
    1. ~~fixer un jour: pour chaque heure, combien de drivers: determiner les heures de circulation (quand rien ne se passe, les gens dorment)
    2. (part2)~~fixer un jour: pour chaque heure, combien de drivers par quartier (=chauffeur en circulation?): heure de circulation par quartier   
    2. (part2)**mat (hour, neib, nb_drivers) --> filter (nb_drivers>30) --> nb_neib=n() --> filter(nb_neib>..) --> (heuresDePointe)     
    3. fixer un jour: etendre les heures: jour vs nuit vs ...
    4. ~~carte: pour chaque quartier, trouver l'heure où le nombre de points est le important
- **workB: matrice OD sur l'heure de pointe**
    1. fixer un jour: pour chaque couple orienté de quartiers, combien de drivers + **carteB**
    2. fixer une semaine: sem vs week-end (des moyennes per day): pour chaque couple orienté de quartiers, combien de drivers + **carteB**
    4. fixer un jour: pour l'heure de pointe, pour chaque couple orienté de quartiers, combien de drivers  + **carteB**
