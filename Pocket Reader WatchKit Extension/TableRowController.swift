//
//  TableRowController.swift
//  Pocket Reader WatchKit Extension
//
//  Created by Алексей Пархоменко on 18.04.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import WatchKit

class TableRowController: NSObject {
    
    var book: BookItem! {
        didSet {
            nameLabel.setText(book.name)
            authorLabel.setText(book.author)
        }
    }
    
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!

}
