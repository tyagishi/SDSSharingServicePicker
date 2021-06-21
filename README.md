# SDSSharingServicePicker


## Feature

NSSharingServicePicker wrapped with NSViewRepresentable with Button for SwiftUI

![SDSSharingServicePicker](https://user-images.githubusercontent.com/6419800/108616507-3d9ffc00-7451-11eb-92ff-7785065855b1.gif)
<!-- 
note: can use not only png but also gif 
-->

## Code Example
in SwiftUI View
```
SDSSharingServicePicker(itemProvider: {
        // provide items as [Any]
        return []
    },
    completion: { service in
        // called after service is selected
        // service will be nil, if user cancel the operation
    })
```

## License
MIT license

## Installation
With Swift Package Manager, File -> Swift Packages -> Add Package Dependency
```
URL: https://github.com/tyagishi/SDSSharingServicePicker
```

## Requirements
macOS 11

## TODO
- [ ] make custom point for button appearance

## Note
