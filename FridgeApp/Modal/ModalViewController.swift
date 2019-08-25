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
    weak var delegate: ModalViewControllerDelegate?
    
    lazy var modalView: ModalView = {
        let modalView = ModalView()
        modalView.translatesAutoresizingMaskIntoConstraints = false
        return modalView
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
            modalView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            modalView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}
