//
//  SavedWeatherCitiesViewController.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/06/2022.
//

import UIKit

final class SavedWeatherCitiesViewController: UIViewController {
    @IBOutlet private(set) weak var tableView: UITableView!
    private var viewModel: WeatherViewModel!
    
    private lazy var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(forceCitiesRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        tableView.register(UINib(nibName: String(describing: WeatherTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: WeatherTableViewCell.self))
        tableView.refreshControl = refreshControl
        tableView.delegate = self
        tableView.dataSource = self
        setupNavigationSearchBar()
        viewModel.searchCity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCities()
        navigationItem.title = "Saved Cities"
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupNavigationSearchBar() {
        let searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.delegate = self
        searchBarController.searchBar.delegate = self
        self.navigationItem.searchController = searchBarController
    }
    
    @objc private func forceCitiesRefresh() {
        viewModel.fetchCities()
    }
    
    static func makeSelf() -> SavedWeatherCitiesViewController? {
        guard let destinationVC = UIStoryboard.storyboard(.Main).instantiateViewController(withIdentifier: SavedWeatherCitiesViewController.className) as? SavedWeatherCitiesViewController else {
            return nil
        }
        destinationVC.viewModel = WeatherViewModel()
        return destinationVC
    }
}

// MARK: - SearchBar Delegates
extension SavedWeatherCitiesViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchCity(cityName: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
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
extension SavedWeatherCitiesViewController: UITableViewDelegate, UITableViewDataSource {
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
        tableView.deselectRow(at: indexPath, animated: true)
        let city = viewModel.displayedCities[indexPath.row]
        viewModel.savedCitySelected(city: city)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}


// MARK: - ViewModel Delegates
extension SavedWeatherCitiesViewController: WeatherViewModelDelegate {
    func updateTable(){
        tableView.reloadData()
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    func navigateToCityDetailViewController(city: City) {
        guard let destinationVC = CityDetailViewController.makeSelf(city: city) else {
            return
        }
        present(destinationVC, animated: true)
    }
}
