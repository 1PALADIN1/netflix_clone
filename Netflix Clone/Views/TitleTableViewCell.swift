//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 03.05.2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    private var imageBaseUrl: String {
        return AppConfig.shared.imageBaseUrl
    }
    
    private let titlePosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titlePlayButton: UIButton = {
        let button = UIButton()
        let buttonIcon = UIImage(systemName: K.SystemIcons.playButtonComingSoon, withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(buttonIcon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterUIImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(titlePlayButton)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
        let titlePosterUIImageViewConstraints = [
            titlePosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlePosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlePosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titlePlayButtonConstraints = [
            titlePlayButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titlePlayButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titlePlayButton.widthAnchor.constraint(equalToConstant: 40)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titlePlayButton.leadingAnchor, constant: -20),
        ]
        
        NSLayoutConstraint.activate(titlePosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titlePlayButtonConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
    func configure(with title: TitleData) {
        titleLabel.text = title.titleName
        
        guard let pathUrl = title.poster_path else { return }
        let urlString = "\(imageBaseUrl)\(pathUrl)"
        guard let url = URL(string: urlString) else {
            print("Error creating url from string \(urlString)")
            return
        }
        
        titlePosterUIImageView.sd_setImage(with: url, completed: nil)
    }
}
