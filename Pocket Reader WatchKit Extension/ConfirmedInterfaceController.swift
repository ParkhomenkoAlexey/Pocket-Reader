//
//  ConfirmedInterfaceController.swift
//  Pocket Reader WatchKit Extension
//
//  Created by Алексей Пархоменко on 20.04.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import WatchKit
import Foundation


class ConfirmedInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var confirmationLabel: WKInterfaceLabel!
    
    var book: BookItem!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let book = context as? BookItem {
            self.book = book
            setTitle(book.name)
            confirmationLabel.setText("Вы уверены что хотите выбрать эту книгу?")
        }
    }

    @IBAction func bookSelected() {
        UserSettings.userBooks.append(book)
        popToRootController()
    }
    
    @IBAction func cancelSelected() {
        pop()
    }
}
