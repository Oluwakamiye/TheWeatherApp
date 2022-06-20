//
//  WeatherViewController.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/06/2022.
//

import UIKit

final class WeatherViewController: UIViewController {
    @IBOutlet private(set) weak var tableView: UITableView!
    
    private var viewModel =  WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        tableView.register(UINib(nibName: String(describing: WeatherTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: WeatherTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        setupNavigationSearchBar()
        viewModel.searchCity()
    }
    
    private func setupNavigationSearchBar() {
        let searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.delegate = self
        searchBarController.searchBar.delegate = self
        self.navigationItem.searchController = searchBarController
    }
    
    static func makeSelf() -> WeatherViewController? {
        guard let destinationVC = UIStoryboard.storyboard(.Main).instantiateViewController(withIdentifier: WeatherViewController.className) as? WeatherViewController else {
            return nil
        }
        return destinationVC
    }
    
}

// MARK: - SearchBar Delegates
extension WeatherViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchCity(cityName: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchCity(cityName: searchBar.text)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.searchCity(cityName: searchBar.text)
    }
}

// MARK: - TableView Delegates
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.displayedCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = viewModel.displayedCities[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherTableViewCell.self),
                                                       for: indexPath) as? WeatherTableViewCell {
            cell.configureCell(city: city)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.displayedCities[indexPath.row].englishName)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


// MARK: - ViewModel Delegates
extension WeatherViewController: WeatherViewModelDelegate {
    func updateTable(){
        tableView.reloadData()
    }
}
