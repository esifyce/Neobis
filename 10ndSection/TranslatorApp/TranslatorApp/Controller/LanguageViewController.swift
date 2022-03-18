//
//  ViewController.swift
//  TranslatorApp
//
//  Created by Sabir Myrzaev on 18/3/22.
//

import UIKit
import SnapKit
import AVFoundation


class LanguageViewController: UIViewController {
    
    // MARK: - Properties
    var alertCollection: GTAlertCollection!
    var checkLanguages = false
    
    // MARK: - Views and Subviews
    /// view
    let inputLanguageView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.dropShadow()
        
        return view
    }()
    
    let outputLanguageView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.dropShadow()
        
        return view
    }()
    ///image
    let inputImageLanguage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ruIMG")
        
        return image
    }()
    
    let outputImageLanguage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ukIMG")
        
        return image
    }()
    /// textField
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите текст"
        textField.textAlignment = .center
        
        return textField
    }()
    
    let outputTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Translated text"
        textField.textAlignment = .center
        textField.textColor = #colorLiteral(red: 0.2235294118, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
        
        return textField
    }()
    
    let lineView: UIView = {
        let line = UIView()
        line.layer.borderWidth = 1.0
        line.layer.borderColor = UIColor.systemGray4.cgColor
        
        return line
    }()
    /// switch language button
    let switchLanguageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "switchLang"), for: .normal)
        button.addTarget(self, action: #selector(switchWords), for: .touchUpInside)
        
        return button
    }()
    /// voices button
    let speechWordsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "speaker"), for: .normal)
        button.addTarget(self, action: #selector(repeatTraslateWordInVoices), for: .touchUpInside)
        
        return button
    }()
    /// send history translate
    let historyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Посмотреть историю", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = .white
        button.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
        button.addTarget(self, action: #selector(goToHistoryTranslate), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        inputTextField.delegate = self
        alertCollection = GTAlertCollection(withHostViewController: self)
        
    }
    
    // MARK: - Selectors
    
    @objc func switchWords() {
        animationWhenDidChangeWords()
        
        checkLanguages.toggle()
        changeBetweenLanguages()
        checkLanguageImage()
        translate()
    }
    
    @objc func goToHistoryTranslate() {
        navigationController?.pushViewController(TranslateHistoryController(), animated: true)
    }
    
    @objc func repeatTraslateWordInVoices() {
        guard let string = outputTextField.text else { return }
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: checkLanguages ? "ru-RU" : "en-US")
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        
        title = "iTranslator"
        
        // Calls this function when the tap is recognized.
        hideKeyboardWhenTappedAround()
        
        view.addSubviews(inputLanguageView, outputLanguageView,
                         inputImageLanguage, outputImageLanguage,
                         inputTextField, outputTextField,
                         switchLanguageButton, speechWordsButton,
                         historyButton, lineView)
        
        viewConstraints()
    }
    
    private func viewConstraints() {
        /// input
        inputImageLanguage.snp.makeConstraints { make in
            make.height.width.equalTo(54)
            make.left.equalTo(8)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(53)
        }
        
        inputLanguageView.snp.makeConstraints { make in
            make.height.equalTo(71)
            make.centerY.equalTo(inputImageLanguage.snp.centerY)
            make.left.equalTo(inputImageLanguage.snp.right).inset(-7)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.left.equalTo(inputLanguageView.snp.left).inset(16)
            make.right.equalTo(inputLanguageView.snp.right).inset(16)
            make.center.equalTo(inputLanguageView.snp.center)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalTo(inputTextField.snp.bottom).offset(3)
            make.left.equalTo(inputLanguageView.snp.left).inset(16)
            make.right.equalTo(inputLanguageView.snp.right).inset(16)
        }
        
        /// switch
        switchLanguageButton.snp.makeConstraints { make in
            make.width.height.equalTo(52)
            make.top.equalTo(inputLanguageView.snp.bottom).inset(-20)
            make.centerX.equalTo(inputLanguageView.snp.centerX)
        }
        
        /// output
        outputImageLanguage.snp.makeConstraints { make in
            make.height.width.equalTo(54)
            make.top.equalTo(switchLanguageButton.snp.bottom).inset(-35)
            make.left.equalTo(8)
        }
        
        outputLanguageView.snp.makeConstraints { make in
            make.height.equalTo(71)
            make.centerY.equalTo(outputImageLanguage.snp.centerY)
            make.left.equalTo(outputImageLanguage.snp.right).inset(-7)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        outputTextField.snp.makeConstraints { make in
            make.left.equalTo(outputLanguageView.snp.left).inset(16)
            make.right.equalTo(outputLanguageView.snp.right).inset(16)
            make.center.equalTo(outputLanguageView.snp.center)
        }
        
        speechWordsButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.bottom.equalTo(outputLanguageView.snp.bottom).inset(6)
            make.right.equalTo(outputLanguageView.snp.right).inset(9)
        }
        
        /// history translate
        historyButton.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(29)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(55)
        }
    }
    
    private func changeBetweenLanguages() {
        guard let temp = inputTextField.text else { return }
        inputTextField.text = outputTextField.text
        outputTextField.text = temp
        inputTextField.placeholder = "Введите текст"
        outputTextField.placeholder = "Translated text"
    }
    
    private func checkLanguageImage() {
        if checkLanguages {
            inputImageLanguage.image = UIImage(named: "ukIMG")
            outputImageLanguage.image = UIImage(named: "ruIMG")
        } else {
            outputImageLanguage.image = UIImage(named: "ukIMG")
            inputImageLanguage.image = UIImage(named: "ruIMG")
        }
    }
    
    private func animationWhenDidChangeWords() {
        DispatchQueue.main.async { [weak self] in
            self?.switchLanguageButton.transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)
            self?.inputImageLanguage.transform = CGAffineTransform.init(translationX: -150, y: 0)
            self?.outputImageLanguage.transform = CGAffineTransform.init(translationX: -150, y: 0)
            
            self?.inputImageLanguage.alpha = 0
            self?.outputImageLanguage.alpha = 0
            self?.switchLanguageButton.alpha = 0
            
            UIView.animate(withDuration: 1.8) {
                self?.switchLanguageButton.alpha = 1
                self?.inputImageLanguage.alpha = 1
                self?.outputImageLanguage.alpha = 1
                self?.inputImageLanguage.transform = .identity
                self?.outputImageLanguage.transform = .identity
                self?.switchLanguageButton.transform = .identity
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
            let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
            let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
            
            self?.inputTextField.alpha = 0
            self?.outputTextField.alpha = 0
            
            self?.inputTextField.transform = moveScaleTransform
            self?.outputTextField.transform = moveScaleTransform
            
            UIView.animate(withDuration: 1.8, delay: 0.4, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.6, options: [], animations: {
                self?.inputTextField.alpha = 1.0
                self?.outputTextField.alpha = 1.0
                self?.outputTextField.transform = .identity
                self?.inputTextField.transform = .identity
            }, completion: nil)
        }
    }
    
    private func translate() {
        if inputTextField.text != "", let text = inputTextField.text {
            print(text)
            TranslationManager.shared.textToTranslate = text
            TranslationManager.shared.detectLanguage(forText: text) {[weak self] language in
                switch language {
                case "en":
                    DispatchQueue.main.async {
                        self?.checkLanguages = true
                        self?.checkLanguageImage()
                    }
                    TranslationManager.shared.targetLanguageCode = "ru"
                    self?.initiateTranslation()
                    
                case "ru":
                    DispatchQueue.main.async {
                        self?.checkLanguages = false
                        self?.checkLanguageImage()
                    }
                    TranslationManager.shared.targetLanguageCode = "en"
                    self?.initiateTranslation()
                    
                default:
                    print("DEBUG: we don't supported \(String(describing: language))")
                }
            }
        }
    }
    
    private func initiateTranslation() {
        // Present a "Please wait..." alert.
        alertCollection.presentActivityAlert(withTitle: "Translation", message: "Your text is being translated...") { (presented) in
            if presented {
                
                TranslationManager.shared.translate(completion: { (translation) in
                    
                    // Dismiss the buttonless alert.
                    self.alertCollection.dismissAlert(completion: nil)
                    
                    if let translation = translation {
                        DispatchQueue.main.async { [weak self] in
                            self?.outputTextField.text = translation
                            guard let input = self?.inputTextField.text,
                                  let check = self?.checkLanguages else { return }
                            Translator.translatorList.append(Translator(inputWord:  input,
                                                                        outputWord: translation,
                                                                        checkLanguage: check))
                        }
                    } else {
                        self.alertCollection.presentSingleButtonAlert(withTitle: "Translation", message: "Oops! It seems that something went wrong and translation cannot be done.", buttonTitle: "OK", actionHandler: {
                        })
                    }
                })
            }
        }
    }
}

extension LanguageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        translate()
        return true
    }
}
