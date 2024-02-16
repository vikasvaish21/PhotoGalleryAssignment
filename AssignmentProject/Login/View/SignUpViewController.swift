//
//  SignUpViewController.swift
//  AssignmentProject
//
//  Created by Vikas Vaish on 13/02/24.
//

import Foundation
import UIKit
import Firebase

class SignUpViewController: UIViewController{
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo Gallery"
        label.textColor = UIColor(white: 1, alpha: 0.8)
        label.font = UIFont(name: "Avenir-Light", size: 36)
        return label
    }()
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad(){
        super.viewDidLoad()
        configureUI()
    }
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: UIImage(named: "ic_mail_outline_white_2x")!, textFiled: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(image: UIImage(named: "ic_lock_outline_white_2x")!, textFiled: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    
    private lazy var fullNameContainerView: UIView = {
        let view =  UIView().inputContainerView(image: UIImage(named: "ic_person_outline_white_2x")!, textFiled: fullNameTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
   
    private let emailTextField:UITextField = {
        return UITextField().textField(withPlaceHolder: "Email", isSecureTextField: false)
    }()
    
    private let fullNameTextField:UITextField = {
        return UITextField().textField(withPlaceHolder: "Full Name", isSecureTextField: false)
    }()
    
    private let passwordTextField:UITextField = {
        return UITextField().textField(withPlaceHolder: "Password", isSecureTextField: true)
    }()
    
   
    
    private let signUpButton: AuthButton = {
        let signUpButton = AuthButton(type: .system)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return signUpButton
    }()
    
    
    
    private let alreadyHaveAccountButton: UIButton = {
        let alreadyHaveAccountButton = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already Have an Account? ",attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Log In",attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        alreadyHaveAccountButton.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        alreadyHaveAccountButton.setAttributedTitle(attributedTitle, for: .normal)
        return alreadyHaveAccountButton
    }()
    
    // MARK: - Selector
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else{
            return
        }
        guard let password = passwordTextField.text else{ return }
        guard let fullname = fullNameTextField.text else{ return }
        print(email)
        print(password)
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                if email.isEmpty{
                    self.showAlert(title: "Sign Up", message: "Email is Empty")
                }else if fullname.isEmpty{
                    self.showAlert(title: "Sign Up", message: "fullname is Empty")
                }else if password.isEmpty{
                    self.showAlert(title: "Sign Up", message: "Password is Empty")
                }
                print("User Fail because error exist \(error)")
                return
            }
            guard let uid = result?.user.uid else {return}
            let value  = ["email": email,"fullname": fullname] as [String: Any]
            Database.database().reference().child("users").child(uid).updateChildValues(value) { error, ref in
                    self.navigationController?.popViewController(animated: true)
                self.showAlert(title: "Sign Up", message: "Sign Up successfull")
            }
        }
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureUI() {
        view.backgroundColor = .backGroundColor
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        let stack = UIStackView(arrangedSubviews: [emailContainerView,fullNameContainerView,passwordContainerView,signUpButton])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 24
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,height: 32)
        
        
    }
    
    func showAlert(title: String,message: String) {
       let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       let okAction = UIAlertAction(title:"Ok", style: .default)
       alertController.addAction(okAction)
       present(alertController, animated: true)
       
    }
}
