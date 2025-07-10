//
//  NativeAdStyleTableViewCell.swift
//  ads-invt
//
//  Created by Le Viet Anh on 9/7/25.
//

import UIKit
import GoogleMobileAds

// MARK: - Native Ad Style Table View Cell
class NativeAdStyleTableViewCell: UITableViewCell {
    static let identifier = "NativeAdStyleTableViewCell"
    
    private let defaultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray4
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "default")
        return imageView
    }()
    
    private let adView: AdView = {
        let view = AdView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(defaultImageView)
        contentView.addSubview(adView)
        
        NSLayoutConstraint.activate([
            // Default image view constraints
            defaultImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            defaultImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            defaultImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            defaultImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            // Ad view constraints
            adView.topAnchor.constraint(equalTo: contentView.topAnchor),
            adView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            adView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            adView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Configuration Methods
    func configure(with image: UIImage?) {
        showDefaultImage()
        defaultImageView.image = image ?? UIImage(systemName: "photo")
    }
    
    func configure(with nativeAd: NativeAd) {
        showAdView()
        adView.configure(with: nativeAd)
    }
    
    // MARK: - Private Methods
    private func showDefaultImage() {
        defaultImageView.isHidden = false
        adView.isHidden = true
    }
    
    private func showAdView() {
        defaultImageView.isHidden = true
        adView.isHidden = false
    }
    
    // MARK: - Public Methods
    func reset() {
        showDefaultImage()
        adView.nativeAd = nil
    }
}
