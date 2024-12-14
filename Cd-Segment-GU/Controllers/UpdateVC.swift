//
//  UpdateVC.swift
//  Cd-Segment-GU
//
//  Created by Jaimin Raval on 07/12/24.
//

import UIKit

class UpdateVC: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var authorTxt: UITextField!
    
    @IBOutlet weak var isbnTxt: UITextField!
    
    var bookPassed: BookModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
    }
    
    
    func showData() {
        nameTxt.text = bookPassed.name
        authorTxt.text = bookPassed.author
        isbnTxt.text = bookPassed.ISBN
    }
    
    
    @IBAction func UpdatePressed(_ sender: Any) {
        
        let updatedName = nameTxt.text!
        let updatedAuthor = authorTxt.text!
        let updatedISBN = isbnTxt.text!
        
        if updatedName != "" || updatedAuthor != "" || updatedISBN != "" {
            AlertManager.shared.classicAlert(on: self, title: "Are you sure", msg: "this is an irreversable action and cannot undo it", yesBtnAction:  { [self] in
                
                //  CoreData's Update function called
                let updatedBook = BookModel(bookid: bookPassed.bookid, name: updatedName, author: updatedAuthor, ISBN: updatedISBN)
                DispatchQueue.main.async {
                    CDManager().updateInCD(updatedBook: updatedBook)
                    self.navigationController?.popViewController(animated: true)
                }

            }, cancelBtnAction: {

            })
        }
        
        
    }
    

}
