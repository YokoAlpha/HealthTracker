# Health Tracker app          
![alt text](https://github.com/YokoAlpha/HealthTracker/blob/master/HealthTracker/AppSummary%402.png "")

 
Health Tracker app is designed to improve users health in regards to two aspects: eating habits and fitness activity. Once the app is switched on it will work in background of users iPhone to track user’s movement and record it so that user can be given feedback on his fitness performance and suggestions on how to improve.
Healthy eating is another essential aspect of wellbeing therefore Health App will assist user in recording what they have eaten and then it will evaluate if user had essential daily nutrition. If user didn’t have their “5 a day” app will remind them of it. While using the app customer will be able to see his progress of increased fitness activity, better eating habits and improved BMI. My app will simply help users to discover when they are active and will help then to better their fitness performance so that without changing their lifestyle they can still improve their health.

## Abstract

The purpose of this project is to create an app for iPhone that will help users to improve their health in regards to two aspects: eating habits and fitness activity. This app will allow users to record their day-to-day fitness such as walking to bus by tracking their movement and then scoring that activity based on their speed, distance and frequency. Then motivating them to improve these fitness numbers without changing their lifestyle. Health Tracker will also allow user to record food that they have consumed during a day and it will give user feedback about that consumption. Another part of this app will be ability to monitor BMI which is a body mass index system recommended by NHS and used by doctors. All these aspects of Health Tracker app will be designed to that help users discover their current fitness activity and eating habits and to will help then to better their fitness performance so that without changing their lifestyle they can still improve their health.

## Database- storage
Core data was used for managing the persistent storage because it allowed more flexible mapping of relationships between objects you can create the data model using Xcode’s built-in editor to define entities, properties, and relationships.  Then, work with the Core Data framework to store and fetch your persisted object data. SQLite database was also considered but it didn’t support the following features, undo, synchronizing with a remote database, easy fetch requests using predicate searches, fast handling of large datasets. These features would allow health tracker to be expandable. Database schemas can also be versioned so that old users upgrading can have a way of moving there existing runs, food records etc. transferred. During development I had to reset the simulator when I was adding additional entities because otherwise the app did not recognise the existing schema.

## Fetch- requests

I created fetch request to get the User and Food objects, I didn’t need to use NSPredicate to perform advanced queries but I could of used it for e.g. All the starchy foods for a specific day this makes the model layer very flexible.

## Persistent-store-coordinator

The persistent store is the mediator between the app on disk and the app running in memory, when a user closes the app we still need to keep the data they have, ensuring that the persistent store coordinator can work correctly is vital for retaining user data. This was managed by the app delegate this guide was used to add the database to the project.

## Content management  

Health tracker receives changes to the users details and consumed foods through the shared assessor class (HealthTracker), this class holds a managed context that coordinates with the persistent store coordinator to actually save to disk. The advantage if this approach is its much faster than each view controller managing it’s own context, + it reduces the amount of boilerplate database code outside of the model layer which is good for adhering the MVC structure.


## Managed-subclasses-(NSManagedObject)

Managed subclasses were used to allow quick generation of model classes from the entity relationship diagram. In the future I would like to use the Data model tool to manage entity fetch requests to reduce the amount of code needed to fetch objects, also if this app were in the app store a new mapping model would be needed so users could migrate between versions. Build in data types were used, e.g. integer, date, array,string etc instead of custom ones. Transformable type are more complex because then you need to write the encode and decode functions for each object so that they can be save in persistent storage.

## Map-kit-and-Acceleration


The running screen makes extensive use of apples MapKit and Core location framework. It was decided that it would be appropriate to separate the different functions that make up a run to make it easier to develop the feature. For this many example apps were created. The app uses “MKUserTrackingModeFollowWithHeading” when the app is loaded to follow the user location, without this the map would not update its map viewpoint when the user moved. A location manager is setup to keep track of significant changes in location, which then triggers delegate methods which health tracker uses to plot the polyline and calculate distance.

## Future development

1. Add achievements for going faster or eating less carbohydrates etc
2. Use iOS10 Fitness features to be explored with new APIS and devices.
3. The fitness market with iOS is huge right now with most of the top apps being health related and with future iWatch on horizon it would be great to submit this to the app store. Also in the future integrate with wearable platforms such as Nike Fuelband.
4. Tracking other types of exercise e.g. bike riding swimming, skiing etc.
5. Tracking of different performance metrics using data collected from user.
6. In the future the local notifications could be used to give the user feedback on how they are doing, this could be achieved by scheduling a notification after they have updated their result.
7. Using geo fencing I could add the ability to sense that the user was in their usual running sport and reopen the app from background and ask if they want to run.
