//
//  ForecastCell.swift
//  openweather
//
//  Created by Guilherme Endres on 05/02/17.
//  Copyright © 2017 openweather. All rights reserved.
//

import UIKit

class ForecastCell: UICollectionViewCell {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var weatherDescriptionLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var maxTemperatureLabel: UILabel!
  @IBOutlet weak var minTemperatureLabel: UILabel!
  @IBOutlet weak var pressureLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var windLabel: UILabel!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    iconImageView.image = nil
  }
}
