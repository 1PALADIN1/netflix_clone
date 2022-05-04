//
//  K.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 28.04.2022.
//

//MARK: - Common

struct K {
    static let tableCellId = "TableCell"
    static let titleCollectionViewCellId = "TitleCollectionViewCell"
    static let titleTableCellId = "TitleTableCell"
}

//MARK: - Icons

extension K {
    struct Icons {
        static let netflixLogo = "netflixLogo"
    }
    
    struct SystemIcons {
        static let playButtonComingSoon = "play.circle"
        
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
