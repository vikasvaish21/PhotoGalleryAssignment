//
//  HomeViewController.swift
//  AssignmentProject
//
//  Created by Vikas Vaish on 13/02/24.

import Foundation
import UIKit
import Firebase
import Kingfisher


class HomeViewController : UIViewController{
    
    var imageArr = ["vecteezy1","vecteezy2","vecteezy3"]
    var selectedImage = [UIImage]()
    var username = String()
    var date = String()
    var descriptionData = String()
    let pickerController = MultipleImagePickerController()
    var postData = [PostDataModel]()
    var ref = DatabaseReference.init()
    
    private let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backGroundColor
        navigationItem.title = "Photo Gallery"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = .backGroundColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "post"), style: .plain, target: self, action: #selector(handleRightButtonAction))
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,.font: UIFont(name: "Avenir", size:20)!]
            navigationController?.navigationBar.standardAppearance = appearance

        }
        setUpCollectionView()
        pickerController.delegate = self
        self.ref = Database.database().reference()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllPostData()
    }
    
    func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingTop: 10,paddingLeft: 5,paddingBottom: 10,paddingRight: 5)
    }
    
    @objc func handleRightButtonAction() {
        print("post Successful")
        self.present(pickerController, animated: true, completion: nil)
        
    }
    
    func savePostData() {
        self.uploadImage(self.selectedImage) { data in
            self.saveImage(name: self.username, description: self.descriptionData, date: self.date, profileUrl: data)
        }
    }
    
    func getAllPostData(){
        self.ref.child("AllPosts").queryOrderedByKey().observe(.value){ (AllPost) in
            self.postData.removeAll()
            if let allPost = AllPost.children.allObjects as? [DataSnapshot]{
                for post in allPost{
                    if let mainDict = post.value as? [String:AnyObject]{
                        let userName =  mainDict["name"] as? String ?? ""
                        let description = mainDict["description"] as? String  ?? ""
                        let date = mainDict["date"] as? String  ?? ""
                        let postImagesUrls = mainDict["ProfileUrl"] as? [String] ?? [String]()
                        self.postData.append(PostDataModel(userName: userName, description: description, profileUrl: postImagesUrls, date: date))
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
}


extension HomeViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as! PostCollectionViewCell
        cell.postImage.kf.setImage(with: URL(string:postData[indexPath.row].profileUrl.first!))
        cell.userName.text = "User Id: \(postData[indexPath.row].userName)"
        cell.descriptionLabel.text = "Description: \(postData[indexPath.row].description)"
        cell.dateLabel.text = "Date:\(postData[indexPath.row].date) "
        if postData[indexPath.row].profileUrl.count == 1{
            cell.moreImage.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width/2 - 16, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PostImagesViewController()
        vc.postImages = postData[indexPath.row].profileUrl
        navigationController?.pushViewController(vc, animated: false)
    }

    
}
extension HomeViewController: MultipleImagePickerControllerDelegate {
    func multipleImage(picker: MultipleImagePickerController, didFinishPicking images: [UIImage],_ username: String,_ description: String,_ date: String) {
        self.selectedImage = images
        self.descriptionData = description
        self.username = username
        self.date = date
        savePostData()
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    func multipleImagePickerDidCancel(picker: MultipleImagePickerController) {
        print("picking cancelled")
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    
}

extension HomeViewController{
    func uploadImage(_ images:[UIImage],completion: @escaping (_ url: [String]) -> ()){
        var imageLinkUrl = [String]()
        for i in 0..<images.count{
            let storageRef = Storage.storage().reference().child("myImage" + "\(i+1)" + ".png")
            let imgData = images[i].pngData()
            let metaData = StorageMetadata()
            metaData.contentType = "image/png"
            storageRef.putData(imgData!, metadata: metaData) { (metaData,error) in
                if error == nil {
                    print("Success")
                    storageRef.downloadURL(completion: {(url,error) in
                        imageLinkUrl.append(url!.absoluteString)
                        if imageLinkUrl.count == self.selectedImage.count{
                            completion(imageLinkUrl)
                        }
                    })
                }else{
                    print("error in save image")
                    completion([String]())
                }
            }
        }
    }
    
    func saveImage(name: String,description: String,date: String,profileUrl:[String]) {
        let dict = ["name": name,"description": description,"date":date,"ProfileUrl": profileUrl] as [String : Any]
        self.ref.child("AllPosts").childByAutoId().setValue(dict)
    }
}
