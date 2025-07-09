//
//  AdsViewController.swift
//  ads-invt
//
//  Created by Le Viet Anh on 9/7/25.
//

import UIKit
import GoogleMobileAds

// MARK: - Main View Controller
class AdsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemGroupedBackground
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var nativeAdData: [NativeAdData] = []
    var adLoader: AdLoader!
    var adUnitIDNative = "/21775744923/example/native" // "/21775744923/example/native"
    
    var bannerDefaultAdId = "/23297123788/test_approve" //"/23297123788/a2_//sregs/newslidebannerblock"
    /// The native custom format id
    let nativeCustomFormatId = "12387226"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadSampleNativeAds()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        title = "Native Ads"
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NativeAdStyleTableViewCell.self, forCellReuseIdentifier: NativeAdStyleTableViewCell.identifier)
    }
    
    private func loadSampleNativeAds() {
        
        var adTypes = [AdLoaderAdType]()
        adTypes.append(.customNative)
        
        adLoader = AdLoader(
            adUnitID: adUnitIDNative, rootViewController: self,
            adTypes: adTypes, options: nil)
        adLoader.delegate = self
        adLoader.load(Request())
        
        nativeAdData = generateSampleAdData()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func generateSampleAdData() -> [NativeAdData] {
        return [
            NativeAdData(
                headline: "Epic Adventure RPG - Dragon Quest",
                body: "Embark on an epic journey through mystical lands. Battle dragons, collect treasures, and become the ultimate hero in this immersive RPG experience.",
                advertiser: "GameStudio Entertainment",
                callToAction: "PLAY NOW",
                appIconName: "gamecontroller.fill",
                mediaImageName: nil,
                starRating: 4.8,
                price: "FREE"
            ),
            
            NativeAdData(
                headline: "FitTracker Pro - Health & Fitness",
                body: "Transform your fitness journey with personalized workout plans, nutrition tracking, and real-time health monitoring. Join millions of users!",
                advertiser: "HealthTech Solutions",
                callToAction: "START FREE",
                appIconName: "heart.fill",
                mediaImageName: nil,
                starRating: 4.6,
                price: "$9.99/month"
            ),
            
            NativeAdData(
                headline: "PhotoMaster - AI Photo Editor",
                body: "Create stunning photos with AI-powered editing tools. Remove backgrounds, enhance colors, and add professional effects in seconds.",
                advertiser: "Creative Labs Inc",
                callToAction: "TRY FREE",
                appIconName: "camera.fill",
                mediaImageName: nil,
                starRating: 4.4,
                price: "$4.99"
            ),
            
            NativeAdData(
                headline: "MusicStream Premium",
                body: "Unlimited music streaming with high-quality audio. Discover new artists, create playlists, and enjoy ad-free listening experience.",
                advertiser: "SoundWave Media",
                callToAction: "LISTEN NOW",
                appIconName: "music.note",
                mediaImageName: nil,
                starRating: 4.7,
                price: "FREE Trial"
            ),
            
            NativeAdData(
                headline: "QuickDelivery - Food & Groceries",
                body: "Get your favorite meals and groceries delivered in 30 minutes or less. Order from thousands of restaurants and stores nearby.",
                advertiser: "DeliveryMax Corp",
                callToAction: "ORDER NOW",
                appIconName: "bag.fill",
                mediaImageName: nil,
                starRating: 4.2,
                price: "FREE Delivery"
            ),
            
            NativeAdData(
                headline: "LearnLang - Master Any Language",
                body: "Learn languages naturally with interactive lessons, conversation practice, and personalized learning paths. Speak fluently in weeks!",
                advertiser: "EduTech Global",
                callToAction: "START LEARNING",
                appIconName: "globe",
                mediaImageName: nil,
                starRating: 4.9,
                price: "$14.99/month"
            ),
            
            NativeAdData(
                headline: "CryptoWallet - Secure Trading",
                body: "Trade cryptocurrencies safely with advanced security features. Real-time market data, portfolio tracking, and instant transactions.",
                advertiser: "BlockChain Finance",
                callToAction: "TRADE NOW",
                appIconName: "bitcoinsign.circle.fill",
                mediaImageName: nil,
                starRating: 4.3,
                price: "FREE"
            ),
            
            NativeAdData(
                headline: "WeatherPro - Accurate Forecasts",
                body: "Get precise weather forecasts with hourly updates, severe weather alerts, and interactive radar maps. Never get caught in the rain again!",
                advertiser: "Climate Tech Inc",
                callToAction: "CHECK WEATHER",
                appIconName: "cloud.sun.fill",
                mediaImageName: nil,
                starRating: 4.5,
                price: "$2.99"
            ),
            
            NativeAdData(
                headline: "TaskManager - Boost Productivity",
                body: "Organize your life with smart task management. Set reminders, collaborate with teams, and achieve your goals faster than ever.",
                advertiser: "Productivity Plus",
                callToAction: "GET ORGANIZED",
                appIconName: "checkmark.circle.fill",
                mediaImageName: nil,
                starRating: 4.1,
                price: "$6.99/month"
            ),
            
            NativeAdData(
                headline: "PetCare - Virtual Veterinarian",
                body: "24/7 pet health advice from certified veterinarians. Track vaccinations, get feeding tips, and ensure your pet stays healthy and happy.",
                advertiser: "Animal Care Solutions",
                callToAction: "CARE FOR PETS",
                appIconName: "pawprint.fill",
                mediaImageName: nil,
                starRating: 4.8,
                price: "$12.99/month"
            )
        ]
    }
}

// MARK: - Ad Loader Delegate
extension AdsViewController: CustomNativeAdLoaderDelegate {
    func adLoader(_ adLoader: AdLoader, didFailToReceiveAdWithError error: any Error) {
        print(error)
    }
    
    func customNativeAdFormatIDs(for adLoader: AdLoader) -> [String] {
        return [nativeCustomFormatId]
    }
    
    func adLoader(
        _ adLoader: AdLoader,
        didReceive customNativeAd: CustomNativeAd
    ) {
        print("Received custom native ad: \(customNativeAd)")
        
        let adChoicesKey = GADNativeAssetIdentifier.adChoicesViewAsset.rawValue
        
        let adChoicesImage = customNativeAd.image(forKey: adChoicesKey)?.image
        
        let image: UIImage? = customNativeAd.image(forKey: "MainImage")?.image
        let headline: String = customNativeAd.string(forKey: "Headline") ?? ""
        let caption: String = customNativeAd.string(forKey: "Caption") ?? ""
        
        // Convert to display format and insert at top of table
        DispatchQueue.main.async {
            self.nativeAdData.append(NativeAdData(
                headline: headline,
                body: caption,
                advertiser: "Sample Advertiser",
                callToAction: "LOADING",
                appIconName: "clock.fill",
                mediaImageName: image,
                starRating: 0.0,
                price: "FREE"
            ))
            
            let indexPath = IndexPath(row: self.nativeAdData.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
    
        customNativeAd.recordImpression()
    }
}


// MARK: - Table View Data Source
extension AdsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nativeAdData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NativeAdStyleTableViewCell.identifier, for: indexPath) as? NativeAdStyleTableViewCell else {
            return UITableViewCell()
        }
        
        let adData = nativeAdData[indexPath.row]
        cell.configure(with: adData)
        
        return cell
    }
}

// MARK: - Table View Delegate
extension AdsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedAd = nativeAdData[indexPath.row]
        let alert = UIAlertController(title: selectedAd.headline, message: selectedAd.body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default))
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            nativeAdData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
