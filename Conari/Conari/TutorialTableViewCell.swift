//
//  TutorialTableViewCell.swift
//  Tutorialcloud
//
//  Created on 04.05.16.
//  Copyright © 2016 Developer5. All rights reserved.
//


import UIKit

class TutorialTableViewCell: UITableViewCell {
  
  @IBOutlet weak var tutorialTitleLabel: UILabel!
  @IBOutlet weak var tutorialDetailTextLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
