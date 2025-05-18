//
//  HomeCell.swift
//  CryptoApp
//
//  Created by Mac on 18.05.25.
//

import UIKit

class HomeCell: UICollectionViewCell {
    private lazy var coinImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var coinName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var coinPrice: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var marketCapChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var marketCap: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        marketCapChangeLabel.textColor = Int(marketCapChangeLabel.text ?? "") ?? 0 > 0 ? .systemGreen: .systemRed
    }
    
    private func configureConstraints() {
        contentView.addSubViews(coinImage, coinName, coinPrice, marketCapChangeLabel, marketCap)
        NSLayoutConstraint.activate([
            coinImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            coinImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coinImage.widthAnchor.constraint(equalToConstant: 20),
            coinImage.heightAnchor.constraint(equalToConstant: 20),
            
            coinName.topAnchor.constraint(equalTo: coinImage.bottomAnchor),
            coinName.centerXAnchor.constraint(equalTo: coinImage.centerXAnchor),
            
            coinPrice.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            coinPrice.leadingAnchor.constraint(equalTo: coinName.trailingAnchor, constant: 24),
            
            marketCapChangeLabel.centerYAnchor.constraint(equalTo: coinPrice.centerYAnchor),
            marketCapChangeLabel.leadingAnchor.constraint(equalTo: coinPrice.trailingAnchor, constant: 16),
            
            marketCap.centerYAnchor.constraint(equalTo: marketCapChangeLabel.centerYAnchor),
            marketCap.leadingAnchor.constraint(equalTo: marketCapChangeLabel.trailingAnchor, constant: 8),
            marketCap.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func configureCell(with data: CoinsData) {
        coinImage.setImage(with: data.imageURL)
        coinName.text = data.nameData
        coinPrice.text = data.priceData
        marketCapChangeLabel.text = data.marketCapChange
        marketCap.text = data.marketCapData
    }
}

protocol CoinsData {
    var imageURL: String { get }
    var nameData: String { get }
    var priceData: String { get }
    var marketCapChange: String { get }
    var marketCapData: String { get }
}
