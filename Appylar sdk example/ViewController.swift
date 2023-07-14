import UIKit
import Appylar

class ViewController: InterstitialViewController {
    @IBOutlet weak var btnShowBanner: UIButton!
    @IBOutlet weak var btnHideBanner: UIButton!
    @IBOutlet weak var btnShowInterstitial: UIButton!
    @IBOutlet weak var topBannerView: BannerView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppylarManager.setEventListener(delegate: self,bannerDelegate: self,interstitialDelegate: self)
        AppylarManager.Init(appKey: "OwDmESooYtY2kNPotIuhiQ", adTypes: [AdType.interstitial, AdType.banner] , testMode: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @IBAction func btnShowBannerDidTapped(_ sender: UIButton) {
        showBanner()
    }
    
    @IBAction func btnHideBannerDidTapped(_ sender: UIButton) {
        self.topBannerView.hideAd()
        self.view.layoutIfNeeded()
    }
    
    @IBAction func btnShowIntersitialDidTapped(_ sender: UIButton) {
        if InterstitialViewController.canShowAd(){
            self.showAd()
        }
    }
    
    private func showBanner(){
        if topBannerView.canShowAd(){
            self.topBannerView.showAd()
        }
        self.view.layoutIfNeeded()
    }
}

extension ViewController : AppylarDelegate {
    func onInitialized() {
        print("onInitialized()")
    }
    
    func onError(error : String) {
        print( "onError() - \(error)")
    }
}

extension ViewController: BannerViewDelegate{
    func onNoBanner() {
        print("onNoBanner()")
    }
    
    func onBannerShown() {
        print( "onBannerShown()")
    }
}

extension ViewController: InterstitialDelegate{
    func onNoInterstitial() {
        print( "onNoInterstitial()")
    }
    
    func onInterstitialShown() {
        print( "onInterstitialShown()")
    }
    
    func onInterstitialClosed() {
        print( "onInterstitialClosed()")
    }
}

