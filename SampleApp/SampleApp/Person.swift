//
//  Person.swift
//  SampleApp
//
//  Created by Silvia on 10/10/18.
//  Copyright © 2018 Silvia Valdez. All rights reserved.
//

import UIKit

class Person {
    
    // MARK: Properties
    
    var name: String
    var profession: String
    var photo: UIImage?
    
    // MARK: Initialization
    
    init?(name: String, profession: String, photo: UIImage?) {
        // Initialization should fail if there is no name or if there is no profession.
        if name.isEmpty || profession.isEmpty  {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.profession = profession
        self.photo = photo
    }
    
}
