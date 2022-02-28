# infinite_gallery

For this project I used bloc state management. It may seem like an overkill for a small task but I assumed that this task is part of a bigger project/app. Therefore using BloC would help me keep the logic and user-interface separated for better maintainability. Also, BloC includes multiple concepts such as providers, consumers, streams, and cubits which can be useful while working on complex apps. 

I used a regular bloc class for processing and mapping different states for fetching photos from the API. Since saving/deleting user likes was simple, I used bloc cubits for processing user likes.
There are several options for local storage including Hive, Sqflight, and Shared Preferences. Shared Preferences is the easiest solution to implement but it's only suitable for light applications such as keeping track of the intro tour after the first app installation. Since this API provides up to 5000 photos there may be scenarios in which users like/save 1000+ photos on the list. Therefore  Shared Preferences is not a viable solution for this task. I picked Hive because it is faster than sqflight and also it allows saving data as key-values which is very useful and usefrindly.

Best,
Ehsan
