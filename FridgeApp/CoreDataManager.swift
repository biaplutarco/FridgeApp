//
//  CoreDataManager.swift
//  FridgeApp
//
//  Created by Bia on 24/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FridgeApp")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveProductWith(title: String, imageNamed: String, colorNamed: String, andDaysLeft: String) {
        let product = Product(context: persistentContainer.viewContext)
        product.title = title
        product.cutImage = imageNamed
        product.color = colorNamed
        product.days = andDaysLeft
        
        saveContext()
    }
    
    func getProducts() -> [Product] {
        do {
            let products = try persistentContainer.viewContext.fetch(NSFetchRequest<Product>(entityName: "Product"))
            return products
        } catch {
            print("error get debts")
            return []
        }
    }
}
