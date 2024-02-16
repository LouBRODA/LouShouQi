# **LouShouQi**

## Bonjour et bienvenue sur le dépôt du projet LouShouQi ! 👋

Les consignes étant déjà toutes expliquées [ici](https://codefirst.iut.uca.fr/git/mchSamples_Apple/DouShouQi), ce README aura pour but principal de rassembler mes principales découvertes !  

---

Sommaire 
 1. [TP1](#tp1)
 2. [TP2](#tp2)
 3. [TP3](#tp3)
 4. [TP4](#tp4)
 5. [TP5](#tp5)
 6. [TP6](#tp6)
 7. [Auteur](#auteur)

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

<div id='tp2'/>

### Découvertes du TP2

Pour continuer ce projet de Swift, j'ai pu mettre en place mes premières méthodes concrètes ainsi qu'un ensemble de tests (unitaires et de performance).  

Ma première méthode développée a été la méthode permettant de compter le nombre de pièces d'un joueur sur le tableau de jeu. J'ai souhaité, pour mettre en place cette méthode, utiliser les méthodes d'extension sur les collections :   
```
public func countOnePlayerPieces(of player: Owner) -> Int{
    return grid.flatMap { $0 }.filter { $0.piece?.owner == player }.count
}
```
- Utilisation de `flatMap`, transformation d'un tableau bidimensionnel en un tableau unidimensionnel ([Documentation officielle](https://developer.apple.com/documentation/swift/sequence/flatmap(_:)-jo2y))  
- Utilisation de `filter` pour garder les éléments remplissant une condition ([Documentation officielle](https://developer.apple.com/documentation/swift/string/filter(_:)))  
- Utilisation de `count` pour compter le nombre d'éléments([Documentation officielle](https://developer.apple.com/documentation/swift/collection/count-4l4qk))  

L'autre découverte principale que j'ai pu faire est l'écriture de tests de performance avec l'utilisation de la méthode `measure` permettant de connaître le temps passé pour exécuter une méthode :
```
func testInitPerformance() throws {
    let gridSize = 1000
    let cell = Cell(cellType: .jungle, initialOwner: .player1)
    let grid = Array(repeating: Array(repeating: cell, count: gridSize), count: gridSize)

    measure {
        let _ = Board(withGrid: grid)
    }
}
``` 
- Utilisation de `measure` ([Documentation officielle](https://developer.apple.com/documentation/swift/continuousclock/measure(_:)))  

---

<div id='tp3'/>

### Découvertes du TP3

Désormais, je me suis intéressé en la mise en place des règles du jeu. Pour cela, j'ai créé mon premier `protocole` correspondant à une `interface`. Pour commencer plus simplement, j'ai mis en place des règles simplifiées au sein de la classe `VerySimpleRules` implémentant le protocole. ([Documentation officielle](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/))  

Au delà de cette notion, j'ai aussi pu découvrir la gestion et le lancement d'erreur dans mes méthodes. Pour cela, j'ai pu implémenter deux énumérations d'erreurs personnalisées héritant du protocole `Error`. Les principales notions à savoir gérer concernant les erreurs et que j'ai pu expérimenter sont le lancement d'une erreur et la propagation de celle-ci.  

---

<div id='tp4'/>

### Découvertes du TP4

J'ai pu maintenant passer à la mise en place des joueurs de mon jeu que l'on trouve au nombre de 3 : `RandomPlayer` : un robot stupide qui jouera à chaque fois un coup aléatoire parmi ceux possibles, `HumanPlayer` : un joueur réel qui à partir d'une méthode permet de sélectionner un déplacement et `IAPlayer` : une intelligence artificielle qui choisit le meilleur coup parmi ceux possibles *(l'IA n'est pas tout à fait fonctionnelle car beaucoup de critères ne sont pas encore pris en compte pour qu'elle prenne la meilleure décision possible)*.  

La particularité de ce TP est que les classes liées aux joueurs sont désormais bien des **classes** et non plus des *struct*. Le plus pratique avec les classes est la possibilité de faire de **l'héritage**, ce qui nous sera très utile pour avoir une même structure pour tous les joueurs.  

([Documentation officielle](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures/))

---

<div id='tp5'/>

### Découvertes du TP5

Durant ce TP, j'ai pu mettre en place un patron **Observable** afin d'isoler la partie *affichage* de la partie hors de la partie de la *boucle de jeu*. J'ai donc implémenter une classe `GameNotificationObserver` que j'instancierai dans `Game` afin de notifier à différents moments de la partie (fin du jeu, changement de joueur...).  

Ce principe m'a permis de bien comprendre la dissociation des rôles de chacune des parties de mon code qui ont des responsabilités différentes.  

---

<div id='tp6'/>

### Découvertes du TP6

Pendant le dernier TP, nous avons fini cette partie du projet en mettant en place la **persistance** dans l'application. Afin de toujours isoler mon code, j'ai créé un nouveau *package* où j'ai placé les différentes *classes d'extension* de mon Model.

Ces classes d'extension implémentent l'interface **Codable** avec les méthodes **encode** et **decode** qui permettent de traduire en *json* les objets créés de tout type. 

([Documentation officielle](https://developer.apple.com/documentation/swift/codable))

Enfin j'ai aussi mis en place une classe **GameFileManager** qui permet de créer un fichier json ou d'en charger un pour que la Game puisse être reprise et surtout enregistrer à la fin de chaque tour de boucle de jeu.  

---

<div id='auteur'/>

## Auteur :technologist: 

Étudiant 3ème Annnée - Programmation Mobile - BUT Informatique - IUT Clermont Auvergne - 2023-2024   
`BRODA Lou`