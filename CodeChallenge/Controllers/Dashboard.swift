//
//  Dashboard.swift
//  CodeChallenge
//
//  Created by Jorge Menendez on 9/6/20.
//  Copyright © 2020 CodeChallenge. All rights reserved.
//

import UIKit

class Dashboard: UIViewController {
    
    let profileImage = UIImageView(cornerRadius: 80)
    let infoLabel = UILabel(text: "Tap on user profile image", font: .systemFont(ofSize: 18, weight: .regular), numberOfLines: 0)
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Dashboard"
        
        
        self.view.addSubview(profileImage)
        profileImage.image = UIImage(named: "elon")
        profileImage.centerInSuperview(size: .init(width: 160, height: 160))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileDidSelect))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tap)
        
        self.view.addSubview(infoLabel)
        infoLabel.textAlignment = .center
        infoLabel.anchor(top: profileImage.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 20))
    }
    
    @objc func profileDidSelect() {
        let profileController = UserProfile()
        self.navigationController?.pushViewController(profileController, animated: true)
    }

}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}
