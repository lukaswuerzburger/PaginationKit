<p align="center">
    <img src="https://raw.githubusercontent.com/lukaswuerzburger/PaginationKit/develop/readme-images/logo.png" alt="PaginationKit" title="PaginationKit" width="128"  height="128"/><br/>
    <b>PaginationKit</b><br/>
    <br/>
    <img src="https://img.shields.io/badge/Swift-5-orange" alt="Swift Version" title="Swift Version"/>
    <a href="https://travis-ci.org/lukaswuerzburger/PaginationKit"><img src="https://travis-ci.org/lukaswuerzburger/PaginationKit.svg?branch=develop" alt="Build Status" title="Build Status"/></a>
    <a href="https://cocoapods.org/pods/PaginationKit"><img src="https://img.shields.io/cocoapods/v/PaginationKit.svg?style=flat-square" alt="CocoaPods Compatible" title="CocoaPods Compatible"/></a>
    <img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square" alt="License MIT" title="License MIT"/>
</p>


## Contents

- ✍️ [Description](#%EF%B8%8F-description)
- 🖥 [Example](#-example)
- 🎟 [Demo](#-demo)
- 🔨 [Customization](#-customization)
- 💻 [How to use](#-how-to-use)
- ⚠️ [Requirements](#%EF%B8%8F-requirements)
- 💪 [Contribute](#-contribute)

## ✍️ Description

The `PaginationController` provides the logic to paginate through a list with limited request results. It also provides a `TableViewPaginationController` that adds and removes a loading view to the `tableFooterView`.

## 🖥 Example

```swift
class ViewController: UITableViewController {

    var items: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        paginationController = TableViewPaginationController(tableView: tableView) { previousPage, callback in

            // Imagine an API call being made here.
            self.loadMore(after: previousPage) { page in
                self.items += page?.results ?? []
                self.tableView.reloadData()
                callback(page)
            }
        }
    }
}
```

## 🎟 Demo

<img src="https://raw.githubusercontent.com/lukaswuerzburger/PaginationKit/develop/readme-images/demo.gif" alt="PaginationKit Demo" title="PaginationKit Demo" width="320"/>

You can find this demo app in this repository.

## 🔨 Customization

**Custom Loading View:**

If you want to show your own loading view you can use any `UIView` conforming to the `LoadingAnimatable` protocol described [here](PaginationKit/Sources/LoadingAnimatable.swift).

Pass it to the initializer:
```swift
paginationController = TableViewPaginationController(loadingView: MyLoadingView(), ...)
```

Or set the property:
```swift
paginationController.loadingView = MyLoadingView()
```

Check out the Demo 

## 💻 How to use

**Cocoapods**:  
`PaginationKit` is available on Cocoapods. Just put following line in your `Podfile`:
```ruby
pod 'PaginationKit'
```

**Swift Package Manager**:  
Add the following to your `Package.swift` file:
```swift
dependencies: [
    .package(url: "https://github.com/lukaswuerzburger/PaginationKit.git", from: "1.0.0")
]
```

## ⚠️ Requirements

- Swift 5+
- iOS 10+
- Xcode 11+

## 💪 Contribute

Issues and pull requests are welcome.
