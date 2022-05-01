//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 27.04.2022.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
}

//MARK: - TabBarItem

extension SearchViewController: TabBarItem {
    var icon: UIImage? {
        return UIImage(systemName: K.SystemIcons.TabBar.search)
    }
    
    var titleString: String {
        return "Top Searches"
    }
    
    var rootViewContoller: UIViewController {
        return self
    }
}
