//
//  TranslateHistoryCell.swift
//  TranslatorApp
//
//  Created by Sabir Myrzaev on 18/3/22.
//

import UIKit
import AVFoundation
import SpriteKit

class TranslateHistoryCell: UITableViewCell {
    static var identifier = "cell"
    
    // MARK: - Properties
    
    var isCheckLang: Bool? = false
    
    // MARK: - Views and Subviews properties
    
    let historyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.dropShadow()
        
        return view
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.isEnabled = false
        return textField
    }()
    
    let outputTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = #colorLiteral(red: 0.2235294118, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
        textField.isEnabled = false
        return textField
    }()
    
    let lineView: UIView = {
        let line = UIView()
        line.layer.borderWidth = 1.0
        line.layer.borderColor = UIColor.systemGray4.cgColor
        return line
    }()
    
    /// voices button
    let speechWordsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "speaker"), for: .normal)
        button.addTarget(self, action: #selector(repeatTraslateWordInVoices), for: .touchUpInside)
        
        return button
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
    
    public func configure(input: String, output: String, languages: Bool) {
        inputTextField.text = input
        outputTextField.text = output
        isCheckLang = languages
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        inputTextField.text = nil
        outputTextField.text = nil
        isCheckLang = nil
    }
    
    // MARK: - Selctors
    @objc func repeatTraslateWordInVoices() {
        guard let string = outputTextField.text, let isCheckLang = isCheckLang else { return }
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: isCheckLang ? "ru-RU" : "en-US")
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        contentView.addSubviews(historyView, lineView, speechWordsButton,
                                inputTextField, outputTextField)
        setConstraints()
    }
    
    func setConstraints() {
        historyView.snp.makeConstraints { make in
            make.height.equalTo(116)
            make.left.right.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(22)
        }
        
        lineView.snp.makeConstraints { make in
            make.left.equalTo(historyView.snp.left).inset(29)
            make.right.equalTo(historyView.snp.right).inset(29)
            make.height.equalTo(1)
            make.center.equalTo(historyView.snp.center)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.left.equalTo(historyView.snp.left).inset(16)
            make.right.equalTo(historyView.snp.right).inset(16)
            make.centerY.equalTo(historyView.snp.centerY).offset(-25)
        }
        
        outputTextField.snp.makeConstraints { make in
            make.left.equalTo(historyView.snp.left).inset(16)
            make.right.equalTo(historyView.snp.right).inset(16)
            make.centerY.equalTo(historyView.snp.centerY).offset(25)
        }
        
        speechWordsButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.bottom.equalTo(historyView.snp.bottom).inset(6)
            make.right.equalTo(historyView.snp.right).inset(9)
        }
    }
}
