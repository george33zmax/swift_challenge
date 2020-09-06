//
//  Password.swift
//  CodeChallenge
//
//  Created by Jorge Menendez on 9/6/20.
//  Copyright © 2020 CodeChallenge. All rights reserved.
//

import UIKit

class Password: UICollectionViewCell {
    
    var didSave: ((String, String) -> ())?
    
    // elements
    let passwordLabel = UILabel(text: "PASSWORD", font: .systemFont(ofSize: 15, weight: .semibold))
    let passwordInput = { () -> UITextField in
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "New Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        tf.font = .systemFont(ofSize: 18, weight: .regular)
        tf.keyboardType = .default
        tf.isSecureTextEntry = true
        tf.borderStyle = .none
        return tf
    }()
    let checkPasswordInput = { () -> UITextField in
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Re-enter Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        tf.font = .systemFont(ofSize: 18, weight: .regular)
        tf.keyboardType = .default
        tf.isSecureTextEntry = true
        tf.borderStyle = .none
        return tf
    }()
    let saveButton = UIButton()
    let line = UIView()
    
    // containers
    let passwordLabelContainer = UIView()
    let allPasswordsContainer = UIView()
    let passwordContainer = UIView()
    let passwordCheckContainer = UIView()
    let buttonContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        layoutPasswordLabel()
        layoutPasswords()
        layoutButton()
    }
    
    fileprivate func layoutPasswordLabel() {
        passwordLabelContainer.addSubview(passwordLabel)
        passwordLabel.textColor = .subtitles
        passwordLabel.anchor(top: passwordLabelContainer.topAnchor, leading: passwordLabelContainer.leadingAnchor, bottom: passwordLabelContainer.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: 160, height: .zero))
        
        self.addSubview(passwordLabelContainer)
        passwordLabelContainer.backgroundColor = .grayTitles
        passwordLabelContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: .zero, height: 30))
    }
    
    fileprivate func layoutPasswords() {
        
        passwordContainer.addSubview(passwordInput)
        passwordInput.anchor(top: passwordContainer.topAnchor, leading: passwordContainer.leadingAnchor, bottom: passwordContainer.bottomAnchor, trailing: passwordContainer.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 1, right: 0), size: .zero)
        passwordContainer.addSubview(line)
        line.backgroundColor = .subtitles
        line.anchor(top: passwordInput.bottomAnchor, leading: passwordInput.leadingAnchor, bottom: nil, trailing: passwordInput.trailingAnchor, padding: .zero, size: .init(width: .zero, height: 0.5))
        
        passwordCheckContainer.addSubview(checkPasswordInput)
        checkPasswordInput.anchor(top: passwordCheckContainer.topAnchor, leading: passwordCheckContainer.leadingAnchor, bottom: passwordCheckContainer.bottomAnchor, trailing: passwordCheckContainer.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 1, right: 0), size: .zero)
        
        let passwordsStack = UIStackView(arrangedSubviews: [passwordContainer, passwordCheckContainer])
        
        allPasswordsContainer.addSubview(passwordsStack)
        passwordsStack.axis = .vertical
        passwordsStack.fillSuperview()
        passwordsStack.distribution = .fillEqually
        
        self.addSubview(allPasswordsContainer)
        allPasswordsContainer.anchor(top: passwordLabelContainer.bottomAnchor, leading: passwordLabelContainer.leadingAnchor, bottom: nil, trailing: passwordLabelContainer.trailingAnchor, padding: .zero, size: .init(width: .zero, height: 106))
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
        buttonContainer.anchor(top: allPasswordsContainer.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .zero)
    }
    
    @objc func didTapSave() {
        if let didSave = self.didSave {
            let password = self.passwordInput.text ?? ""
            let passwordCheck = self.checkPasswordInput.text ?? ""
            didSave(password, passwordCheck)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
