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
                let UId = d.value(forKey: "id") as! UUID
                let bId = d.value(forKey: "bookid") as! Int32
                let bName = d.value(forKey: "name") as! String
                let bAuthor = d.value(forKey: "author") as! String
                let bIsbn = d.value(forKey: "isbn") as! String
                bookArr.append(BookModel(id: UId, bookid: bId, name: bName, author: bAuthor, ISBN: bIsbn))
//                print("name: \(bName)")
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
        book.setValue(bookToAdd.id, forKey: "id")
        book.setValue(bookToAdd.bookid, forKey: "bookid")
        book.setValue(bookToAdd.name, forKey: "name")
        book.setValue(bookToAdd.author, forKey: "author")
        book.setValue(bookToAdd.ISBN, forKey: "isbn")
        
        do {
            try managedContext.save()
            print("Book Saved successfully!")
        } catch let err as NSError {
            print(err)
        }
    }
    
    
    //  delete func for CD
    func deleteFromCD(book: BookModel) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        
        fetchRequest.predicate = NSPredicate(format: "bookid = %d", book.bookid)
//        fetchRequest.predicate = NSPredicate(format: "name = %@", book.name)
//        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(book.id)")
        
        do {
            let fetchRes = try managedContext.fetch(fetchRequest)
            let objToDelete = fetchRes[0] as! NSManagedObject
            managedContext.delete(objToDelete)
            
            try managedContext.save()
            print("Book deleted successfully")
            
        } catch let err as NSError {
            print("Somthing went wrong while deleting \(err)")
        }
    }
    
    
    //  update func for CD
    func updateInCD(updatedBook: BookModel) {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        
        fetchRequest.predicate = NSPredicate(format: "bookid = %d", updatedBook.bookid)
        
        do {
            let rawData = try managedContext.fetch(fetchRequest)
            
            let objUpdata = rawData[0] as! NSManagedObject
            objUpdata.setValue(updatedBook.name, forKey: "name")
            objUpdata.setValue(updatedBook.author, forKey: "author")
            objUpdata.setValue(updatedBook.ISBN, forKey: "isbn")
            
            try managedContext.save()
            print("Data updated successfully")
            
        } catch let err as NSError {
            print("Somthing went wrong while deleting \(err)")
        }
        
        
        
    }
}
