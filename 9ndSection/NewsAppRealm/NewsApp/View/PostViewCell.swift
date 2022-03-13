//
//  PostViewCell.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 8/3/22.
//

import UIKit

class PostViewCell: UITableViewCell {
    static let identifier = "cell"

    // MARK: - Property View
    
    var mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .black
        iv.image = UIImage(systemName: "shippingbox")
        return iv
    }()
    
    private var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        return title
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let subtitles = UILabel()
        subtitles.textColor = UIColor.lightGray
        subtitles.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return subtitles
    }()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Interection with data for cell
    
    public func configure(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        configureTableViewCell()
    }
    
    private func configureTableViewCell() {
        mainImageView.setDimensions(height: 120, width: 80)
        
        let stack = UIStackView(arrangedSubviews: [mainImageView,titleLabel,subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 3
        
        contentView.addSubview(stack)
        stack.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, left: contentView.leftAnchor,
                     right: contentView.rightAnchor, paddingTop: 5,
                     paddingLeft: 16, paddingRight: 16)
    }

}
