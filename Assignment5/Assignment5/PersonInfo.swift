//
//  PersonInfo.swift
//  Assignment5
//
//  Created by Rishavgupta on 1/14/19.
//  Copyright © 2019 Nuclei. All rights reserved.
//

import UIKit

class PersonInfo: NSObject {
    var name: String?
    var number: String?
    
    init?(name: String, number: String ){
        self.name = name
        self.number = number
    }
}
