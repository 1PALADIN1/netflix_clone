//
//  HomeSection.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 02.05.2022.
//

struct HomeSection {
    let name: String
    let sectionType: HomeSectionType
    
    private let fetchMethod: () -> Void
    
    init(name: String, sectionType: HomeSectionType, fetchMethod: @escaping () -> Void) {
        self.name = name
        self.sectionType = sectionType
        self.fetchMethod = fetchMethod
    }
    
    func fetchData() {
        fetchMethod()
    }
}
