//
//  SearchCityViewController.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/06/2022.
//

import UIKit

final class SearchCityViewController: UIViewController {
    @IBOutlet private(set) weak var searchBar: UISearchBar!
    @IBOutlet private(set) weak var tableView: UITableView!
    
    private var viewModel = SearchCityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        tableView.register(UINib(nibName: String(describing: CityTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: CityTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    static func makeSelf() -> SearchCityViewController? {
        guard let destinationVC = UIStoryboard.storyboard(.Main).instantiateViewController(withIdentifier: SearchCityViewController.className) as? SearchCityViewController else {
            return nil
        }
        return destinationVC
    }
}


// MARK: - Searchbar Delegates
extension SearchCityViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            viewModel.searchForCity(city: searchText)
        }
    }
}


// MARK: - TableView Delegates
extension SearchCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = viewModel.cities[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CityTableViewCell.self), for: indexPath) as? CityTableViewCell {
            cell.configureCell(city: city)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


// MARK: - ViewModel Delegates
extension SearchCityViewController: SearchCityViewModelDelegate {
    func updateTable() {
        tableView.reloadData()
    }
}
