//
//  RegistrationViewController.swift
//  FireChat
//
//  Created by Sabir Myrzaev on 27/2/22.
//

import UIKit
import Firebase

class RegistrationViewController:UIViewController {
    
    weak var delegate: AuthenticationDelegate?
    
    //MARK: -  Properties
    
    private var viewModel = RegistrationViewModel()
    private var profileImage:UIImage?
    
    private let plusPhotoButton:UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(#imageLiteral(resourceName: "Button-Upload").withRenderingMode(.alwaysOriginal), for:  .normal)
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.anchor(top: button.topAnchor, left: button.leftAnchor,bottom: button.bottomAnchor, right: button.rightAnchor)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 3.0
        
        button.roundCorners(corners: .allCorners, radius: 200 / 2)
        
        return button
    }()
    
    private lazy var emailContainerView:InputContainerView = {
        return InputContainerView(image: UIImage(named: "mail"),
                                  textField: emailTextField)
    }()
    
    private lazy var fullnameContainerView:InputContainerView = {
        return InputContainerView(image: UIImage(named: "person"),
                                  textField: fullnameTextField)
    }()
    
    private lazy var usernameContainerView:InputContainerView = {
        return InputContainerView(image: UIImage(named: "person"),
                                  textField: usernameTextField)
    }()
    
    private lazy var passwordContainerView:InputContainerView = {
        return InputContainerView(image: UIImage(named: "passLock"),
                                  textField: passwordTextField)
    }()
    
    private let emailTextField:CustomTextField = CustomTextField(placeHolder: "Email")
    private let fullnameTextField:CustomTextField = CustomTextField(placeHolder: "Full Name")
    private let usernameTextField:CustomTextField = CustomTextField(placeHolder: "Username")
    
    private let passwordTextField:CustomTextField = {
        let textField = CustomTextField(placeHolder: "Password")
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private let signUpButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.roundCorners(corners: .allCorners, radius: 5)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)

        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21)
        button.backgroundColor = UIColor(named: "primary")
        
        button.setHeight(height: 56)
        button.isEnabled = false
        
        let iv = UIImageView()
        iv.image = UIImage(named: "arrow.right")?.withRenderingMode(.alwaysTemplate)
        button.addSubview(iv)
        iv.setDimensions(height: 14, width: 40)
        iv.anchor(top: button.topAnchor, right: button.rightAnchor, paddingTop: 21, paddingRight: 27)
        
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        
        return button
    }()
    
    private let alreadyHaveAccButton:UIButton = {
        let button = UIButton(type: .system)
        
        
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?   ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "Log in", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    //MARK: - Selectors
    
    @objc func handleRegistration() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = fullnameTextField.text else {return}
        guard let username = usernameTextField.text?.lowercased() else {return}
        guard let profileImage = profileImage else {return}
        
        let credentials = RegistrationCredentials(email: email, password: password,
                                                  fullname: fullname, username: username,
                                                  profileImage: profileImage)
        
        showLoader(true, withText: "Signing You Up")
        
        AuthService.shared.createUser(credentials: credentials) { (error) in
            if let error = error {
                self.showLoader(false)
                self.showError(error.localizedDescription)
                return
            }
            self.showLoader(false)
            self.delegate?.authenticationComplete()
        }
      
    }
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(sender:UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender ==  fullnameTextField {
            viewModel.fullname = sender.text
        } else {
            viewModel.username = sender.text
        }
        
        checkFormStatus()
    }
    
    @objc func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 88
        }
    }
    
    @objc func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = UIColor(named: "background")
        signUpButton.tintColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        plusPhotoButton.setDimensions(height: 200, width: 200)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,fullnameContainerView, usernameContainerView, passwordContainerView, signUpButton])
        stack.axis = .vertical
        stack.spacing = 24
                
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccButton)
        alreadyHaveAccButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingLeft: 32, paddingRight: 32)
        
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//MARK: -  UIImagePickerControllerDelegate

extension RegistrationViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        self.profileImage = image
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
//        plusPhotoButton.layer.borderColor = UIColor(named: "primary")?.cgColor
//        plusPhotoButton.layer.borderWidth = 3.0
        
 //       plusPhotoButton.roundCorners(corners: .allCorners, radius: 200 / 2)
        
        dismiss(animated: true, completion: nil)
    }
}

extension RegistrationViewController:AuthenticationControllerProtocol {
    func checkFormStatus() {
        if viewModel.formIsValid {
            signUpButton.isEnabled = true
            signUpButton.setTitleColor(#colorLiteral(red: 0.2784313725, green: 0.2705882353, blue: 0.3176470588, alpha: 1), for: .normal)
            signUpButton.setTitle("Finish", for: .normal)
            signUpButton.tintColor =  .black
        } else {
            signUpButton.isEnabled = false
            signUpButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            signUpButton.tintColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            signUpButton.setTitle("Sign Up", for: .normal)
        }
    }
}
