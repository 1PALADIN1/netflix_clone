//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 28.04.2022.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
