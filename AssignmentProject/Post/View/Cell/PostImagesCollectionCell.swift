//
//  PostImagesCollectionCell.swift
//  AssignmentProject
//
//  Created by Vikas Vaish on 15/02/24.
//

import UIKit
import Kingfisher

class PostImagesCollectionCell: UICollectionViewCell {
    static var identifier = "PostImagesCollectionCell"
    
    var imageData : String?  {
        didSet {
            if let image = imageData{
                postImage.kf.setImage(with: URL(string: image))
            }
        }
    }
    
    let postImage :UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor.black.cgColor
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(postImage)
        postImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor,paddingTop: 10,paddingLeft: 10,paddingBottom: 10,paddingRight: 10)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
}
