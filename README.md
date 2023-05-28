# SimpleWeatherApp


SimpleWeatherApp is a iOS application developed using the MVVM architectural pattern, designed to provide users with an immersive weather experience.
The app leverages the power of Swift and UIKit to deliver a seamless and intuitive user interface.


## GitFlow Strategy

<img src="https://github.com/onurduyar/SimpleWeatherApp/blob/main/Assets/gitflow.png" alt="">

## Project Development Process

During the development process of this project, Trello was used for project management and git version control system was used for code base management. During the project development process, I determined and assigned tasks as if I was working in a team.

<img src="https://github.com/onurduyar/SimpleWeatherApp/blob/main/Assets/trello.png" width="700" alt="">



## Features

- Programmatic UI
- Generic Network Layer
- Only URLSession
- UIView+Extensions
- Both SwiftUI And UIKit Interface
- BaseViewModel
- Env. file for 'API_KEY'

## Screenshots 

| SwiftUI - WeatherView   | UIKit - WeatherView    | CitiesView             |
| ------------ | ------------- | ------------------ |
| <img src="https://github.com/onurduyar/SimpleWeatherApp/blob/main/Assets/swiftu%C4%B1-weatherview.png" width="270" height = "300%" alt=""> | <img src="https://github.com/onurduyar/SimpleWeatherApp/blob/main/Assets/uikit-weatherview.png" width="270" height = "300%" alt="">    | <img src="https://github.com/onurduyar/SimpleWeatherApp/blob/main/Assets/citiesview.png" width="270" height = "300%" alt=""> |


## Requirements
<img src="https://github.com/onurduyar/SimpleWeatherApp/blob/main/Assets/weatherpage.png" width="600" alt="">
<img src="https://github.com/onurduyar/SimpleWeatherApp/blob/main/Assets/citiespage.png" width="600" alt="">

## Project Architecture - MVVM
<img src="https://github.com/onurduyar/SimpleWeatherApp/blob/main/Assets/mvvm.png" width="700" alt="">


## Code Samples

### BaseViewModel

```swift

class BaseViewModel {
    let networkService = BaseNetworkService()
    
    func handleRequestResult<T>(result: Result<T, Error>, successBlock: (T) -> Void, failureBlock: (Error) -> Void) {
        switch result {
        case .success(let response):
            successBlock(response)
        case .failure(let error):
            failureBlock(error)
        }
    }
}
```

### UIView+Extension


```swift

func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, topPadding: CGFloat = 0, leadingPadding: CGFloat = 0, trailingPadding: CGFloat = 0, bottomPadding: CGFloat = 0) {

        translatesAutoresizingMaskIntoConstraints = false
       
        if let top{
            topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        
        if let leading{
            leadingAnchor.constraint(equalTo: leading, constant: leadingPadding).isActive = true
        }
        
        if let trailing{
            trailingAnchor.constraint(equalTo: trailing, constant: trailingPadding).isActive = true
        }
        
        if let bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: bottomPadding).isActive = true
        }
    }
```
 
