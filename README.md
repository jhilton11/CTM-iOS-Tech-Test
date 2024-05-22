# CTM Mobile Technical Test

This is a simple RSS Feed Reader built in iOS using Swift, UIKit, Clean MVVM architecture. The app loads a list of feed items from an RSS feed and displays them in a list on a page. When the use taps on a news item in the list, the news link is opened in the app's browser to display news details.

## App Features
- The app contains a list which is essentially a tableview, which details the new items. When the user taps on the list, the link opens a web page in the phone's browser.
- There is a loader to show the user that data is being loaded from the api. It disappears when we get a result from the network.
- There is proper error handling in the app. The error is logged for easy debugging and the user is notified with an alert message.
- Users can reload news items by pulling to refresh.
- Images were cached to improve user experience.

![Simulator Screenshot - iPhone 15 - 2024-05-06 at 10 04 58](https://github.com/jhilton11/ParentPay-Technical-Test/assets/32772234/68284656-6f1e-4c8a-b3ea-be79a1440315)

## App Architecture
It was designed using clean MVVM architecture. It is to ensure separation of concerns, modularity and scalability of the app. This is to ensure that when changes are made in one part of the app, there's minimal regression in the codebase. The app is divided into 4 main modules: Model, Use Case, Data, View.

## Model
The model contains the news object/entity to be displayed in the list. It implements the protocol XMLObjectDeserialization to enable it decode the XML news item into the object. It is the base layer of the app architecture and so doesn't depend on any other layer. Rather, the layers above it depend on it.

### Use Case
The use case layer contains the uses cases of each screen. A use case is defined as a single action that can be performed such as loading feed items, opening a new detail screen etc. In this case, it contains the load feed case, which implements loading of news items from the api. It depends on the model layer only. Changes in other layers should not affect this layer. The use case is essentially a protocol that is implemented by the repository in the data layer.

### Data
The app layer holds the data repository, network layer and the local storage (yet to be implemented). The repository implements the use cases of the use case layer. It is the single source of truth. It has two dependencies: network dependency and local storage dependency. The repository loads news items from the network. Changes in the network source won't affect the repository. It also has the capacity to store and retrieve the data from any local storage of choice implemented (file, Realm, Coredata). Changes in the choice of data storage won't affect the repository.

### View
The view layer contains the viewcontroller that displays the news list and the viewmodel. The viewmodel depends on the repository, while the viewcontroller depends on the viemmodel. The viewmodel loads data from the repository and presents it to the viewcontroller. It ensures separation of concerns and effectively separates the view from data and data sources so that the view is not tightly coupled to data sources.
This way, the view can be built using any means either through UIKit or SwiftUI.

## Unit Testing
Unit testing was implemented using XCTests to test the repository, viewmodel and parsing of XML data.

## Libaries Used
Snapkit (https://github.com/drmohundro/SWXMLHash) - To build the UI programmatically.

SWXMLHash (https://github.com/SnapKit/SnapKit) - To parse XML data to custom models
