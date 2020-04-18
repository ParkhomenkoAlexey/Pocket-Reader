//
//  BooksInterfaceController.swift
//  Pocket Reader WatchKit Extension
//
//  Created by Алексей Пархоменко on 18.04.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import WatchKit
import Foundation


class BooksInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!
    var map = [GenreType: [BookItem]]()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        for book in BookItem.getBooks() {
            var arr = map[book.genre] ?? [BookItem]()
            arr.append(book)
            map[book.genre] = arr
        }
    
        map.forEach { (value) in
            print(value.value)
        }
        
    }
}
