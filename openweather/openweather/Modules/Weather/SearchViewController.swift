//
//  SearchViewController.swift
//  openweather
//
//  Created by Guilherme Endres on 05/02/17.
//  Copyright (c) 2017 openweather. All rights reserved.
//
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class SearchViewController: UIViewController, ShowError {

  // MARK: Constants

  // MARK: IBOutlets

  @IBOutlet weak var citiesTableView: UITableView!
  
  // MARK: Variables

  var presenter: SearchPresenterInput?
  var cities = Variable<[CityViewData]>([])
  var disposeBag = DisposeBag()
  
  lazy var searchController: UISearchController = {
    var searchController = UISearchController(searchResultsController: nil)
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.barTintColor = #colorLiteral(red: 0.4660673793, green: 0.713941909, blue: 0.9319403108, alpha: 1)
    searchController.searchBar.backgroundImage = UIImage()
    searchController.searchBar.tintColor = #colorLiteral(red: 0.4660673793, green: 0.713941909, blue: 0.9319403108, alpha: 1)
    return searchController
  }()
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter?.viewDidLoad()
    
    definesPresentationContext = false
    citiesTableView.tableHeaderView = searchController.searchBar
    
    citiesTableView.register(CityCell.self)
    cities.asDriver()
      .drive(citiesTableView.rx.items(cellIdentifier: CityCell.reuseIdentifier, cellType: CityCell.self)) { index, city, cell in
        cell.nameLabel.text = city.name
        cell.countryLabel.text = city.country
        cell.temperatureLabel.text = city.temperature
        cell.descriptionLabel.text = city.weather
        if let url = city.iconUrl {
          cell.iconImageView.af_setImage(withURL: url, imageTransition: .crossDissolve(0.3))
        }
        
    }.addDisposableTo(disposeBag)

    searchController.searchBar.rx.text.orEmpty
      .throttle(0.3, scheduler: MainScheduler.instance)
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] text in
        self?.presenter?.didSearch(with: text)
    }).addDisposableTo(disposeBag)

    citiesTableView.rx.itemSelected
      .subscribe(onNext: { [weak self] index in
        self?.searchController.isActive = false
        self?.presenter?.didSelectItem(at: index.row)
      }).addDisposableTo(disposeBag)
  }

}

extension SearchViewController: SearchPresenterOutput {
  func showCities(_ cities: [CityViewData]) {
    self.cities.value = cities
  }
}
