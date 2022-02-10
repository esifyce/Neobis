//
//  FinanceCustomCollectionViewCell.swift
//  HardUIComponents
//
//  Created by Sabir Myrzaev on 10.02.2022.
//

import UIKit

class FinanceCustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "FinanceCustomCollectionViewCell"
    
    // MARK: - Views and Layout properties
    private lazy var financeImageView: UIImageView = {
        let financeImage = UIImageView()
        contentView.addSubview(financeImage)
        
        financeImage.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaInsets).inset(5)
            $0.centerX.equalTo(contentView)
            $0.height.width.equalTo(90)
        }
        return financeImage
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 26, weight: .bold)

        contentView.addSubview(title)

        title.snp.makeConstraints {
            $0.top.equalTo(financeImageView.snp.bottom).offset(3)
            $0.centerX.equalTo(financeImageView.snp.centerX)
        }
        return title
    }()

    private lazy var productLabel: UILabel = {
        let product = UILabel()
        product.textColor = UIColor.lightGray
        product.font = UIFont.systemFont(ofSize: 14, weight: .regular)

        contentView.addSubview(product)
        product.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(titleLabel.snp.centerX)
            
        }
        return product
    }()
    
    private lazy var priceLabel: UILabel = {
        let price = UILabel()
        price.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        contentView.addSubview(price)
        price.snp.makeConstraints {
            $0.top.equalTo(productLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(productLabel.snp.centerX)
        }
        return price
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Interection with data for cell
    public func configure(image: String, color: String, title: String, price: String, product: String) {
        financeImageView.image = UIImage(systemName: image)
        financeImageView.tintColor = UIColor(named: color)
        priceLabel.text = price
        productLabel.text = product
        titleLabel.text = title
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        financeImageView.image = nil
        financeImageView.tintColor = nil
        priceLabel.text = nil
        productLabel.text = nil
        titleLabel.text = nil
    }
}

