//
//  CategorySearchTableViewCell.swift
//  Conari
//
//  Created by ST R W on 20.04.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit

class CategorySearchTableViewCell: UITableViewCell {
    
    // Properties
    
    @IBOutlet var label_title: UILabel!
    @IBOutlet var label_category: UILabel!
    @IBOutlet var label_difficulty: UILabel!
    
    @IBOutlet var image_view: UIImageView!
    
    
    @IBOutlet var label_duration: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}

class CategorySearchYoutubeTableViewCell: UITableViewCell {
  
  // Properties
  
  @IBOutlet var label_title: UILabel!
  @IBOutlet var image_view: UIImageView!
  
  
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  
}