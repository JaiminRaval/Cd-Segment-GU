//
//  CDManager.swift
//  Cd-Segment-GU
//
//  Created by Jaimin Raval on 03/12/24.
//

import UIKit
import CoreData

class CDManager {
    
    func readFromCd() -> [BookModel] {
        
        var bookArr: [BookModel] = []
        
        let delegate = UIApplication.shared.delegate as? AppDelegate

        let managedContext = delegate!.persistentContainer.viewContext
        
        let fetchRes = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        
        do {
            let dataArr = try managedContext.fetch(fetchRes)
            
            for d in dataArr as! [NSManagedObject] {
                let bookName = d.value(forKey: "name") as! String
                bookArr.append(BookModel(bookid: 0, name: bookName, author: "", ISBN: ""))
                print("name: \(bookName)")
            }
            
        } catch let err as NSError {
            print(err)
        }
        return bookArr
    }
    
    
    func AddToCd(bookToAdd: BookModel) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        guard let bookEnt = NSEntityDescription.entity(forEntityName: "Books", in: managedContext) else { return }
        
        let book = NSManagedObject(entity: bookEnt, insertInto: managedContext)
        book.setValue(bookToAdd.name, forKey: "name")
        
        do {
            try managedContext.save()
            print("Saved successfully!")
        } catch let err as NSError {
            print(err)
        }
    }
    
}
