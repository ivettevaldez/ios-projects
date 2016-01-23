//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Silvia Valdez on 19/11/15.
//  Copyright © 2015 Hunabsys. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    // Initializer or constructor.
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
}