//
//  K.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 28.04.2022.
//

struct K {
    static let tableCellId = "TableCell"
    static let collectionViewCellId = "CollectionViewCell"
}

//MARK: - Stubs

extension K {
    struct Stubs {
        static let mainPosterImageName = "heroImage"
    }
}

//MARK: - Icons

extension K {
    struct Icons {
        static let netflixLogo = "netflixLogo"
    }
    
    struct SystemIcons {
        struct TabBar {
            static let home = "house"
            static let comingSoon = "play.circle"
            static let search = "magnifyingglass"
            static let downloads = "arrow.down.to.line"
        }
        
        struct NavBar {
            static let userProfile = "person"
            static let play = "play.rectangle"
        }
    }
}
