//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 02.05.2022.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    private var imageBaseUrl: String {
        return AppConfig.shared.imageBaseUrl
    }
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func configure(with posterPath: String) {
        let urlString = "\(imageBaseUrl)\(posterPath)"
        guard let url = URL(string: urlString) else {
            print("Error creating url from string \(urlString)")
            return
        }
        
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
