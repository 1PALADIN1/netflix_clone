//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 27.04.2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
}

//MARK: - TabBarItem

extension HomeViewController: TabBarItem {
    var icon: UIImage? {
        return UIImage(systemName: "house")
    }
    
    var titleString: String {
        return "Home"
    }
    
    var rootViewContoller: UIViewController {
        return self;
    }
}
