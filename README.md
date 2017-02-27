# ContentSqGitClient

Observations :

- I take about 14 hours developing this. My personal objective was to spend just 2 days at most
- I use some libraries using cocoapods for faster development.
	- Alamofire. One of my favorites it handles Remote conectivity like breeze
	- MBProgressHUD. For loaders.
	- Moya. To be honest this is my first time using this library. Alamofire is really messy for creating Shared libraries, normally you use routers. I find this library and it was very useful for doing a shared library. The Mapper is awesome and help you parsing all the JSON to actual Models. It is very new about 2 months old, but it has a lot of buzz in the IOS dev community. I take this opportunity to test it. The bad thing is that the Mapper is not fully compatible with test and it was very hard to make them work. 
	- PullToRefresh. I use this library just to add Pull to load more functionality. All logic is mine.
	- SDWebImage. A classic UIImage remote loader

The mini project was very fun and simple. I spend most of my time doing UI. I will do lots of new things to improve it but I believe it is in a good state to launch it to production. I would love to add more proper test and CI integration. Normally I use XIBS instead of the Storyboard. I use Storyboard because is easier and faster for smaller projects and apps.