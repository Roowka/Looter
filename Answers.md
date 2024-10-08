# Cours SwiftUI

## Exercice 1

**Question 1**

Il faut préciser un id au niveau de la liste pour pouvoir la parcourir en différenciant les différents éléments.
```swift
List(loot, id:  \.self) { item in
    Text(item)
}
```

## Exercice 2

Par rapport à l'exemple précédent, on ne passe plus la liste en paramètres du **List** mais on la parcours à l'aide d'un **forEach**.
```swift
ForEach(loot, id: \.self) { item in
    Text(item)
}
```
Cela permet de modifier la liste et de voir les changement, ici on ajoute des champs avec un bouton.


Le bouton n'est pas dans le **forEach** sinon il y aurait un bouton par ligne.


## Exercice 3

Le code ne fonctionne pas car la liste est **immutable**. Il n'est donc pas possible d'ajouter des éléments.

En ajoutant **@State** devant la déclaration de la liste
```swift
    @State var loot = ["Epée", "Bouclier", "Armure"]
```
Cela la rend la liste modifiable. De ce fait, nous avons la modification visible sur la vue.
