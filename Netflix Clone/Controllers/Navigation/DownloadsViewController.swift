//
//  DownloadsViewController.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 27.04.2022.
//

import UIKit

class DownloadsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
}

//MARK: - TabBarItem

extension DownloadsViewController: TabBarItem {
    var icon: UIImage? {
        return UIImage(systemName: "arrow.down.to.line")
    }
    
    var titleString: String {
        return "Downloads"
    }
    
    var rootViewContoller: UIViewController {
        return self
    }
    
    
}
