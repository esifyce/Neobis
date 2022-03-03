//
//  LoginViewController.swift
//  FireChat
//
//  Created by Sabir Myrzaev on 27/2/22.
//

import UIKit
import Firebase
import JGProgressHUD

protocol AuthenticationControllerProtocol {
    func checkFormStatus()
}

protocol AuthenticationDelegate: AnyObject {
    func authenticationComplete()
}

class LoginViewController: UIViewController {
    
    weak var delegate: AuthenticationDelegate?
    
    //MARK: -  Properties
    
    private var viewModel = LoginViewModel()
    
    private let iconImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = UIColor(named: "primary")
        label.font = UIFont(name: "BluuNext-Bold", size: 48)
        return label
    }()
    
    private lazy var emailContainerView:InputContainerView = {
        return InputContainerView(image: UIImage(named: "mail"),
                                               textField: emailTextField)
       
    }()
    
    private lazy var passwordContainerView:InputContainerView = {
        return InputContainerView(image: UIImage(named: "passLock"),
                                               textField: passwordTextField)
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.roundCorners(corners: .allCorners, radius: 5)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21)
        button.backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.7176470588, blue: 0.4509803922, alpha: 1)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.setHeight(height: 56)
        button.isEnabled = false
        
        let iv = UIImageView()
        iv.image = UIImage(named: "arrow.right")?.withRenderingMode(.alwaysTemplate)
        button.addSubview(iv)
        iv.setDimensions(height: 14, width: 40)
        iv.anchor(top: button.topAnchor, right: button.rightAnchor, paddingTop: 21, paddingRight: 27)
        
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
         
        return button
    }()
    
    private let dontHaveAccButton:UIButton = {
        let button = UIButton(type: .system)
        
        
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?   ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    private let emailTextField:CustomTextField = {
        return CustomTextField(placeHolder: "Email")
    }()
    
    private let passwordTextField:CustomTextField = {
        let textField = CustomTextField(placeHolder: "Password")
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    //MARK: - Selectors
    
    @objc func handleShowSignUp() {
        let controller = RegistrationViewController()
        controller.delegate = delegate
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender:UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        showLoader(true, withText: "Logging in")
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.showLoader(false)
                self.showError(error.localizedDescription)
                return
            }
            self.showLoader(false) 
            self.delegate?.authenticationComplete()
        }
        
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.backgroundColor = UIColor(named: "background")
        
        view.addSubview(iconImage)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: 140, paddingLeft: 40)
        iconImage.setDimensions(height: 48, width: 48)
        iconImage.roundCorners(corners: .allCorners, radius: 10)
        
        view.addSubview(loginLabel)
        loginLabel.anchor(top: iconImage.bottomAnchor, left:  view.safeAreaLayoutGuide.leftAnchor, paddingTop: 40, paddingLeft: 40)
        loginButton.tintColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,loginButton])
        stack.axis = .vertical
        stack.spacing = 24
        
        
        view.addSubview(stack)
        stack.anchor(top: loginLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccButton)
        dontHaveAccButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}


extension LoginViewController:AuthenticationControllerProtocol {
    func checkFormStatus() {
        if viewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.setTitleColor(#colorLiteral(red: 0.2784313725, green: 0.2705882353, blue: 0.3176470588, alpha: 1), for: .normal)
            loginButton.tintColor =  .black
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.7176470588, blue: 0.4509803922, alpha: 1)
            loginButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            loginButton.tintColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
}
