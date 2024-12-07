import Appylar
import UIKit

class ViewController: InterstitialViewController {
    @IBOutlet var btnShowBanner: UIButton!
    @IBOutlet var btnHideBanner: UIButton!
    @IBOutlet var btnShowInterstitial: UIButton!
    @IBOutlet var bannerView: BannerView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set event listener before initialization
        AppylarManager.setEventListener(delegate: self, bannerDelegate: self, interstitialDelegate: self)
        
        // Initialize
        AppylarManager.initialize(
            appKey: "<YOUR_IOS_APP_KEY>", // The unique app key for your app
            adTypes: [AdType.interstitial, AdType.banner], // The ad types that you want to show
            testMode: true // Test mode, true for development, false for production
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    
    @IBAction func btnShowBannerDidTapped(_ sender: UIButton) {
        self.showBanner()
    }
    
    // Hide banner
    @IBAction func btnHideBannerDidTapped(_ sender: UIButton) {
        self.bannerView.hideAd()
        self.view.layoutIfNeeded()
    }
    
    // Show interstitial
    @IBAction func btnShowIntersitialDidTapped(_ sender: UIButton) {
        if InterstitialViewController.canShowAd() {
            self.showAd()
        }
    }
    
    // Show banner
    private func showBanner() {
        if self.bannerView.canShowAd() {
            self.bannerView.showAd()
        }
        self.view.layoutIfNeeded()
    }
}

extension ViewController: AppylarDelegate {
    // Event listener triggered at successful initialization
    func onInitialized() {
        print("onInitialized()")
    }
    
    // Event listener triggered if an error occurs in the SDK
    func onError(error: String) {
        print("onError() - \(error)")
    }
}

extension ViewController: BannerViewDelegate {
    // Event listener triggered when there are no banners to show
    func onNoBanner() {
        print("onNoBanner()")
    }
    
    // Event listener triggered when a banner is shown
    func onBannerShown() {
        print("onBannerShown()")
    }
}

extension ViewController: InterstitialDelegate {
    // Event listener triggered when there are no interstitials to show
    func onNoInterstitial() {
        print("onNoInterstitial()")
    }
    
    // Event listener triggered when an interstitial is shown
    func onInterstitialShown() {
        print("onInterstitialShown()")
    }
    
    // Event listener triggered when an interstitial is closed
    func onInterstitialClosed() {
        print("onInterstitialClosed()")
    }
}
