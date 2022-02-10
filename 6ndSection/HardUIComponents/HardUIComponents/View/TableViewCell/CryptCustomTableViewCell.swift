//
//  CryptTableViewCell.swift
//  HardUIComponents
//
//  Created by Sabir Myrzaev on 09.02.2022.
//

import UIKit

class CryptCustomTableViewCell: UITableViewCell {
    static let identifier = "CryptCustomTableViewCell"
    
    // MARK: - Views and Layout properties
    private lazy var cryptImageView: UIImageView = {
        let cryptImage = UIImageView()
        contentView.addSubview(cryptImage)
        
        cryptImage.snp.makeConstraints {
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.left.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            $0.width.height.equalTo(70)
        }
        return cryptImage
    }()
    
    private lazy var titleCryptLabel: UILabel = {
        let titleCrypt = UILabel()
        titleCrypt.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        
        contentView.addSubview(titleCrypt)
        
        titleCrypt.snp.makeConstraints {
            $0.centerY.equalTo(cryptImageView.snp.centerY).offset(-10)
            $0.left.equalTo(cryptImageView.snp.right).inset(-8)
        }
        
        return titleCrypt
    }()
    
    private lazy var subtitleCryptLabel: UILabel = {
        let subtitleCrypt = UILabel()
        subtitleCrypt.textColor = UIColor.lightGray
        subtitleCrypt.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        contentView.addSubview(subtitleCrypt)
    
        subtitleCrypt.snp.makeConstraints {
            $0.top.equalTo(titleCryptLabel.snp.bottom)
            $0.left.equalTo(cryptImageView.snp.right).inset(-8)
        }
        
        return subtitleCrypt
    }()
    
    private lazy var priceLabel: UILabel = {
        let price = UILabel()
        price.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        contentView.addSubview(price)
        price.snp.makeConstraints {
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide).offset(-10)
            $0.right.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        return price
    }()
    
    private lazy var productLabel: UILabel = {
        let product = UILabel()
        product.textColor = UIColor.lightGray
        product.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        contentView.addSubview(product)
        product.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom)
            $0.right.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        return product
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Interection with data for cell
    public func configure(price: String, product: String, image: String, title: String, subtitle: String) {
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
