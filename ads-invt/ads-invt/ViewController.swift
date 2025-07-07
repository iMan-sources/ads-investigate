//
//  ViewController.swift
//  ads-invt
//
//  Created by Le Viet Anh on 7/7/25.
//

import UIKit
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

class ViewController: UIViewController, NativeAdDelegate {
    
    private var adLoader: AdLoader!
    
    let adView: NativeAdView = {
        let view = NativeAdView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    let adLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemYellow
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.text = "Ad"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MobileAds.shared.requestConfiguration.testDeviceIdentifiers = [ "025df51d424f9da6aee24f3051f47871" ]
        
        // Request tracking authorization before accessing IDFA
        DispatchQueue.main.async {
            self.requestTrackingAuthorization()
        }
        
    }
    
    private func requestTrackingAuthorization() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        print("✅ Tracking authorized")
                        self.accessIDFA()
                        self.loadAds()
                    case .denied:
                        print("❌ Tracking denied")
                        self.loadAds() // Still load ads, but without IDFA
                    case .restricted:
                        print("⚠️ Tracking restricted")
                        self.loadAds()
                    case .notDetermined:
                        print("🤷‍♂️ Tracking not determined")
                        self.loadAds()
                    @unknown default:
                        print("🤔 Unknown tracking status")
                        self.loadAds()
                    }
                }
            }
        } else {
            // iOS 13 and below - can access IDFA directly
            accessIDFA()
            loadAds()
        }
    }
    
    private func accessIDFA() {
        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        let isTrackingEnabled = ASIdentifierManager.shared().isAdvertisingTrackingEnabled
        
        print("📱 IDFA: \(idfa)")
        print("🎯 Tracking Enabled: \(isTrackingEnabled)")
        
        // You can now use the IDFA for your advertising purposes
        // For example, set it in Google Mobile Ads request configuration
        if isTrackingEnabled {
            // Use IDFA for personalized ads
            print("✨ IDFA is available for personalized advertising")
        } else {
            print("🔒 IDFA is not available - using limited ads")
        }
    }
    
    private func loadAds() {
        adLoader = AdLoader(adUnitID: "ca-app-pub-3940256099942544/3986624511",
                            rootViewController: self,
                            adTypes: [.native],
                            options: nil)
        adLoader.delegate = self
        adLoader.load(Request())
    }
    
    private func setupAdView() {
        view.addSubview(adView)
        adView.addSubview(adLabel)
        
        NSLayoutConstraint.activate([
            adView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            adView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            adView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            adView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
}

extension ViewController: NativeAdLoaderDelegate {
    func adLoader(_ adLoader: AdLoader, didReceive nativeAd: NativeAd) {
        // Set ourselves as the native ad delegate to be notified of native ad events.
        nativeAd.delegate = self
        
        setupAdView()
        
        adView.mediaView?.mediaContent = nativeAd.mediaContent
        
        if let mediaView = adView.mediaView, nativeAd.mediaContent.aspectRatio > 0 {
            let heightConstraint = NSLayoutConstraint(
              item: mediaView,
              attribute: .height,
              relatedBy: .equal,
              toItem: mediaView,
              attribute: .width,
              multiplier: CGFloat(1 / nativeAd.mediaContent.aspectRatio),
              constant: 0)
            heightConstraint.isActive = true
          }

        
        
    }
    
    func adLoader(_ adLoader: AdLoader, didFailToReceiveAdWithError error: any Error) {
        
    }
    
    
}
