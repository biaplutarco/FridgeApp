//
//  AddProductView.swift
//  FridgeApp
//
//  Created by Bia on 24/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    lazy var centerYConstraint: NSLayoutConstraint = {
        let centerYConstraint = modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        return centerYConstraint
    }()
    
    lazy var modalView: ModalView = {
        let modalView = ModalView()
        modalView.translatesAutoresizingMaskIntoConstraints = false
        return modalView
    }()
    
    lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "exit"), for: .normal)
        button.addTarget(self, action: #selector(exitButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        let effectView = UIVisualEffectView()
        effectView.frame = view.frame
        effectView.effect = UIBlurEffect(style: .dark)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(effectView)
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configModalView()
        configButton()
        addObservers()
        hideKeyboardWhenTappedAround()
    }
    
    @objc func exitButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) {
            self.backgroundImageView.removeFromSuperview()
        }
        
    }
    
    func setUpModelView(image: UIImage) {
        backgroundImageView.image = image
        configBackgroundImageView()
    }
    
    func configBackgroundImageView() {
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    private func configModalView() {
        view.addSubview(modalView)
        
        NSLayoutConstraint.activate([
            centerYConstraint,
            modalView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            modalView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    private func configButton() {
        view.addSubview(exitButton)
        
        let leftConstant = ((view.frame.width * 0.85) * 0.12)/4
        let bottomConstant = ((view.frame.width * 0.85) * 0.12)/2
        NSLayoutConstraint.activate([
            exitButton.widthAnchor.constraint(equalTo: modalView.widthAnchor, multiplier: 0.12),
            exitButton.heightAnchor.constraint(equalTo: exitButton.widthAnchor),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftConstant),
            exitButton.bottomAnchor.constraint(equalTo: modalView.topAnchor, constant: bottomConstant)
            ])
    }
}

extension ModalViewController: UITextFieldDelegate {
    //    Method called when the user click on Return button on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //    Add observers to notificated when keyboard will show + hide
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //    Show keyboard + push to up texfield
    @objc func keyboardWillShow(notification: NSNotification) {
        var userInfo = notification.userInfo!
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        
        modalView.removeConstraint(centerYConstraint)
        centerYConstraint.isActive = false
        centerYConstraint = modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(keyboardFrame.height/2))
        centerYConstraint.isActive = true
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    //    Hide keydoard + push to down textfield
    @objc func keyboardWillHide(notification: NSNotification) {
//        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
    }
    //    Hide keyboard when touch up outside
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    //    Dismiss keyboard methods
    @objc func dismissKeyboard() {
        view.endEditing(true)
        modalView.removeConstraint(centerYConstraint)
        centerYConstraint.isActive = false
        centerYConstraint = modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        centerYConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
