//
//  StarterInterfaceController.swift
//  Pocket Reader WatchKit Extension
//
//  Created by Алексей Пархоменко on 18.04.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class StarterInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    func setupTable() {
        let pickedBooks = UserSettings.userBooks
        table.setNumberOfRows(pickedBooks.count, withRowType: "myBookRow")
        
        for (index, book) in pickedBooks.enumerated() {
            if let rowController = table.rowController(at: index) as? MyBookRowController {
                rowController.nameLabel.setText(book.name)
                let book = pickedBooks[index]
                rowController.book = book
            }
        }
    }

    override func willActivate() {
        super.willActivate()
        setupTable()
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
    
    @IBAction func deleteAll() {
        UserSettings.userBooks = []
        setupTable()
    }
}


