//
//  TabBarItem.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 27.04.2022.
//

import UIKit

protocol TabBarItem {
    var icon: UIImage? { get }
    var titleString: String { get }
    var rootViewContoller: UIViewController { get }
}
