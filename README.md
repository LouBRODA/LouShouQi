# **LouShouQi**

## Bonjour et bienvenue sur le dépôt du projet LouShouQi ! 👋

Les consignes étant déjà toutes expliquées [ici](https://codefirst.iut.uca.fr/git/mchSamples_Apple/DouShouQi), ce README aura pour but principal de rassembler mes principales découvertes !  

---

Sommaire 
 1. [TP1](#tp1)
 2. [TP2](#tp2)
 3. [Auteur](#auteur)
---

<div id='tp1'/>

### Découvertes du TP1

Durant le TP1, j'ai pu d'abord me familiariser avec l'environnement mac que je ne connaissais pas du tout.  
Par la suite, j'ai également mis en place mon projet et sa structure initiale ainsi que ses premières classes.  

Parmi mes découvertes principales et dont je suis satisfait se trouve, dans ma classe `Board`, la vérification que ma grille contient le même nombre de lignes que de colonnes :  
```
guard let checkRowSize = grid.first?.count, grid.allSatisfy({ $0.count == checkRowSize }) else {
    return nil
}
```
- Utilisation de `guard`, semblable au `if` ([Documentation Code#0](https://codefirst.iut.uca.fr/documentation/mchCoursDocusaurus/docusaurus/Swift/docs/Swift/controlFlow/#how-to-use-guard-statements))  
- Utilisation de `allSatisfy` pour vérifier l'égalité sur un ensemble ([Documentation officielle](https://developer.apple.com/documentation/swift/array/allsatisfy(_:)))  
- Utilisation de `shorthand argument names` dans ma `closure`([Documentation Code#0](https://codefirst.iut.uca.fr/documentation/mchCoursDocusaurus/docusaurus/Swift/docs/Swift/closures/#how-to-write-closure-with-shorthand-argument-names))  

J'ai également pu découvrir l'`optional chaining` m'ayant bloqué pendant un moment. Il s'agit de la possibilité d'appeler par exemple une propriété pouvant être `nil` sans pour autant engendre une `runtime error`. Ceci s'est notamment déroulé dans la définition de la propriété `description` de mon `Board` avec l'enchaînement `piece?.animal` :  
```
s += "\(grid[i][j].cellType.symbol)\(grid[i][j].piece?.animal.symbol ?? " ")\(grid[i][j].initialOwner.symbol)"
```
- Utilisation de l'`optional chaining` ([Documentation Code#0](https://codefirst.iut.uca.fr/documentation/mchCoursDocusaurus/docusaurus/Swift/docs/Swift/optionals/#how-to-use-optional-chaining-abc))  

---

<div id='auteur'/>

## Auteur :technologist:

Étudiant 3ème Annnée - Programmation Mobile - BUT Informatique - IUT Clermont Auvergne - 2023-2024   
`BRODA Lou`