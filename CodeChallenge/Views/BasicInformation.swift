//
//  BasicInformation.swift
//  CodeChallenge
//
//  Created by Jorge Menendez on 9/6/20.
//  Copyright © 2020 CodeChallenge. All rights reserved.
//

import UIKit

class BasicInformation: UICollectionViewCell {
    
    var didSave: ((String, String, String) -> ())?
    
    // elements
    let basicInfoLabel = UILabel(text: "BASIC INFORMATION", font: .systemFont(ofSize: 15, weight: .semibold))
    let usernameLabel = UILabel(text: "Username", font: .systemFont(ofSize: 18, weight: .regular))
    let firstNameLabel = UILabel(text: "First Name", font: .systemFont(ofSize: 18, weight: .regular))
    let lastNameLabel = UILabel(text: "Last Name", font: .systemFont(ofSize: 18, weight: .regular))
    
    let usernameInput = { () -> UITextField in
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.subtitles])
        tf.font = .systemFont(ofSize: 18, weight: .regular)
        tf.keyboardType = .default
        tf.borderStyle = .none
        return tf
    }()
    let firstNameInput = { () -> UITextField in
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.subtitles])
        tf.font = .systemFont(ofSize: 18, weight: .regular)
        tf.keyboardType = .default
        tf.borderStyle = .none
        return tf
    }()
    let lastNameInput = { () -> UITextField in
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.subtitles])
        tf.font = .systemFont(ofSize: 18, weight: .regular)
        tf.keyboardType = .default
        tf.borderStyle = .none
        return tf
    }()
    
    let saveButton = UIButton()
    
    // containers
    let userInfoContainer = UIView()
    let basicInfoContainer = UIView()
    let usernameContainer = UIView()
    let firstNameContainer = UIView()
    let lastNameContainer = UIView()
    let buttonContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        layoutBasicInfoLabel()
        layoutUserInfo()
        layoutButton()
    }
    
    fileprivate func layoutBasicInfoLabel() {
        basicInfoContainer.addSubview(basicInfoLabel)
        basicInfoLabel.textColor = .subtitles
        basicInfoLabel.anchor(top: basicInfoContainer.topAnchor, leading: basicInfoContainer.leadingAnchor, bottom: basicInfoContainer.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: 160, height: .zero))
        
        self.addSubview(basicInfoContainer)
        basicInfoContainer.backgroundColor = .grayTitles
        basicInfoContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: .zero, height: 30))
    }
    
    fileprivate func layoutUserInfo() {
        
        let usernameStack = generateInfoStack(label: usernameLabel, input: usernameInput, borderHidden: false)
        
        let firstNameStack = generateInfoStack(label: firstNameLabel, input: firstNameInput, borderHidden: false)
        
        let lastNameStack = generateInfoStack(label: lastNameLabel, input: lastNameInput, borderHidden: true)
        
        
        let stack = UIStackView(arrangedSubviews: [usernameStack, firstNameStack, lastNameStack])
        
        userInfoContainer.addSubview(stack)
        stack.fillSuperview()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        self.addSubview(userInfoContainer)
        userInfoContainer.anchor(top: basicInfoContainer.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: .zero, height: 160))
        
    }
    
    fileprivate func layoutButton() {
        buttonContainer.backgroundColor = .background
        
        buttonContainer.addSubview(saveButton)
        saveButton.centerInSuperview(size: .init(width: 200, height: 50))
        saveButton.setTitle("SAVE CHANGES", for: .normal)
        saveButton.backgroundColor = .clear
        saveButton.layer.borderWidth = 1.6
        saveButton.layer.borderColor = UIColor.white.cgColor
        saveButton.layer.cornerRadius = 5
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        
        self.addSubview(buttonContainer)
        buttonContainer.anchor(top: userInfoContainer.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .zero)
    }
    
    @objc func didTapSave() {
        if let didSave = self.didSave {
            let username = self.usernameInput.text ?? ""
            let firstName = self.firstNameInput.text ?? ""
            let lastName = self.lastNameInput.text ?? ""
            didSave(username, firstName, lastName)
        }
    }
    
    func generateInfoStack(label: UILabel, input: UITextField, borderHidden: Bool) -> UIView{
        
        let wrapper = UIView()
        let leftContainer = UIView()
        let rightContainer = UIView()
        let line = UIView()
        
        leftContainer.addSubview(label)
        label.textAlignment = .left
        label.anchor(top: leftContainer.topAnchor, leading: leftContainer.leadingAnchor, bottom: leftContainer.bottomAnchor, trailing: leftContainer.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .zero)
        
        
        rightContainer.addSubview(input)
        input.textAlignment = .left
        input.anchor(top: rightContainer.topAnchor, leading: rightContainer.leadingAnchor, bottom: rightContainer.bottomAnchor, trailing: rightContainer.trailingAnchor, padding: .zero, size: .zero)
        
        let stack = UIStackView(arrangedSubviews: [leftContainer, rightContainer])
        stack.distribution = .fillEqually
        
        wrapper.addSubview(stack)
        stack.anchor(top: wrapper.topAnchor, leading: wrapper.leadingAnchor, bottom: wrapper.bottomAnchor, trailing: wrapper.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 1, right: 0), size: .zero)
        
        wrapper.addSubview(line)
        line.backgroundColor = .subtitles
        line.isHidden = borderHidden
        line.anchor(top: stack.bottomAnchor, leading: wrapper.leadingAnchor, bottom: nil, trailing: wrapper.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: .zero, height: 0.5))
        
        
        return wrapper
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
