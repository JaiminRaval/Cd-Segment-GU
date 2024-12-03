//
//  FormVC.swift
//  Cd-Segment-GU
//
//  Created by Jaimin Raval on 03/12/24.
//

import UIKit
import CoreData

class FormVC: UIViewController {

    
    @IBOutlet weak var idText: UITextField!
    
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var authorTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readFromCd()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        let id = Int32(idText.text!)!
        let name = nameTxt.text!
        let author = authorTxt.text!
        
        
        let book = BookModel(bookid: id, name: name, author: author, ISBN: "")
        AddToCd(bookToAdd: book)
        
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
    
    
    func readFromCd() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let fetchRes = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        
        do {
            let dataArr = try managedContext.fetch(fetchRes)
            
            for d in dataArr as! [NSManagedObject] {
                let bookName = d.value(forKey: "name") as! String
                
                print("name: \(bookName)")
            }
            
        } catch let err as NSError {
            print(err)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
