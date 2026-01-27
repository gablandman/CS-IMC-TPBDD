// 1.
// CREATE permet d'ajouter des noeuds ou des relations dans la base
// La syntaxe des parentheses est (alias:Label {proprietes})
// Le label Artist correspond aux personnes dans la bdd cinema
CREATE (a:Artist {primaryName: 'Gabriel Landman', birthYear: 2002})
RETURN a

// Verification que le noeud existe bien
MATCH (a:Artist {primaryName: 'Gabriel Landman'})
RETURN a


// 2.
CREATE (f:Film {primaryTitle: "L'histoire de mon 20 au cours Infrastructure de donnees", startYear: 2026})
RETURN f


// 3. 
// Pour lier un acteur a un film, on recupere d'abord les deux noeuds avec MATCH
// Puis on cree la relation avec CREATE
// La fleche montre le sens : artiste joue dans film
MATCH (a:Artist {primaryName: 'Gabriel Landman'}),
      (f:Film {primaryTitle: "L'histoire de mon 20 au cours Infrastructure de donnees"})
CREATE (a)-[:ACTED_IN]->(f)
RETURN a, f


// 4. 
CREATE (p1:Artist {primaryName: 'Laurent Cabaret'})
CREATE (p2:Artist {primaryName: 'Francesca Bugiotti'})

// on les relie au film avec la relation DIRECTED. On matche içi plusieurs noeuds en une requete.
MATCH (p1:Artist {primaryName: 'Laurent Cabaret'}),
      (p2:Artist {primaryName: 'Francesca Bugiotti'}),
      (f:Film {primaryTitle: "L'histoire de mon 20 au cours Infrastructure de donnees"})
CREATE (p1)-[:DIRECTED]->(f)
CREATE (p2)-[:DIRECTED]->(f)
RETURN p1, p2, f


// 5.
// On accede aux proprietes avec le point : a.birthYear
MATCH (a:Artist {primaryName: 'Ed Harris'})
RETURN a, a.birthYear


// 6. 
MATCH (f:Film)
RETURN f


// 7.
// WHERE permet d'ajouter des conditions de filtrage, c'est équivalent a mettre {birthYear: 1963} dans le MATCH.
MATCH (a:Artist)
WHERE a.birthYear = 1963
RETURN a.primaryName

// COUNT est une fonction d'agregation comme en SQL.
MATCH (a:Artist)
WHERE a.birthYear = 1963
RETURN COUNT(a) AS total1963


// 8.
// WITH permet de chainer les operations comme un pipe, c'est l'équivalent d'un sous select en SQL.
MATCH (a:Artist)-[:ACTED_IN]->(f:Film)
WITH a, COUNT(f) AS nbFilms
WHERE nbFilms > 1
RETURN a.primaryName, nbFilms



// 9. 
// TYPE(r) = le type de relation (ACTED_IN, DIRECTED...)                                                           
// COLLECT = met tout dans une liste                                                                               
// DISTINCT = pas de doublons                                                                                      
// SIZE = taille de la liste
MATCH (a:Artist)-[r]->(f:Film)
WITH a, COLLECT(DISTINCT TYPE(r)) AS metiers
WHERE SIZE(metiers) > 1
RETURN a.primaryName, metiers


// 10.
// On groupe par couple (artiste, film) au lieu de juste artiste, et cela trouve les gens qui cumulent acteur + realisateur etc sur un film
MATCH (a:Artist)-[r]->(f:Film)
WITH a, f, COLLECT(DISTINCT TYPE(r)) AS metiers
WHERE SIZE(metiers) > 1
RETURN a.primaryName, f.primaryTitle, metiers
