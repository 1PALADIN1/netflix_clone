//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 27.04.2022.
//

import UIKit

class UpcomingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
}

//MARK: - TabBarItem

extension UpcomingViewController: TabBarItem {
    var icon: UIImage? {
        return UIImage(systemName: "play.circle")
    }
    
    var titleString: String {
        return "Coming Soon"
    }
    
    var rootViewContoller: UIViewController {
        return self
    }
    
    
}
