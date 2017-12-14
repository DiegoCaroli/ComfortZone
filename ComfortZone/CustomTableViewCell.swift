//
//  CustomTableViewCell.swift
//  ComfortZone
//
//  Created by Nicola Centonze on 14/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var typeTaskLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
