//
//  FinanceCustomTableViewCell.swift
//  HardUIComponents
//
//  Created by Sabir Myrzaev on 09.02.2022.
//

import UIKit
import SnapKit

class FinanceCustomTableViewCell: UITableViewCell {
    static let identifier = "FinanceCustomTableViewCell"
    
    // MARK: - Views and Layout properties
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
        product.textColor = UIColor.gray
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
    public func configure(price: String, product: String) {
        priceLabel.text = price
        productLabel.text = product
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        priceLabel.text = nil
        productLabel.text = nil
    }
}

