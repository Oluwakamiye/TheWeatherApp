//
//  WeatherDetailViewController.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 20/06/2022.
//

import UIKit

final class WeatherDetailViewController: UICollectionViewController {
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.currentPageIndicatorTintColor = .systemRed
        pageControl.hidesForSinglePage = true
        pageControl.addTarget(self, action: #selector(pageControltapped), for: .valueChanged)
        return pageControl
    }()
    private lazy var searchCitiesButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .systemPink
        button.addTarget(self, action: #selector(goToSearchCities), for: .touchUpInside)
        return button
    }()
    private lazy var citiesButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.tintColor = .systemPink
        button.addTarget(self, action: #selector(goToAddedCities), for: .touchUpInside)
        return button
    }()
    
    private var viewModel = WeatherDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionView.register(UINib(nibName: String(describing: WeatherDetailCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: WeatherDetailCollectionViewCell.self))
        collectionView.collectionViewLayout = generateLayout()
        pageControl.numberOfPages = viewModel.cities.count
        viewModel.fetchCities()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let leftButton = UIBarButtonItem(customView: searchCitiesButton)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let pc = UIBarButtonItem(customView: pageControl)
        let rightButton = UIBarButtonItem(customView: citiesButton)
        toolbarItems = [leftButton, spacer, pc, spacer, rightButton]
        navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @objc private func goToSearchCities() {
        guard let destinationVC = SearchCityViewController.makeSelf() else  {
            return
        }
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @objc private func goToAddedCities() {
        guard let destinationVC = SavedWeatherCitiesViewController.makeSelf() else  {
            return
        }
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let fullItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [fullItem])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration.interSectionSpacing = 10
        layout.configuration.scrollDirection = .horizontal
        return layout
    }
    
    // Detect when the pagecontrol is tapped
    @objc private func pageControltapped(_ sender: Any) {
        guard let pageControl = sender as? UIPageControl else { return }
        let selectedPage = pageControl.currentPage
        if var indexPath = collectionView.indexPathsForVisibleItems.first {
            indexPath.row = selectedPage
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
    
    static func makeSelf() -> WeatherDetailViewController? {
        guard let destinationVC = UIStoryboard.storyboard(.Main).instantiateViewController(withIdentifier: WeatherDetailViewController.className) as? WeatherDetailViewController else {
            return nil
        }
        return destinationVC
    }
}

// MARK: - CollectionView and PageControl Delegate
extension WeatherDetailViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
}

// MARK: - CollectionView Delegate
extension WeatherDetailViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let city = viewModel.cities[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WeatherDetailCollectionViewCell.self), for: indexPath) as? WeatherDetailCollectionViewCell {
            cell.configureCell(city: city)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

// MARK: - ViewModelDelegates
extension WeatherDetailViewController: WeatherDetailViewModelDelegate {
    func reloadCollectionView() {
        pageControl.numberOfPages = viewModel.cities.count
        pageControl.currentPage = 0
        collectionView.reloadData()
    }
}
