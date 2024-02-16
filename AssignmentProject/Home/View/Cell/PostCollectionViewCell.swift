//
//  PostCollectionViewCell.swift
//  AssignmentProject
//
//  Created by Vikas Vaish on 13/02/24.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCell"
    
    let userName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Medium", size: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont(name: "Avenir-Medium", size: 12)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postImage :UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    let moreImage :UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "gallery")
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(postImage)
        contentView.addSubview(userName)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(moreImage)
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.black.cgColor
        postImage.anchor(top: contentView.topAnchor,left: contentView.leftAnchor,right: contentView.rightAnchor,paddingTop: 10,paddingLeft: 10,paddingRight: 10)
        userName.anchor(top: postImage.bottomAnchor, left: postImage.leftAnchor, right: postImage.rightAnchor, height: 20)
        descriptionLabel.anchor(top: userName.bottomAnchor, left: userName.leftAnchor, right: userName.rightAnchor)
        dateLabel.anchor(top: descriptionLabel.bottomAnchor, left: descriptionLabel.leftAnchor,bottom: contentView.bottomAnchor, right: descriptionLabel.rightAnchor)
        moreImage.anchor(top: postImage.topAnchor, right: postImage.rightAnchor, paddingTop: 10, paddingRight: 10, width: 25, height: 25)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
