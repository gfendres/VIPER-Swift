//
//  CityCell.swift
//  openweather
//
//  Created by Guilherme Endres on 05/02/17.
//  Copyright © 2017 openweather. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var countryLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    iconImageView.image = nil
  }
}
