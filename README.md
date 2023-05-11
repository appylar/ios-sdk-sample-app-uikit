# Integration of Appylar for iOS
  Appylar is an SDK framework created by Appylar that provides ad-serving capabilities for iOS mobile applications.
 <a name="readme-top"></a>
 <!-- TABLE OF CONTENTS -->
  <p>Implementation Guide for Developers: </p>
  <ol>
    <li>
      <a href="#about-appylar">About Appylar</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#ad-types">Ad Types</a>
    </li>
    <li><a href="#general-requirements">General Requirements</a></li>
    <li>
    <a href="#implementation">Implementation</a>
     <ul>
	<li><a href="#pod-installation">Pod Installation</a></li>
        <li><a href="#add-appylar">Add Appylar</a></li>
	<li><a href="#setup-the-configuration-for-your-app-and-listeners">Setup the configuration for your App and Listeners</a></li>
	<li><a href="#implementation-of-banner">Implementation of Banner</a></li>
	<li><a href="#add-interstitial-ads">Add Interstitial Ads</a></li>   
      </ul>
    </li>
    <li><a href="#sample-codes">Sample Codes</a></li>
  </ol>

## About Appylar
Appylar is a lightweight and user-friendly SDK for integrating ads into iOS applications, developed by Appylar. With this SDK, developers can easily integrate Appylar Ads into any type of iOS app

#### Built With
 * [Swift](https://docs.swift.org/assets/images/swift.svg)

## Ad Types
Appylar offers multiple ad types and provides developers with the flexibility to place ads anywhere within their application. The ad types available with Appylar are banners and interstitials.
 
## General Requirements
 * Appylar requires a minimum targeted version of iOS 12.0 or later.

## Implementation
To use Appylar Ads in your application, you need to follow these steps. Please note that additional implementation steps may be required based on your specific use case:
 #### Pod Installation
 Adding Pods to an Xcode project
 
 * Open a terminal window, and type -> cd /projectpath/ from project directory.
 * Create a Podfile. This can be done by running $ pod init.
 * Add a CocoaPod by specifying pod 'Appylar' on a single line inside your target block.
     ```     
     target ‘Your App Name’ do
     pod 'Appylar'
     end
     ```
  * Save your Podfile.
  * Run pod install command
  * Open the "xcworkspace" that was created after pod installation. ".xcworkspace" should be the file you use everyday for your app.

 
 #### Add Appylar 

 Before proceeding with Appylar Ads integration, ensure that the Pods directory is available in your project. Once confirmed, you can import the necessary class into your UIViewController class

 ```swift
 import UIKit
 import Appylar
 ```

<p align="right"><a href="#readme-top">Back To Top</a></p>

#### Setup the configuration for your App and Listeners


1. To implement Appylar Ads in your iOS application, create an extension of UIViewController() and override its viewDidLoad() method. Additionally, implement the AppylarDelegate protocol within this extension. If you already have an application subclass in your project, you can use that instead.

```swift
import UIKit
import Appylar

class ViewController: UIViewController{
      	Override func viewDidLoad(){
            	super.viewDidLoad()  
		//Attach callback listeners for SDK before initialization
                AppylarManager.setEventListener(delegate: self,bannerDelegate: self,interstitialDelegate: self)  
            	//Here ‘setEventListener’ is a method for AppylarManager
            	//Initialization
            	……
         }
}
//Attach callbacks for initialization
extension ViewController: AppylarDelegate {
    	func onInitialized() {
              	//Callback for successful initialization
      	}

     	func onError(error: String) {
                //Callback for error thrown by SDK
        }
}
```

2. Initialize SDK with configuration:
```swift
import UIKit
import Appylar

class ViewController: UIViewController{
      	Override func viewDidLoad(){
		super.viewDidLoad() 
		//Attach callback listeners for SDK before initialization
                AppylarManager.setEventListener(delegate: self,bannerDelegate: self,interstitialDelegate: self)  
            	//Here ‘setEventListener’ is a method for AppylarManager
		//Initialization
           	AppylarManager.Init(                        
          		app_Key: "<YOUR_APP_KEY>", //APP KEY provided by console for Development use
 			Adtypes: [AdType.BANNER, AdType.INTERSTITIAL],	//Types of Ads to integrate
			orientations: [Orientation.PORTRAIT, Orientation.LANDSCAPE], 	//Supported orientations for Ads
			testmode: true // ‘True’ for development and ‘False’ for production, 
			)
          }
}

```

3.To further customize the Appylar Ads, you can use the setParameters() function after a valid session exists or after intialization.
```swift
Override func viewDidLoad(){
   	super.viewDidLoad()  
	//Attach callback listeners for SDK before initialization
     	AppylarManager.setEventListener(delegate: self,bannerDelegate: self,interstitialDelegate: self)
        //Here ‘setEventListener’ is a method for AppylarManager
	//Initialization
	AppylarManager.Init(                        
          		app_Key: "<YOUR_APP_KEY>", //APP KEY provided by console for Development use
 			Adtypes: [AdType.BANNER, AdType.INTERSTITIAL],	//Types of Ads to integrate
			orientations: [Orientation.PORTRAIT, Orientation.LANDSCAPE], 	//Supported orientations for Ads
			testmode: true // ‘True’ for development and ‘False’ for production, 
			)
     	AppylarManager.setParameters(dict: [
            "banner_height" : self.selectedHeightOfBanner != nil ? ["\(String(self.selectedHeightOfBanner!))"] : nil, // Height is given by user [“50”,”90]
            "age_restriction" : self.selectedAge != nil ? ["\(String(self.selectedAge!))"] : nil //Age is given by user[“12”,”15”,”18”] 
        ])  
     }
```
<p align="right"><a href="#readme-top">Back To Top</a></p>

#### Implementation of Banner 

1. To integrate the BannerView component into your design, you need to prepare a view from the storyboard and set it to the BannerView type. Follow these steps:
  * Drag a view from the library to your UIViewController.
  * In the Attribute Inspector, set the class to BannerView and the module to Appylar.
  * Create an outlet of type BannerView in your UIViewController to link it with the storyboard view.

```swift
@IBOutlet weak var topBannerView: BannerView!
```	 

2. Implement callback for banners.

```swift
//Attach callbacks for banner.
func onNoBanner(){
    	//Callback for when there is no Ad to show.  
   }
func onBannerShown() {
       //Callback for Ad shown.  
   }
```

3. Check Ad availability and show the Ad. <br>
For better performance and check the availability of ads you have to use `canShowAd()` function.
```swift
   if topBannerView.canShowAd(){             
  	// showAd function with the value of placement
  	 self.topBannerView.showAd(placement: txtfieldEnterPlacement.text ?? "" )
	// showAd function without placement parameter
	 self.topBannerView.showAd()            
  }
```
   The parameter placement is optional, and it is up to the developer to decide whether to pass it or not.

4. To hide the banner.

```swift
   topBannerView.hideBanner()
```
<p align="right"><a href="#readme-top">Back To Top</a></p>

#### Add Interstitial Ads

1. Make your `ViewController` of type `InterstitialViewController`.  
```swift
   class ViewController: InterstitialViewController
```

2. Implement callbacks for Interstitial.
```swift
//Attach callbacks for interstitial.
func onNoInterstitial(){
    	//Callback for when there is no Ad to show.  
   }
func onInterstitialShown() {
       //Callback for Ad shown.  
   }
func onInterstitialClosed() {
    	//Callback for close event of interstitial
   }
```	

3. Check Ad availablity and show the Ad.<br>
 For better performance and check the availability of ads you can `canShowAd()` function.
```swift
if  InterstitialViewController.canShowAd() {
  	self.showAd(placement: self.txtfieldEnterPlacement.text ?? "")
}
```
   The parameter placement is optional, and it is up to the developer to decide whether to pass it or not.

4. For lock the orientation of interstitial in your `AppDelegate` and override a function in it.

```swift
      func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask 	{
           return AppylarManager.supportedOrientation
        }
```
<p align="right"><a href="#readme-top">Back To Top</a></p>

## Sample Codes

1. For orientation lock of interstitial:
In your AppDelegate class override a below function:
```swift
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
           return AppylarManager.supportedOrientation
  }
```
2.  Implements for both the types:

```swift
import UIKit
import Appylar

class ViewController: InterstitialViewController { 

@IBOutlet weak var topBannerView: BannerView!  
 
Override func viewDidLoad() {
    super.viewDidLoad()
    //Attach callback listeners for SDK before initialization
    AppylarManager.setEventListener(delegate: self,bannerDelegate: self,interstitialDelegate: self)
    //Here ‘setEventListener’ is a method for AppylarManager
    //Initialization
    AppylarManager.Init(
        app_Key: "<YOUR_APP_KEY>", //APP KEY provided by console for Development use    ["OwDmESooYtY2kNPotIuhiQ"]
        Adtypes: [AdType.BANNER, AdType.INTERSTITIAL]    //Types of Ads to integrate
        orientations: [Orientation.PORTRAIT, Orientation.LANDSCAPE],     //Supported orientations for Ads
        testmode: true // ‘True’ for development and ‘False’ for production,
    )
}
    @IBAction func btnShowBannerDidTapped(_ sender: UIButton) {     
         if topBannerView.canShowAd() {
             self.topBannerView.showAd() // MARK:- Placement parameter is optional for func showAd
        }
    }
    
  @IBAction func btnHideBannerDidTapped(_ sender: UIButton) {
        self.topBannerView.hideBanner()
       	self.view.layoutIfNeeded()
   }
    
   @IBAction func btnShowIntersitialDidTapped(_ sender: UIButton) {
      	if  InterstitialViewController.canShowAd(){
		self.showAd(placement: self.txtfieldEnterPlacement.text ?? "")
		 // MARK:- Placement parameter is optional for func showAd
       	} 
   }
}
//Attach callbacks for Initialization.
extension ViewController : AppylarDelegate {
    func onInitialized() {
        Print("onInitialized() ")
    }
    
    func onError(error : String) {
        Print("onError() - \(error)")
    }
}  
//Attach callbacks for banner.
extension ViewController: BannerViewDelegate{
    func onNoBanner() {
        Print("onNoBanner()")
    }
    
    func onBannerShown() {
        Print("onBannerShown()")
    }  
}
//Attach callbacks for interstitial.
extension ViewController: InterstitialDelegate{
    func onNoInterstitial() {
        Print("onNoInterstitial()")
    }
    
    func onInterstitialShown() {
        Print("onInterstitialShown()")
    }
    
    func onInterstitialClosed() {
        Print("onInterstitialClosed()")
    }
}
```
<p align="right"><a href="#readme-top">Back To Top</a></p>
 
