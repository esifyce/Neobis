//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Sabir Myrzaev on 21.02.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "cell"
    
    // for add in cell by title
    private var titleLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        return text
    }()
    
    // for add in cell by subtitle
    private var subtitileLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
        return text
    }()
    
    // pass data from viewModel
    var viewModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            
            titleLabel.text = viewModel.title
            subtitileLabel.text = viewModel.description
            
            imageView?.image = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView?.addGestureRecognizer(tapGesture)
            imageView?.isUserInteractionEnabled = true
        }
    }
    
    // init for assign subviews and constraints
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // add views in cell
    private func setSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitileLabel)
    }
    
    // assign constraints subviews in cell
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).inset(3)
            $0.left.equalToSuperview().inset(60)
        }
        subtitileLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.left.equalToSuperview().inset(60)
        }
    }

    // Implementation checkark task
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let imgView = tapGestureRecognizer.view as! UIImageView
        
        if imgView.image != UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal) {
            imgView.image = UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        } else {
            imgView.image = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        }
    }

}
