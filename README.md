# light house client for ios
Client for controlling Philips Hue light bulbs via the Hue Bridge API.

## Hue API Documentation
[Unofficial Hue API Documentation](http://www.burgestrand.se/hue-api/)

## Setup
### Download Xcode
Download [XCode 7.3.1](https://developer.apple.com/download/more/)

### Install Ruby 2.3.1 (for cocoapods)
Rbenv allows you to switch between different versions of Ruby

```
brew install rbenv
export PATH="$HOME/.rbenv/shims:$PATH"
rbenv global 2.3.1
ruby -v
```

### Install Cocoapods Package Manager
```
sudo gem install cocoapods
```

### Install Pods
Pods are third party packages, such as SwiftyJSON
```
cd directory/containing/podfile (project root)
pod install
```

