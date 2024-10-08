# Cours SwiftUI

## Exercice 1

**Question 1**

Il faut préciser un id au niveau de la liste pour pouvoir la parcourir en différenciant les différents éléments.
```swift
List(loot, id:  \.self) { item in
    Text(item)
}
```


