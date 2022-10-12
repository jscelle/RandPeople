# RandPeople 

The app simply shows random users from api, with options to take a closer look to each one.😦
App also storing all of the users on disk, so if there is no internet, you can still use it.

## How to setup
Clone this project, run _pod install_ in terminal, inside _project location_

## What did i use

### Architecture
- MVVM With flow coordinators
### For navigation
- [RxFlow](https://github.com/RxSwiftCommunity/RxFlow)
### API
- [RandomUserAPI](https://randomuser.me)
### For almost everything 😵‍💫
- [RxSwift](https://github.com/ReactiveX/RxSwift)
### Network layer
- [Moya](https://github.com/Moya/Moya)
### Image downloading and caching 
- [Kingfisher](https://github.com/onevcat/Kingfisher)
### Database
- [Realm](https://github.com/realm/realm-swift)
### For testing 
- [Quick/Nimble](https://github.com/Quick/Nimble)
### For UI
- [SnapKit](https://github.com/SnapKit/SnapKit)

## TODO
- Test error handling (its working but not covered by Unit tests yet🫠)
- Somehow make tests for View controllers 
- Implement better data handling strategy, maybe, something like this: [Carlos](https://github.com/spring-media/Carlos)

## Screenshots

![Simulator Screen Shot - iPhone 14 Pro - 2022-10-12 at 13 45 53](https://user-images.githubusercontent.com/77747763/195327537-1b29fe53-ff03-4553-a683-dfdb9ec6e4db.png)
![Simulator Screen Shot - iPhone 14 Pro - 2022-10-12 at 13 46 00](https://user-images.githubusercontent.com/77747763/195327550-8b89f2e1-21c8-4c57-9592-f414cd48f63a.png)
![Simulator Screen Shot - iPhone 14 Pro - 2022-10-12 at 13 46 05](https://user-images.githubusercontent.com/77747763/195327566-1e8ed5c6-c7ea-41b0-a483-64b0a9d420dc.png)
