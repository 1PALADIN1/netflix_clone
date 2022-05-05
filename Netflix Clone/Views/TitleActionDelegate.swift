//
//  TitleTapDelegate.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 04.05.2022.
//

protocol TitleActionDelegate {
    func didTapOnTitle(title: TitleData)
    func didTapDownloadTitle(title: TitleData)
}

//MARK: - Default TitleActionDelegate implementation

extension TitleActionDelegate {
    func didTapOnTitle(title: TitleData) {
    }
    
    func didTapDownloadTitle(title: TitleData) {
    }
}
