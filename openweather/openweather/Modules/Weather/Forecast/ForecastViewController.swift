//
//  ForecastViewController.swift
//  openweather
//
//  Created by Guilherme Endres on 05/02/17.
//  Copyright (c) 2017 openweather. All rights reserved.
//
//

import UIKit
import RxSwift
import RxCocoa

class ForecastViewController: UIViewController, ShowError {

  // MARK: IBOutlets

  @IBOutlet weak var forecastCollectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!

  // MARK: Variables

  var presenter: ForecastPresenterInput?
  fileprivate var forecasts = Variable<[ForecastViewData]>([])
  private var disposeBag = DisposeBag()

  // MARK: View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
    
    forecastCollectionView.register(ForecastCell.self)
    forecastCollectionView.delegate = self

    forecasts.asDriver()
      .drive(forecastCollectionView.rx.items(cellIdentifier: ForecastCell.reuseIdentifier, cellType: ForecastCell.self)) { index, forecast, cell in
        cell.weatherDescriptionLabel.text = forecast.weatherDescription
        cell.temperatureLabel.text = forecast.temperature
        cell.maxTemperatureLabel.text = forecast.maxTemperature
        cell.minTemperatureLabel.text = forecast.minTemperature
        if let iconUrl = forecast.weatherIconUrl {
          cell.iconImageView.af_setImage(withURL: iconUrl, imageTransition: .crossDissolve(0.3))
        }
        cell.humidityLabel.text = forecast.humidity
        cell.pressureLabel.text = forecast.pressure
        cell.windLabel.text = forecast.windSpeed
      }.addDisposableTo(disposeBag)
  }

}

extension ForecastViewController: ForecastPresenterOutput {
  func showForecast(_ forecast: [ForecastViewData]) {
    self.forecasts.value = forecast
    pageControl.numberOfPages = forecast.count
  }

  func showCity(name: String) {
    title = name
  }
}

extension ForecastViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.bounds.size
  }
}

extension ForecastViewController: UICollectionViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let screenOffsetX = forecastCollectionView.contentOffset.x
    let width = scrollView.frame.width
    let pageIndex = Int(screenOffsetX / width)
    pageControl.currentPage = pageIndex
  }
  
}
