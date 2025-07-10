//
//  AdView.swift
//  ads-invt
//
//  Created by Le Viet Anh on 10/7/25.
//

import UIKit
import GoogleMobileAds

class AdView: NativeAdView {
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let adIndicatorLabel: UILabel = {
        let label = UILabel()
        label.text = "Ad"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .systemOrange
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var adMediaView: MediaView = {
        let mediaView = MediaView()
        mediaView.backgroundColor = .systemGray5
        mediaView.layer.cornerRadius = 8
        mediaView.clipsToBounds = true
        mediaView.translatesAutoresizingMaskIntoConstraints = false
        return mediaView
    }()
    
    private let headlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let advertiserLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .tertiaryLabel
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let callToActionButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let ratingView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGADNativeAdView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupGADNativeAdView()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        backgroundColor = .clear
        
        addSubview(containerView)
        containerView.addSubview(adIndicatorLabel)
        containerView.addSubview(adMediaView)
        containerView.addSubview(appIconImageView)
        containerView.addSubview(headlineLabel)
        containerView.addSubview(bodyLabel)
        containerView.addSubview(advertiserLabel)
        containerView.addSubview(callToActionButton)
        containerView.addSubview(ratingView)
        containerView.addSubview(priceLabel)
        
        setupStarRating()
        setupConstraints()
    }
    
    private func setupGADNativeAdView() {
        // Associate the UI elements with GADNativeAdView
        self.mediaView = adMediaView
        self.headlineView = headlineLabel
        self.bodyView = bodyLabel
        self.advertiserView = advertiserLabel
        self.callToActionView = callToActionButton
        self.iconView = appIconImageView
        self.priceView = priceLabel
        self.starRatingView = starRatingView
    }
    
    private func setupStarRating() {
        for _ in 0..<5 {
            let starImageView = UIImageView()
            starImageView.image = UIImage(systemName: "star.fill")
            starImageView.tintColor = .systemOrange
            starImageView.contentMode = .scaleAspectFit
            ratingView.addArrangedSubview(starImageView)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Container view
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            // Ad indicator
            adIndicatorLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            adIndicatorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            adIndicatorLabel.widthAnchor.constraint(equalToConstant: 24),
            adIndicatorLabel.heightAnchor.constraint(equalToConstant: 18),
            
            // Media view
            adMediaView.topAnchor.constraint(equalTo: adIndicatorLabel.bottomAnchor, constant: 8),
            adMediaView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            adMediaView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            adMediaView.heightAnchor.constraint(equalToConstant: 180),
            
            // App icon
            appIconImageView.topAnchor.constraint(equalTo: adMediaView.bottomAnchor, constant: 12),
            appIconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            appIconImageView.widthAnchor.constraint(equalToConstant: 44),
            appIconImageView.heightAnchor.constraint(equalToConstant: 44),
            
            // Headline
            headlineLabel.topAnchor.constraint(equalTo: adMediaView.bottomAnchor, constant: 12),
            headlineLabel.leadingAnchor.constraint(equalTo: appIconImageView.trailingAnchor, constant: 12),
            headlineLabel.trailingAnchor.constraint(equalTo: callToActionButton.leadingAnchor, constant: -12),
            
            // Star rating and price
            ratingView.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 4),
            ratingView.leadingAnchor.constraint(equalTo: headlineLabel.leadingAnchor),
            ratingView.widthAnchor.constraint(equalToConstant: 80),
            ratingView.heightAnchor.constraint(equalToConstant: 16),
            
            priceLabel.topAnchor.constraint(equalTo: ratingView.topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: 8),
            
            // Call to action button
            callToActionButton.centerYAnchor.constraint(equalTo: appIconImageView.centerYAnchor),
            callToActionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            callToActionButton.widthAnchor.constraint(equalToConstant: 80),
            callToActionButton.heightAnchor.constraint(equalToConstant: 32),
            
            // Body text
            bodyLabel.topAnchor.constraint(equalTo: appIconImageView.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            // Advertiser
            advertiserLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 4),
            advertiserLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            advertiserLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            advertiserLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    // MARK: - Configuration
    func configure(with nativeAd: NativeAd) {
        self.nativeAd = nativeAd
        
        // Configure text content
        headlineLabel.text = nativeAd.headline
        bodyLabel.text = nativeAd.body
        advertiserLabel.text = nativeAd.advertiser
        callToActionButton.setTitle(nativeAd.callToAction, for: .normal)
        priceLabel.text = nativeAd.price
        
        // Configure media content
        adMediaView.mediaContent = nativeAd.mediaContent
        
        // Configure icon
        if let icon = nativeAd.icon {
            appIconImageView.image = icon.image
        }
        
        // Configure star rating
        if let starRating = nativeAd.starRating {
            configureStarRating(rating: starRating.doubleValue)
        }
    }
    
    private func configureStarRating(rating: Double) {
        let fullStars = Int(rating)
        let hasHalfStar = rating - Double(fullStars) >= 0.5
        
        for (index, starView) in ratingView.arrangedSubviews.enumerated() {
            guard let starImageView = starView as? UIImageView else { continue }
            
            if index < fullStars {
                starImageView.image = UIImage(systemName: "star.fill")
                starImageView.tintColor = .systemOrange
            } else if index == fullStars && hasHalfStar {
                starImageView.image = UIImage(systemName: "star.leadinghalf.filled")
                starImageView.tintColor = .systemOrange
            } else {
                starImageView.image = UIImage(systemName: "star")
                starImageView.tintColor = .systemGray4
            }
        }
    }
}
