//
//  LoginController.swift
//  AssignmentProject
//
//  Created by Vikas Vaish on 13/02/24.
//

import UIKit
import Foundation
import Firebase

class LoginController: UIViewController {

    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo Gallery"
        label.textColor = UIColor(white: 1, alpha: 0.8)
        label.font = UIFont(name: "Avenir-Light", size: 36)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: UIImage(named: "ic_mail_outline_white_2x")!, textFiled: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    
    private lazy var PasswordContainerView: UIView = {
        let view =  UIView().inputContainerView(image: UIImage(named: "ic_lock_outline_white_2x")!, textFiled: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let emailTextField:UITextField = {
        return UITextField().textField(withPlaceHolder: "Email", isSecureTextField: false)
    }()
    
    private let passwordTextField:UITextField = {
        return UITextField().textField(withPlaceHolder: "Password", isSecureTextField: true)
    }()
    
    private let loginButton = {
        let loginButton = AuthButton(type: .system)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return loginButton
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let dontHaveAccountButton = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't Have an Account? ",attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign Up",attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        dontHaveAccountButton.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        dontHaveAccountButton.setAttributedTitle(attributedTitle, for: .normal)
        return dontHaveAccountButton
    }()
    
   
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else{ return }
        guard let password = passwordTextField.text else{ return }
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error{
                print("failed to log user in with error \(error.localizedDescription)")
                self.showAlert(title: "Login", message: "Your entered Email/password is wrong.")
                return
            }
            
            print("SuccessFul Login")
            let controller = HomeViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            self.showAlert(title: "Login", message: "Login Successfull")
        }
    }
    
   
    
    @objc func handleShowSignUp() {
        let controller = SignUpViewController()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    func configureUI() {
        configureNavigationBar()
        view.backgroundColor = .backGroundColor
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        let stack = UIStackView(arrangedSubviews: [emailContainerView,PasswordContainerView,loginButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,height: 32)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .backGroundColor
    }
    
    func showAlert(title: String,message: String) {
       let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       let okAction = UIAlertAction(title:"Ok", style: .default)
       alertController.addAction(okAction)
       present(alertController, animated: true)
       
    }

}

