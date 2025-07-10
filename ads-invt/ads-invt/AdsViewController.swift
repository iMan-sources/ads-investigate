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
    
    private var nativeAds: [NativeAd?] = []
    private var adLoader: AdLoader!
    private let adUnitID = "/21775744923/example/native"
    private let numberOfCells = 6
    
    var adsToLoad = [AdLoader]()
    var loadStateForAds = [AdLoader: Bool]()
    var adsLoaded = [AdLoader: NativeAd]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadNativeAds()
        preloadNextAd()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        nativeAds = Array(repeating: nil, count: numberOfCells)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NativeAdStyleTableViewCell.self, forCellReuseIdentifier: NativeAdStyleTableViewCell.identifier)
    }
    
    private func loadNativeAds() {
        // Initialize array with nil values
        
        var index = 0
        while index < 6 {
            let adLoader = AdLoader(
                adUnitID: adUnitID,
                rootViewController: self,
                adTypes: [.native],
                options: nil
            )
            
            adsToLoad.append(adLoader)
            adLoader.delegate = self
            loadStateForAds[adLoader] = false
            index += 1
        }
        
        
    }
    
    func preloadNextAd() {
        if !adsToLoad.isEmpty {
            let ad = adsToLoad.removeFirst()
            let adRequest = Request()
            ad.load(adRequest)
        }
    }
}

// MARK: - GADAdLoader Delegate
extension AdsViewController: AdLoaderDelegate {
    func adLoader(_ adLoader: AdLoader, didFailToReceiveAdWithError error: Error) {
        print("Ad failed to load: \(error.localizedDescription)")
        preloadNextAd()
    }
}

// MARK: - GADNativeAdLoaderDelegate
extension AdsViewController: NativeAdLoaderDelegate {
    func adLoader(_ adLoader: AdLoader, didReceive nativeAd: NativeAd) {
        print("Native ad loaded successfully")
        loadStateForAds[adLoader] = true
        adsLoaded[adLoader] = nativeAd
        preloadNextAd()
        print(adsLoaded)
        // Find the first empty slot to place the ad
        if let emptyIndex = nativeAds.firstIndex(where: { $0 == nil }) {
            nativeAds[emptyIndex] = nativeAd
            
            // Update the specific cell
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: emptyIndex, section: 0)
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
}

// MARK: - Table View Data Source
extension AdsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NativeAdStyleTableViewCell.identifier, for: indexPath) as? NativeAdStyleTableViewCell else {
            return UITableViewCell()
        }
        
        // Reset cell first
        cell.reset()
        
        // Configure cell based on whether ad is available
        if let nativeAd = nativeAds[indexPath.row] {
            // Ad is available - show AdView
            cell.configure(with: nativeAd)
        } else {
            // Ad not available - show default image
            let defaultImage = UIImage(named: "default") ?? UIImage(systemName: "photo")
            cell.configure(with: defaultImage)
        }
        
        return cell
    }
}

// MARK: - Table View Delegate
extension AdsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return different heights based on content
        if nativeAds[indexPath.row] != nil {
            return 320 // Height for native ad
        } else {
            return 200 // Height for default image
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let nativeAd = nativeAds[indexPath.row] {
            let alert = UIAlertController(title: "Native Ad", message: "Headline: \(nativeAd.headline ?? "No headline")", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Loading", message: "Ad is still loading...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default))
            present(alert, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            nativeAds.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
