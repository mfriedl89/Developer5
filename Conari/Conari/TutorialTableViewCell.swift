//
//  TutorialTableViewCell.swift
//  Conari
//
//  Created by Markus Friedl on 04.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class TutorialTableViewCell: UITableViewCell {

    @IBOutlet weak var tutorialTitleLabel: UILabel!
    @IBOutlet weak var tutorialDetailTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
