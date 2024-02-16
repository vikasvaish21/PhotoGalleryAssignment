//
//  PostImagesViewController.swift
//  AssignmentProject
//
//  Created by Vikas Vaish on 15/02/24.
//

import Foundation
import UIKit

class PostImagesViewController:UIViewController{
    var postImages = [String]()
    
    private let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PostImagesCollectionCell.self, forCellWithReuseIdentifier: PostImagesCollectionCell.identifier)
        return cv
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .backGroundColor
        setUpCollectionView()
    }
    func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingTop: 10,paddingLeft: 5,paddingBottom: 10,paddingRight: 5)
    }
}

extension PostImagesViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostImagesCollectionCell.identifier, for: indexPath) as! PostImagesCollectionCell
        cell.imageData = postImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width/2 - 16, height: 180)
    }
    
}
