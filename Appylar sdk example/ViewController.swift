//
//  ViewController.swift
//  Appylar sdk example
//
//  Created by 5Exceptions on 16/12/22.
//

import UIKit
import Appylar

class ViewController: InterstitialViewController {
    @IBOutlet weak var btnShowBanner: UIButton!
    @IBOutlet weak var btnHideBanner: UIButton!
    @IBOutlet weak var btnShowInterstitial: UIButton!
    @IBOutlet weak var topBannerView: BannerView!
    @IBOutlet weak var txtPlacement: UITextField!
    
    var apiKey = "OwDmESooYtY2kNPotIuhiQ"
    var selectedAdTypes = [AdType.interstitial, AdType.banner]
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            txtPlacement.delegate = self
        } else {
            // Fallback on earlier versions
        }
        txtPlacement.placeholder = "Enter placement(Optional)"
        AppylarManager.setEventListener(delegate: self,bannerDelegate: self,interstitialDelegate: self)
        AppylarManager.Init(appKey: apiKey, adTypes: self.selectedAdTypes , testMode: true)
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
            self.showAd() // MARK:- Placement parameter is optional for func showAd
        }
    }
    
    private func showBanner(){
        if topBannerView.canShowAd(){
            self.topBannerView.showAd(placement: txtPlacement.text ?? "") // MARK:- Placement parameter is optional for func showAd
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

//UI
@available(iOS 13.0, *)
extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtPlacement.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        txtPlacement.becomeFirstResponder()
    }
    
}
