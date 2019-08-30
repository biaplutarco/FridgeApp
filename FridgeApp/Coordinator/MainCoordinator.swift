//
//  AppCoordinator.swift
//  FridgeApp
//
//  Created by Bia on 24/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let viewController = ViewController()
    let modalViewController = ModalViewController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        configNavController()
    }
    
    private func configNavController() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.barTintColor = UIColor.AppColors.lightGray
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.AppColors.darkGray!]
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.AppColors.darkGray!]
        navigationController.navigationBar.shadowImage = UIImage()
    }
    
    func start() {
//        let vc = ViewController()
        viewController.coordinator = self
        viewController.title = "Sua Geladeira"
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToModalVC(snapShot: UIImage) {
//        let vc = ModalViewController()
        modalViewController.coordinator = self
        navigationController.present(modalViewController, animated: true) {
            self.modalViewController.setUpModelView(image: snapShot)
            self.modalViewController.configBackgroundImageView()
        }
    }
    
    func dissmissModalViewController() {
        modalViewController.dismiss(animated: true) {
            let indexPath = IndexPath(item: 0, section: 0)
            self.viewController.products = Product.all()
            self.viewController.collectionView.insertItems(at: [indexPath])
            self.viewController.collectionView.reloadItems(at: [indexPath])
        }
    }
}
