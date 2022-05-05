//
//  DataManager.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 05.05.2022.
//

import UIKit
import CoreData

protocol DataManagerDelegate {
    func didFetchAllTitles(titles: [TitleEntity])
    
    func didFailWithError(error: Error)
}

struct DataManager {
    
    var delegate: DataManagerDelegate?
    
    private let context: NSManagedObjectContext
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate is not created!")
        }
        
        context = appDelegate.persistantContainer.viewContext
    }
    
    func hasEntity(with id: Int) -> Bool {
        let request = TitleEntity.fetchRequest()
        let idPredicate = NSPredicate(
            format: "id = %d", Int64(id)
        )
        
        request.predicate = idPredicate
        
        do {
            let titles = try context.fetch(request)
            return titles.count > 0
        } catch {
            delegate?.didFailWithError(error: error)
            return false
        }
    }
    
    func downloadTitle(title: TitleData) {
        if (hasEntity(with: title.id)) {
            return
        }
        
        let entity = TitleEntity(context: context)
        title.copyTo(entity: entity)
        
        do {
            try context.save()
            NotificationCenter.default.post(name: NSNotification.Name(K.Notifications.titleDownloaded), object: nil)
        } catch {
            delegate?.didFailWithError(error: error)
        }
    }
    
    func fetchAllTitles() {
        let request = TitleEntity.fetchRequest()
        do {
            let titles = try context.fetch(request)
            delegate?.didFetchAllTitles(titles: titles)
        } catch {
            delegate?.didFailWithError(error: error)
        }
    }
    
    func deleteTitleWith(entity: TitleEntity) {
        context.delete(entity)
        
        do {
            try context.save()
        } catch {
            delegate?.didFailWithError(error: error)
        }
    }
}

//MARK: - Default DataManagerDelegate implementation

extension DataManagerDelegate {
    func didFetchAllTitles(titles: [TitleEntity]) {
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
