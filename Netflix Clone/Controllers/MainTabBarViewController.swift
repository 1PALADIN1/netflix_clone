//
//  ViewController.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 27.04.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private let tabControllers: [TabBarItem] = [
        HomeViewController(),
        UpcomingViewController(),
        SearchViewController(),
        DownloadsViewController()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        var navControllers: [UINavigationController] = []
        for controller in tabControllers {
            let navCotroller = UINavigationController(rootViewController: controller.rootViewContoller)
            navCotroller.tabBarItem.image = controller.icon
            navCotroller.title = controller.titleString
            
            navControllers.append(navCotroller)
        }
        
        tabBar.tintColor = .label
        setViewControllers(navControllers, animated: true)
    }
}
