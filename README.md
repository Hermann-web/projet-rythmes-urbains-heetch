# projet-rythmes-urbains-heetch


# steps
- definitions
    - heure de pointe
- carte: trouver un package qui represente des flux par (groupe de) temps
- **workA: determiner une heure de pointe par quartier**
    1. pour chaque heure, combien de points: determiner les heures de circulation (quand rien ne se passe, les gens dorment)
    2. pour chaque heure, combien de points par quartier (=chauffeur en circulation?): heure de circulation par quartier        
    3. etendre les heures: jour vs nuit vs ...
    4. carte: pour chaque quartier, trouver l'heure où le nombre de points est le important
- **workB: matrice OD sur l'heure de pointe**
    1. fixer un jour: pour chaque couple orienté de quartiers, combien de drivers
    2. fixer une semaine: sem vs week-end (des moyennes per day): pour chaque couple orienté de quartiers, combien de drivers
    3. fixer un jour: pour chaque heure(ex:08h-09h) et chaque couple orienté de quartiers, combien de drivers 
    4. carte: pour chaque jour (une couleur), trouver le flux le plux important
