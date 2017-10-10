# Equalizer
Animated adjustable UI component imitating volume equalizer.

For proper display needed to set offset between blocks, number of columns and rows.

```swift
init() {
        equalizerView = EqualizerView(
            rowSpacing: 1,
            columnSpacing: 3,
            columnsNumber: 8,
            rowsNumber: 8
        )
        super.init(frame: .zero)
    }
```

Build using UIStackView for easy scalability. Because of that it needed to set contraints for the size of component.

```swift
private func configureConstraints() {
        addSubview(equalizerView)
        equalizerView.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.height.equalTo(CGFloat(rowsNumber + 1) * EqualizerComponent.defaultHeight + CGFloat(rowsNumber - 1) * rowSpacing)
            maker.width.equalTo(CGFloat(columnsNumber + 1) * EqualizerComponent.defaultWidth + CGFloat(columnsNumber + 1) * columnSpacing)
        }
    }
```
![example](https://user-images.githubusercontent.com/8987437/31400445-ed72d2d2-adef-11e7-997b-6f202d530ea2.png)
