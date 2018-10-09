//
//  PersonTableViewCell.swift
//  SampleApp
//
//  Created by Silvia on 10/9/18.
//  Copyright © 2018 Silvia Valdez. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
