# README #

This is a weather app written in swift 3 and updated to swift 4. This app gets the weather information of 10 different places around you using the device location.
  
This app uses `api.openweathermap.org` to get the weather information. 

### How do I get set up? ###

#### Summary of set up ####

To manage dependencies I use Cocoa Pods. But the cocoa pods folder is not in the repository, so you need to install the dependencies before you run the project.

I am using `Bundler` too, so if you want to install the dependencies with `Bundler`, you can use the following command:

`bundle exec pod install`

Then you can run the workspace in XCode

#### Dependencies ####

There are 3 dependencies in the main target and one dependency in the test target:

**ObjectMapper**

`ObjectMapper` is a library that allows you to convert JSON to a model very easily. The way to set up the classes is very similar to Mantle in Objective-C. I've chosen this library because it's very easy to convert the JSON from an external API in your communications model.

**AlamofireObjectMapper** 

`AlamofireObjectMapper` allows you to work with `Alamofire` and `ObjectMapper` together so it reduces a lot of boilerplate.

**Alamofire**

I use `Alamofire` for communications with the external API. This library helps you to manage the communications using blocks very nicely.

**OHHTTPStubs**

`OHHTTPStubs` is a testing framework that helps you to test all your requests to an external API. We should not test any request to external services using the external service itself, basically it could make our test fail randomly. For example if the external service if not available anymore, the test may not pass.
 
Instead we can mock the requests. This framework is able to detect when you make a request to a particular HOST, so you can return the json created previously in your test, instead of hitting a real endpoint.

#### Services ####

There are 3 services in this App.

### Communications Layer ###

Main class `CommunicationController`. This class manages all request to the API. This class uses the dependencies `ObjectMapper`,`AlamofireObjectMapper` and `Alamofire`'

### Database Layer ###

Main class `DataBaseController`. This class manages all the request the database. This class uses Core Data.

### Data Layer ###

Main class `DataController`. This class manages the data. When any data is needed in the app, this class provides the data. This class makes easier to get the data from the API and add it to the database. This class uses `CommunicationController` and `DataBaseController`

#### How to run tests ####

To run the test just run the test mode in XCode, it will run the test target

#### Design Patterns ####

The design pattern used is MVC. But I tried to keep the ViewController as smallest as possible, creating data provider with protocols. Also I've split the functionality of the Viewcontroller with extensions.

#### Other considerations ####

Some classes and functions have comment created with `Header Doc`. So as improvement I need to add all the comments in all functions and classes to have all the app documented

#### Suggestions / Points ####

**Consider the best way to store the information to disk for offline viewing,
choose an appropriate method for the given task.**

I used Core Data because it's easy to use and to extend.'

**Think about the latitude / longitude you are passing up to the API. How do
you decide what this location is? What would the user want to do?**

The app currently is using the location of the phone. As improvement the user could select in a map the location where he wants to know the weather information.

**How else could the results from the API be displayed to the user?**

As improvement, my first idea is to use a map as a main view so the user could see the weather using icons.
