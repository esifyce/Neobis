//
//  CryptCustomCollectionViewCell.swift
//  HardUIComponents
//
//  Created by Sabir Myrzaev on 10.02.2022.
//

import UIKit

class CryptCustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CryptCustomCollectionViewCell"
    
    // MARK: - Views and Layout properties
    private lazy var cryptImageView: UIImageView = {
        let cryptImage = UIImageView()
        contentView.addSubview(cryptImage)
        
        cryptImage.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaInsets).inset(5)
            $0.centerX.equalTo(contentView)
            $0.height.width.equalTo(90)
        }
        return cryptImage
    }()
    
    private lazy var titleCryptLabel: UILabel = {
        let titleCrypt = UILabel()
        titleCrypt.font = UIFont.systemFont(ofSize: 26, weight: .bold)

        contentView.addSubview(titleCrypt)

        titleCrypt.snp.makeConstraints {
            $0.top.equalTo(cryptImageView.snp.bottom).offset(3)
            $0.centerX.equalTo(cryptImageView.snp.centerX)
            
        }

        return titleCrypt
    }()

    private lazy var subtitleCryptLabel: UILabel = {
        let subtitleCrypt = UILabel()
        subtitleCrypt.textColor = UIColor.lightGray
        subtitleCrypt.font = UIFont.systemFont(ofSize: 14, weight: .regular)

        contentView.addSubview(subtitleCrypt)

        subtitleCrypt.snp.makeConstraints {
            $0.top.equalTo(titleCryptLabel.snp.bottom).offset(2)
            $0.centerX.equalTo(titleCryptLabel.snp.centerX)
        }
        return subtitleCrypt
    }()

    private lazy var priceLabel: UILabel = {
        let price = UILabel()
        price.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        contentView.addSubview(price)
        price.snp.makeConstraints {
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-6)
            $0.right.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        return price
    }()

    private lazy var productLabel: UILabel = {
        let product = UILabel()
        product.textColor = UIColor.lightGray
        product.font = UIFont.systemFont(ofSize: 14, weight: .regular)

        contentView.addSubview(product)
        product.snp.makeConstraints {
            $0.bottom.equalTo(priceLabel.snp.top)
            $0.right.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        return product
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Interection with data for cell
    public func configure(image: String, title: String, subtitle: String, price: String, product: String) {
        priceLabel.text = price
        productLabel.text = product
        cryptImageView.image = UIImage(named: image)
        titleCryptLabel.text = title
        subtitleCryptLabel.text = subtitle
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        priceLabel.text = nil
        productLabel.text = nil
        cryptImageView.image = nil
        titleCryptLabel.text = nil
        subtitleCryptLabel.text = nil
    }
}
