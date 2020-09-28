//
//  HomeViewController.swift
//  EateryTour
//
//  Created by Khoa Vo T.A. on 9/7/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit
import CoreLocation

final class HomeViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: TableView!
    @IBOutlet private weak var collectionView: CollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!

    // MARK: - Propeties
    private var viewModel = HomeViewModel()
    private var refreshControl = UIRefreshControl()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configNavigationBar()
        configCollectionView()
        configRefreshControl()
        configLocation()
        getTrendingRestaurant()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
    }

    // MARK: - Private functions
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let recommendCell = UINib(nibName: "RecommendCell", bundle: Bundle.main)
        tableView.register(recommendCell, forCellReuseIdentifier: "RecommendCell")
    }

    private func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let trendingCell = UINib(nibName: "TrendingCell", bundle: Bundle.main)
        collectionView.register(trendingCell, forCellWithReuseIdentifier: "TrendingCell")
    }

    private func configNavigationBar() {
        navigationItem.title = "Eatery Tour"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1602264941, green: 0.4939214587, blue: 0.4291425645, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    private func configRefreshControl() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.tintColor = #colorLiteral(red: 0.10909646, green: 0.2660153806, blue: 0.2814711332, alpha: 1)
        refreshControl.addTarget(self, action: #selector(refreshRestaurantData(_:)), for: .valueChanged)
    }

    private func configLocation() {
        LocationManager.shared.configLocationService()
    }

    private func getTrendingRestaurant() {
        viewModel.getTrendingRestaurant(limit: 25) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.collectionView.reloadData()
                this.getMoreInformationForCell()
            case .failure(let error):
                this.alert(msg: error.localizedDescription, handler: nil)
            }
        }
    }

    private func getMoreInformationForCell() {
        for cell in  collectionView.visibleCells {
            if let cell = cell as? TrendingCell {
                cell.getInformation { (result) in
                    switch result {
                    case .success:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }

    // MARK: - Objc functions
    @objc private func refreshRestaurantData(_ sender: Any) {
        getTrendingRestaurant()
        refreshControl.endRefreshing()
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.stopAnimating()
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recommendCell = tableView.dequeueReusableCell(withIdentifier: "RecommendCell", for: indexPath) as? RecommendCell else { return UITableViewCell() }
        return recommendCell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.restaurants.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let trendingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCell", for: indexPath) as? TrendingCell else { return CollectionCell() }
        trendingCell.viewModel = viewModel.getCellForRowAt(atIndexPath: indexPath)
        return trendingCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 1.5 + 20, height: 210)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            getMoreInformationForCell()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        getMoreInformationForCell()
    }
}

// MARK: - TrendingCellDelegate
extension HomeViewController: TrendingCellDelegate {

    func cell(_ cell: TrendingCell, needsPerform action: TrendingCell.Action) {
        switch action {
        case .callApiSuccess(restaurant: let restaurant):
            viewModel.updateApiSuccess(newRestaurant: restaurant)
        }
    }
}
