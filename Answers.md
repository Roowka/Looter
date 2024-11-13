# Cours SwiftUI

## App Basics

### Exercice 1

Il faut préciser un id au niveau de la liste pour pouvoir la parcourir en différenciant les différents éléments.
```swift
List(loot, id:  \.self) { item in
    Text(item)
}
```

### Exercice 2

Par rapport à l'exemple précédent, on ne passe plus la liste en paramètres du **List** mais on la parcours à l'aide d'un **forEach**.
```swift
ForEach(loot, id: \.self) { item in
    Text(item)
}
```
Cela permet de modifier la liste et de voir les changement, ici on ajoute des champs avec un bouton.


Le bouton n'est pas dans le **forEach** sinon il y aurait un bouton par ligne.


### Exercice 3

Le code ne fonctionne pas car la liste est **immutable**. Il n'est donc pas possible d'ajouter des éléments.

En ajoutant **@State** devant la déclaration de la liste
```swift
    @State var loot = ["Epée", "Bouclier", "Armure"]
```
Cela la rend la liste modifiable. De ce fait, nous avons la modification visible sur la vue.

## Ajout Item

### Exercice 1

Lorsque je clique sur le bouton ajouter il ne se passe rien. Le code d'ajout est bon mais la classe n'est pas bien définie.

### Exercice 2

La classe n'est pas conforme au protocol ObservableObject, ce protocol permet de modifier le contenu de la classe. De plus, il faut préciser @Published devant la variable à modifier.

```swift
    class Inventory: ObservableObject {
    @Published var loot = ["Epée", "Bouclier", "Armure"]
    
   ...
}
```

 Ensuite, il faut appeler la classe avec @State Object devant.

```swift
    @StateObject var inventory = Inventory()
```

Nous utilisons @StateObject puisque que nous voulons que ce soit cette vue qui soit responsable de l'objet.


## Modele

### Exercice 2

Nous avons une erreur sur le identifiable car sans ça, nous ne pouvons pas identifier les objets. Le fait d'ajouter Identifiable fait que nous devons ajouter un id pour chaque objet ce qui les rend uniques.
