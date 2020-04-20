//
//  DescriptionInterfaceController.swift
//  Pocket Reader WatchKit Extension
//
//  Created by Алексей Пархоменко on 18.04.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import WatchKit
import Foundation

class DescriptionInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var descriptionLabel: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let description = context as? String {
            descriptionLabel.setText(description)
        }
    }
    
    @IBAction func cancelSelected() {
        pop()
    }
}
