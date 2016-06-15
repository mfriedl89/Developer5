//
//  CategorySearchTableViewCell.swift
//  Tutorialcloud
//
//  Created on 20.04.16.
//  Copyright © 2016 Developer5. All rights reserved.
//


import UIKit

class CategorySearchTableViewCell: UITableViewCell {

  @IBOutlet var label_title: UILabel!
  @IBOutlet var label_category: UILabel!
  @IBOutlet var label_difficulty: UILabel!
  
  @IBOutlet var image_view: UIImageView!
  
  
  @IBOutlet var label_duration: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

class CategorySearchYoutubeTableViewCell: UITableViewCell {
  
  @IBOutlet var label_title: UILabel!
  @IBOutlet var image_view: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}