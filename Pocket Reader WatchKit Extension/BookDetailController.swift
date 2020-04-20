//
//  BookDetailController.swift
//  Pocket Reader WatchKit Extension
//
//  Created by Алексей Пархоменко on 17.04.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import WatchKit
import Foundation


class BookDetailController: WKInterfaceController {
    
    @IBOutlet weak var descriptionLabel: WKInterfaceLabel!
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    @IBOutlet weak var editionLabel: WKInterfaceLabel!
    @IBOutlet weak var pagesLabel: WKInterfaceLabel!
    @IBOutlet weak var selectButton: WKInterfaceButton!
    @IBOutlet weak var image: WKInterfaceImage!
    
    var book: BookItem!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let book = context as? BookItem {
            self.book = book
            
            nameLabel.setText(book.name)
            authorLabel.setText(book.author)
            editionLabel.setText(String(book.edition))
            pagesLabel.setText(String(book.pages))
            descriptionLabel.setText(book.bookDescription)
            image.setImageNamed(book.imageName)
            
            let pickedBooks = Set(UserSettings.userBooks.lazy.map { $0.name })
            selectButton.setHidden(pickedBooks.contains(book.name))
            
        }
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        switch segueIdentifier {
        case "confirmedBook":
            return book
        default:
            return book.bookDescription
        }
       
    }
}
