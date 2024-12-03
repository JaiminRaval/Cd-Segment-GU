//
//  TableViewCell.swift
//  Cd-Segment-GU
//
//  Created by Jaimin Raval on 03/12/24.
//

import UIKit

class BookCell: UITableViewCell {

    @IBOutlet weak var bName: UILabel!
    
    @IBOutlet weak var bAuthor: UILabel!
    
    @IBOutlet weak var bISBN: UILabel!
    
    @IBOutlet weak var bID: UILabel!
    
    @IBOutlet weak var bUUID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
