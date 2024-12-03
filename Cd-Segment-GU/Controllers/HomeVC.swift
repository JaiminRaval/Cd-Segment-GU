//
//  HomeVC.swift
//  Cd-Segment-GU
//
//  Created by Jaimin Raval on 03/12/24.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableSegment: UISegmentedControl!
    
    @IBOutlet weak var bookTable: UITableView!
    
    @IBOutlet weak var cdTable: UITableView!
    
    var bookArr: [BookModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        readFromCd()
    }
    
    func setupTable(){
        bookTable.delegate = self
        bookTable.dataSource = self
        bookTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        
    }
    
    
    
    func readFromCd() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let fetchRes = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        
        do {
            let dataArr = try managedContext.fetch(fetchRes)
            
            for d in dataArr as! [NSManagedObject] {
                let bookName = d.value(forKey: "name") as! String
                bookArr.append(BookModel(bookid: 0, name: bookName, author: "", ISBN: ""))
                print("name: \(bookName)")
            }
            
            DispatchQueue.main.async {
                self.bookTable.reloadData()
            }
            
        } catch let err as NSError {
            print(err)
        }
        
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        return cell
    }
    
    
   
    
    
}
