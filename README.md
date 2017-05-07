# README #

### What is this repository for? ###

This is a weather app written in swift 3. This app gets the weather for different cities.
  
This app uses `api.openweathermap.org` to get the weather from different cities. The user will get the weather from 10 cities close to him using his location.

### How do I get set up? ###

#### Summary of set up ####

To manage dependencies I use Cocoa Pods. But the cocoa pods folder is not in the repository, so you need to install the dependencies before you run the project.

I am using `Bundler` too, so if you want to install the dependencies with `Bundler`, you can use the following command:

`bundle exec pod install`

Then you can run the workspace in XCode

#### Dependencies ####

There are 3 dependencies in the main target and one dependency in the test target:

**ObjectMapper**

`ObjectMapper` is a library that allows you to convert JSON to a model very easily. The way to set the classes up is very similar to Mantle in Objective-C. I've chosen this library because you can work with the following dependency very easily to get the JSON from an external API. 

**AlamofireObjectMapper** 

`AlamofireObjectMapper` allows you to work with `Alamofire` and `ObjectMapper` together so it reduces a lot of boilerplate.

**Alamofire**

I use `Alamofire` for communications with the external API. This library helps you to manage the communications using blocks very nicely.

**OHHTTPStubs**

`OHHTTPStubs` is a testing framework that helps you to test all your requests to an external API. We should not test any request to external services using the external service itself, basically it could make our test fail. For example if the external service if not available anymore, the test would not work.
 
Instead we can mock the requests. This framework detects when you make a request to a HOST, so you can return a json, that you created previously in your test, instead of hitting a real endpoint.

#### Services ####

There are 3 services in this App.

### Communications Layer ###

It's managed with `CommunicationController`. This class manages all request to the API. This class uses the dependencies `ObjectMapper`,`AlamofireObjectMapper` and `Alamofire`'

### Database Layer ###

It's managed with `DataBaseController`. This class manages all the request the database. This class uses Core Data.

### Data Layer ###

It's managed with `DataController`. This class manages the data. When any data is needed in the app, this class provides the data. This class makes easier to get the data from the API and add it to the database. This class uses `CommunicationController` and `DataBaseController`

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

The app currently is using the location of the phone. As improvement the user could select in a map the location where he wants to know the weather and for the cities around to that location.

**How else could the results from the API be displayed to the user?**

As improvement, my first idea was to use a map as a main view so the user could see the weather using icons.
