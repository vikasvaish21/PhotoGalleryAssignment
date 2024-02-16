//
//  Extension.swift
//  AssignmentProject
//
//  Created by Vikas Vaish on 13/02/24.
//

import UIKit

extension  UIColor{
    static func rgb(red: CGFloat,green:CGFloat,Blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: Blue/255, alpha: 1.0)
    }
    static let backGroundColor = UIColor.rgb(red: 28, green: 61, Blue: 86)
    static let mainBlueTint = UIColor.rgb(red: 17, green: 154, Blue: 237)
}

extension UIView{
    
    func inputContainerView(image: UIImage,textFiled: UITextField? = nil,segmentedControl: UISegmentedControl? = nil) -> UIView{
        let view = UIView()
        let imageView = UIImageView()
        imageView.image = image
        imageView.alpha = 0.87
        view.addSubview(imageView)
        if let textFiled = textFiled {
            imageView.centerY(inView: view)
            imageView.anchor(left: view.leftAnchor,paddingLeft: 8,width: 24,height: 24)
            view.addSubview(textFiled)
            textFiled.centerY(inView: view)
            textFiled.anchor(left:imageView.rightAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingLeft: 8,paddingBottom: 8)
        }
        if let segmentedControl = segmentedControl {
            imageView.anchor(top: view.topAnchor, left: view.leftAnchor,paddingTop: -8,paddingLeft: 8, width: 24, height: 24)
            view.addSubview(segmentedControl)
            segmentedControl.anchor( left: view.leftAnchor,  right: view.rightAnchor, paddingLeft: 8, paddingRight: 8)
            segmentedControl.centerY(inView: view,constant: 8)
        }
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = .lightGray
        view.addSubview(seperatorView)
        seperatorView.anchor(left:view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingLeft: 8,paddingBottom: 8,height: 0.75)
        return view
    }
    
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,left: NSLayoutXAxisAnchor? = nil,bottom: NSLayoutYAxisAnchor? = nil,right: NSLayoutXAxisAnchor? = nil,paddingTop: CGFloat = 0,paddingLeft:CGFloat = 0,paddingBottom:CGFloat = 0,paddingRight:CGFloat = 0,width: CGFloat? = nil,height : CGFloat? = nil){
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top,constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left,constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom,constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right,constant: -paddingRight).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant : width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant : height).isActive = true
        }
    }
    
    func centerX(inView view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    func centerY(inView view: UIView,leftAnchor: NSLayoutXAxisAnchor? = nil,paddingLeft: CGFloat = 0,constant: CGFloat = 0) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        if let left = leftAnchor{
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
}


extension UITextField{
    func textField(withPlaceHolder placeholder: String,isSecureTextField: Bool) -> UITextField{
        let textfield = UITextField()
        textfield.borderStyle = .none
        textfield.font = UIFont.systemFont(ofSize: 16)
        textfield.textColor = .white
        textfield.isSecureTextEntry = isSecureTextField
        textfield.keyboardAppearance = .dark
        textfield.attributedPlaceholder = NSAttributedString(string: placeholder,attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        return textfield
    }
}

