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
    
    var selectedBook: BookModel!
    
    var apiBookArr: [BookModel] = [
        BookModel(bookid: 01, name: "To Kill a Mockingbird", author: "Harper Lee", ISBN: "9780446310789"),
        BookModel(bookid: 02, name: "1984", author: "George Orwell", ISBN: "9780451524935"),
        BookModel(bookid: 03, name: "Pride and Prejudice", author: "Jane Austen", ISBN: "9780141439518"),
        BookModel(bookid: 04, name: "The Great Gatsby", author: "F. Scott Fitzgerald", ISBN: "9780743273565"),
        BookModel(bookid: 05, name: "Brave New World", author: "Aldous Huxley", ISBN: "9780060850524"),
        BookModel(bookid: 06, name: "The Catcher in the Rye", author: "J.D. Salinger", ISBN: "9780316769174"),
        BookModel(bookid: 07, name: "Sapiens: A Brief History of Humankind", author: "Yuval Noah Harari", ISBN: "9780062316110"),
        BookModel(bookid: 08, name: "The Hobbit", author: "J.R.R. Tolkien", ISBN: "9780547928227"),
        BookModel(bookid: 09, name: "Dune", author: "Frank Herbert", ISBN: "9780441172719"),
        BookModel(bookid: 10, name: "The Alchemist", author: "Paulo Coelho", ISBN: "9780062315007"),
        BookModel(bookid: 11, name: "Crime and Punishment", author: "Fyodor Dostoevsky", ISBN: "9780141192802"),
        BookModel(bookid: 12, name: "The Name of the Wind", author: "Patrick Rothfuss", ISBN: "9780756404079"),
        BookModel(bookid: 13, name: "Thinking, Fast and Slow", author: "Daniel Kahneman", ISBN: "9780374275631"),
        BookModel(bookid: 14, name: "The Hitchhiker's Guide to the Galaxy", author: "Douglas Adams", ISBN: "9780345391803"),
        BookModel(bookid: 15, name: "Neuromancer", author: "William Gibson", ISBN: "9780441569595"),
        BookModel(bookid: 16, name: "The Road", author: "Cormac McCarthy", ISBN: "9780307387899"),
        BookModel(bookid: 17, name: "Wolf Hall", author: "Hilary Mantel", ISBN: "9780805080681"),
        BookModel(bookid: 18, name: "The Power of Habit", author: "Charles Duhigg", ISBN: "9780812981605"),
        BookModel(bookid: 19, name: "Becoming", author: "Michelle Obama", ISBN: "9781524763138"),
        BookModel(bookid: 20, name: "The Three-Body Problem", author: "Cixin Liu", ISBN: "9780765377067"),
        BookModel(bookid: 21, name: "Atomic Habits", author: "James Clear", ISBN: "9780735211292"),
        BookModel(bookid: 22, name: "The Martian", author: "Andy Weir", ISBN: "9780553418026"),
        BookModel(bookid: 23, name: "Educated", author: "Tara Westover", ISBN: "9780399590504"),
        BookModel(bookid: 24, name: "Snow Crash", author: "Neal Stephenson", ISBN: "9780553380958"),
        BookModel(bookid: 25, name: "A Short History of Nearly Everything", author: "Bill Bryson", ISBN: "9780767915472"),
        BookModel(bookid: 26, name: "The Immortal Life of Henrietta Lacks", author: "Rebecca Skloot", ISBN: "9781400052189"),
        BookModel(bookid: 27, name: "Gödel, Escher, Bach", author: "Douglas Hofstadter", ISBN: "9780465026570")
    ]
    
    var bookArr: [BookModel] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bookArr = CDManager().readFromCd()
        reloadUI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableSegment.selectedSegmentIndex = 0
        self.bookArr = CDManager().readFromCd()

        setupTable()
        reloadUI()
    }
    
    
    func setupTable(){
        bookTable.delegate = self
        bookTable.dataSource = self
        
        cdTable.delegate = self
        cdTable.dataSource = self
        
        bookTable.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "BookCell")
        cdTable.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "BookCell")
        bookTable.isHidden = false
        cdTable.isHidden = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToUpdate" {
            if let updateVC = segue.destination as? UpdateVC {
                updateVC.bookPassed = selectedBook
            }
        }
    }
    
    
    func reloadUI() {
        DispatchQueue.main.async {
            
            if self.tableSegment.selectedSegmentIndex == 0 {
                self.bookTable.reloadData()
                self.bookTable.isHidden = false
                self.cdTable.isHidden = true

            } else if self.tableSegment.selectedSegmentIndex == 1 {
                self.bookArr = CDManager().readFromCd()
                self.cdTable.reloadData()
                self.cdTable.isHidden = false
                self.bookTable.isHidden = true

            }
        }
    }
    
    
    func deleteFromArr(position: Int) {
        bookArr.remove(at: position)
        DispatchQueue.main.async {
            self.cdTable.reloadData()
        }
    }
    
    
    @IBAction func segmentChanged(_ sender: Any) {
//        print("current selected segment: \(tableSegment.selectedSegmentIndex)")
        reloadUI()
        
    }
    
}



extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableSegment.selectedSegmentIndex == 0 ? apiBookArr.count : bookArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else {
                return UITableViewCell()
        }
            
        let currSeg = tableSegment.selectedSegmentIndex
        
        switch currSeg {
        case 0:
            guard indexPath.row < apiBookArr.count else {
                print("Index out of bounds for apiBookArr")
                return cell
            }
            let book = apiBookArr[indexPath.row]
            configureCell(cell, with: book)
            
        case 1:
            guard indexPath.row < bookArr.count else {
                print("Index out of bounds for bookArr")
                return cell
            }
            let book = bookArr[indexPath.row]
            configureCell(cell, with: book)
            
        default:
            break
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    private func configureCell(_ cell: BookCell, with book: BookModel) {
        cell.bName.text = book.name
        cell.bAuthor.text = book.author
        cell.bID.text = "\(book.bookid)"
        cell.bISBN.text = book.ISBN
        cell.bUUID.text = "\(book.id)"
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == bookTable {
            
            let bookSelected = apiBookArr[indexPath.row]
            CDManager().AddToCd(bookToAdd: bookSelected)
            bookTable.deselectRow(at: indexPath, animated: true)
            AlertManager.shared.okayAlert(on: self, title: "Added Successfully", msg: "Data added to CoreData") {
//                navigationController
            }
        } else if tableView == cdTable {
            cdTable.deselectRow(at: indexPath, animated: true)

        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == cdTable {
            
            let updateAction = UIContextualAction(style: .normal, title: "Update") { (action, view, completionHandler) in
            
                self.selectedBook = self.bookArr[indexPath.row]
                self.performSegue(withIdentifier: "GoToUpdate", sender: self)
                
                completionHandler(true)
            }
            updateAction.backgroundColor = .systemOrange
            updateAction.image = UIImage(systemName: "rectangle.and.pencil.and.ellipsis")
            let updateConfig = UISwipeActionsConfiguration(actions: [updateAction])
            
            return updateConfig
        } else {
            let updateConfig = UISwipeActionsConfiguration(actions: [])
            
            return updateConfig
        }
        // Determine which array to use based on segment
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == cdTable {
            let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [self] action, v, completion in
                //  Alert shown for confirmation
                AlertManager.shared.classicAlert(on: self, title: "Are you sure", msg: "this is an irreversable action", yesBtnAction:  { [self] in
                    
                    //  CoreData's Delete function called
                    let bookToDelete = bookArr[indexPath.row]
                    CDManager().deleteFromCD(book: bookToDelete)
                    deleteFromArr(position: indexPath.row)
                    completion(true)

                }, cancelBtnAction: {
                    completion(true)

                })
            }
            
            deleteAction.backgroundColor = .systemRed
            deleteAction.image = UIImage(systemName: "minus.circle.fill")
            let deleteConfig = UISwipeActionsConfiguration(actions: [deleteAction])
            return deleteConfig
        } else {
            let deleteConfig = UISwipeActionsConfiguration(actions: [])
            
            return deleteConfig
        }
    }
    
    
    
}
