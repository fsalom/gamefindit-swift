![author](https://img.shields.io/badge/author-fernando%20salom-red)

# Game find it

## Getting started

Just a mini game to test Compositional Layouts in CollectionView (5/6 hours)

- MVVM
- Compositional layout
- Builder

Menu             |  Game
:-------------------------:|:-------------------------:
![screenshot1](https://i.ibb.co/MgW93CJ/Captura-de-Pantalla-2022-07-06-a-las-20-51-53-2.png)  |  ![screenshot2](https://i.ibb.co/X3hMdk7/Captura-de-Pantalla-2022-07-06-a-las-20-54-45-1.png)

 

## Highlitghts

Some "highlights" of this project.

Container is the core of the app and the responsable to generate new screens:
```swift
class Container {
    static let shared = Container()
    var window: UIWindow?
}

extension Container {
    func gameBuilder() -> GameBuilder {
        return GameBuilder()
    }

    func menuBuilder() -> MenuBuilder {
        return MenuBuilder()
    }
}
```

Function to generate random emojis:
```swift
  func randomEmoji() -> String {
      let emojiStart = 0x1F601
      let ascii = emojiStart + Int(arc4random_uniform(UInt32(35)))
      let emoji = UnicodeScalar(ascii)?.description
      return emoji ?? "x"
  }
```

Use of compositional layout:
```swift
extension GameController: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 5
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing * 2 * 5
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension)
    }
}
```

## Installation

I imagine that if you are here you know what to do to execute this code :wink:

## To do

- Multilanguage
- Animation
- Improve design

## License
[MIT](https://choosealicense.com/licenses/mit/)