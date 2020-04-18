//
//  StarterInterfaceController.swift
//  Pocket Reader WatchKit Extension
//
//  Created by Алексей Пархоменко on 18.04.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import WatchKit
import Foundation


class StarterInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!
    let books = BookItem.getBooks()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setupTable()
    }
    
    func setupTable() {
        table.setNumberOfRows(books.count, withRowType: "myBookRow")
        
        for (index, book) in books.enumerated() {
            if let rowController = table.rowController(at: index) as? MyBookRowController {
                rowController.nameLabel.setText(book.name)
                let book = books[index]
                rowController.book = book
            }
        }
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        if let rowController = table.rowController(at: rowIndex) as? MyBookRowController {
            return rowController.book
        }
        return nil
    }
}
