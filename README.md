# CleanArchitectureLeakSample

## 原因
### Wireframe <-> ViewControllerの参照  
`Wireframe` が持っている `viewController` への参照が残っていたいため、
`Presenter` が `deinit` されずに残っていた。

なので `viewController` を `weak` で持つように修正。

```Swift
struct WireframeImpl: Wireframe {
    weak var viewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
```

### クロージャーのweakつけ忘れ( 今更 )
`weak`でキャプチャーするように修正。

```Swift
private func createLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { [weak self] (section, _) -> NSCollectionLayoutSection? in
        guard let self = self else { return nil }
        return self.dataSource[section].layout
    }
    return layout
}
```
