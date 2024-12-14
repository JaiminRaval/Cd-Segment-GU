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
        
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        let id = Int32.random(in: 0...100)
        let isbn = idText.text!
        let name = nameTxt.text!
        let author = authorTxt.text!
        
        if isbn != "" && name != "" && author != "" {
            AlertManager.shared.okayAlert(on: self, title: "Added Successfully", msg: "Book added to CoreData") {
                let book = BookModel(bookid: id, name: name, author: author, ISBN: isbn)
                DispatchQueue.main.async {
                    CDManager().AddToCd(bookToAdd: book)
                    self.navigationController?.popViewController(animated: true)
                }
                
                
                
            }
        }
        
        
    }
    

}
