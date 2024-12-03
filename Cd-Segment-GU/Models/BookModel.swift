//
//  BookModel.swift
//  Cd-Segment-GU
//
//  Created by Jaimin Raval on 03/12/24.
//

import Foundation


struct BookModel: Codable {
    
    var id = UUID()
    var bookid: Int32
    var name: String
    var author: String
    var ISBN: String
    
}
