//
//  UserProfile.swift
//  CodeChallenge
//
//  Created by Jorge Menendez on 9/6/20.
//  Copyright © 2020 CodeChallenge. All rights reserved.
//

import UIKit

class UserProfile: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let marginTop = CGFloat(40)
        let marginBottom = CGFloat(40)
        collectionView.contentInset.top = marginTop
        collectionView.contentInset.bottom = marginBottom
    }
    
    let basicId = "basicId"
    let passwordId = "passwordId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.backgroundColor = .background
        self.navigationItem.title = "User Profile"
        
        collectionView.register(BasicInformation.self, forCellWithReuseIdentifier: basicId)
        collectionView.register(Password.self, forCellWithReuseIdentifier: passwordId)
        
        hideKeyboardWhenTappedAround()
    }
    
    // Items Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = indexPath.item
        
        var itemSize = 0
        switch item {
        case 0:
            itemSize = 300
        case 1:
            itemSize = 250
        default:
            break
        }
        return .init(customeWidth: view.frame.width, customeHeight: CGFloat(itemSize))
    }
    
    // Number of items
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    // Cell for item at
    let sections = ["basicInfo", "password"]
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = indexPath.item
        let section = sections[item]
        
        switch section {
            
        case "basicInfo":
            let basicInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.basicId, for: indexPath) as! BasicInformation
            
            basicInfoCell.didSave = { username, firstName, lastName in
                print("username: ", username)
                print("firstName: ", firstName)
                print("lastName: ", lastName)
            }
            
            return basicInfoCell
            
        case "password":
            let passwordCell = collectionView.dequeueReusableCell(withReuseIdentifier: passwordId, for: indexPath) as! Password
            
            
            return passwordCell
            
        default: break
        }
        return UICollectionViewCell()
    }
    
}

extension CGSize {
    
    /// Creates a size with unnamed arguments.
    init(customeWidth width: CGFloat, customeHeight height: CGFloat) {
        self.init()
        self.width = width
        self.height = height
    }
    
    /// Returns a copy with the width value changed.
    func with(width: CGFloat) -> CGSize {
        return CGSize(width: width, height: height)
    }
    /// Returns a copy with the height value changed.
    func with(height: CGFloat) -> CGSize {
        return CGSize(width: width, height: height)
    }
}

extension UIColor {
    @nonobjc class var background: UIColor {
        return UIColor(red: 0.56, green: 0.12, blue: 0.12, alpha: 1.00)
    }
    @nonobjc class var subtitles: UIColor {
        return UIColor(white: 129.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var grayTitles: UIColor {
        return UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.00)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
