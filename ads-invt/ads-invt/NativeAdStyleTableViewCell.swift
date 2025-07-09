//
//  NativeAdStyleTableViewCell.swift
//  ads-invt
//
//  Created by Le Viet Anh on 9/7/25.
//

import UIKit

// MARK: - Native Ad Style Table View Cell
class NativeAdStyleTableViewCell: UITableViewCell {
    static let identifier = "NativeAdStyleTableViewCell"
    
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
    
    private let mediaView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mediaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray4
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    private let starRatingView: UIStackView = {
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
        label.text = "FREE"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        contentView.addSubview(containerView)
        containerView.addSubview(adIndicatorLabel)
        containerView.addSubview(mediaView)
        mediaView.addSubview(mediaImageView)
        containerView.addSubview(appIconImageView)
        containerView.addSubview(headlineLabel)
        containerView.addSubview(bodyLabel)
        containerView.addSubview(advertiserLabel)
        containerView.addSubview(callToActionButton)
        containerView.addSubview(starRatingView)
        containerView.addSubview(priceLabel)
        
        setupStarRating()
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            adIndicatorLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            adIndicatorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            adIndicatorLabel.widthAnchor.constraint(equalToConstant: 24),
            adIndicatorLabel.heightAnchor.constraint(equalToConstant: 18),
            
            mediaView.topAnchor.constraint(equalTo: adIndicatorLabel.bottomAnchor, constant: 8),
            mediaView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            mediaView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            mediaView.heightAnchor.constraint(equalToConstant: 180),
            
            mediaImageView.topAnchor.constraint(equalTo: mediaView.topAnchor),
            mediaImageView.leadingAnchor.constraint(equalTo: mediaView.leadingAnchor),
            mediaImageView.trailingAnchor.constraint(equalTo: mediaView.trailingAnchor),
            mediaImageView.bottomAnchor.constraint(equalTo: mediaView.bottomAnchor),
            
            appIconImageView.topAnchor.constraint(equalTo: mediaView.bottomAnchor, constant: 12),
            appIconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            appIconImageView.widthAnchor.constraint(equalToConstant: 44),
            appIconImageView.heightAnchor.constraint(equalToConstant: 44),
            
            headlineLabel.topAnchor.constraint(equalTo: mediaView.bottomAnchor, constant: 12),
            headlineLabel.leadingAnchor.constraint(equalTo: appIconImageView.trailingAnchor, constant: 12),
            headlineLabel.trailingAnchor.constraint(equalTo: callToActionButton.leadingAnchor, constant: -12),
            
            starRatingView.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 4),
            starRatingView.leadingAnchor.constraint(equalTo: headlineLabel.leadingAnchor),
            starRatingView.widthAnchor.constraint(equalToConstant: 80),
            starRatingView.heightAnchor.constraint(equalToConstant: 16),
            
            priceLabel.topAnchor.constraint(equalTo: starRatingView.topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: starRatingView.trailingAnchor, constant: 8),
            
            callToActionButton.centerYAnchor.constraint(equalTo: appIconImageView.centerYAnchor),
            callToActionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            callToActionButton.widthAnchor.constraint(equalToConstant: 80),
            callToActionButton.heightAnchor.constraint(equalToConstant: 32),
            
            bodyLabel.topAnchor.constraint(equalTo: appIconImageView.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            advertiserLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 4),
            advertiserLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            advertiserLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            advertiserLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    private func setupStarRating() {
        for _ in 0..<5 {
            let starImageView = UIImageView()
            starImageView.image = UIImage(systemName: "star.fill")
            starImageView.tintColor = .systemOrange
            starImageView.contentMode = .scaleAspectFit
            starRatingView.addArrangedSubview(starImageView)
        }
    }
    
    func configure(with adData: NativeAdData) {
        headlineLabel.text = adData.headline
        bodyLabel.text = adData.body
        advertiserLabel.text = adData.advertiser
        callToActionButton.setTitle(adData.callToAction, for: .normal)
        
        // Set app icon
        if let appIcon = UIImage(systemName: adData.appIconName) {
            appIconImageView.image = appIcon
            appIconImageView.tintColor = .systemBlue
        }
        
        // Set media image
        mediaImageView.image = adData.mediaImageName
        mediaImageView.tintColor = .systemGray3
        
        // Configure star rating
        configureStarRating(rating: adData.starRating)
        
        // Set price
        priceLabel.text = adData.price
        
        callToActionButton.addTarget(self, action: #selector(callToActionTapped), for: .touchUpInside)
    }
    
    private func configureStarRating(rating: Double) {
        let fullStars = Int(rating)
        let hasHalfStar = rating - Double(fullStars) >= 0.5
        
        for (index, starView) in starRatingView.arrangedSubviews.enumerated() {
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
    
    @objc private func callToActionTapped() {
        print("Call to Action tapped for: \(headlineLabel.text ?? "")")
    }
}

// MARK: - Native Ad Data Model
struct NativeAdData {
    let headline: String
    let body: String
    let advertiser: String
    let callToAction: String
    let appIconName: String
    let mediaImageName: UIImage?
    let starRating: Double
    let price: String
}
