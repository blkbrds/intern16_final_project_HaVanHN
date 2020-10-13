//
//  HomeViewController.swift
//  EateryTour
//
//  Created by Khoa Vo T.A. on 9/7/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD

final class HomeViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: TableView!

    // MARK: - Propeties
    private var viewModel = HomeViewModel()
    private var refreshControl = UIRefreshControl()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        configRefreshControl()
        configLocation()
        configTableView()
        getRecommendRestaurant()
        getTrendingRestaurant()
        getDataFromRealm()
        addObserve()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Private functions
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let recommendCell = UINib(nibName: "RecommendCell", bundle: Bundle.main)
        tableView.register(recommendCell, forCellReuseIdentifier: "RecommendCell")
        let trendingCollectionCell = UINib(nibName: "TrendingCollectionCell", bundle: .main)
        tableView.register(trendingCollectionCell, forCellReuseIdentifier: "TrendingCollectionCell")
        let customHeader = UINib(nibName: "CustomHeader", bundle: Bundle.main)
        tableView.register(customHeader, forHeaderFooterViewReuseIdentifier: "CustomHeader")
    }

    private func configNavigationBar() {
        navigationItem.title = "Eatery Tour"
        navigationController?.navigationBar.barTintColor = App.Color.appColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    private func configRefreshControl() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.tintColor = App.Color.appColor
        refreshControl.addTarget(self, action: #selector(refreshRestaurantData(_:)), for: .valueChanged)
    }

    private func configLocation() {
        LocationManager.shared.configLocationService()
    }

    private func getTrendingRestaurant() {
        HUD.show()
        viewModel.getTrendingRestaurant(limit: 10) { [weak self] (result) in
            HUD.popActivity()
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            case .failure(let error):
                this.alert(msg: error.localizedDescription, handler: nil)
            }
        }
    }

    private func getRecommendRestaurant() {
        HUD.show()
        viewModel.getRecommendRestaurant(limit: 20) { [weak self] (result) in
            HUD.popActivity()
            guard let this = self else { return }
            switch result {
            case.success:
                this.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
                this.loadMoreInformationForRecommendRestaurant()
            case .failure(let error):
                this.alert(msg: error.localizedDescription, handler: nil)
            }
        }
    }

    private func loadMoreInformationForRecommendRestaurant() {
        for cell in tableView.visibleCells {
            if let cell = cell as? RecommendCell {
                cell.loadMoreInformation { result in
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

    private func addObserve() {
        viewModel.setupObserver {
            self.tableView.reloadData()
        }
    }

    private func getDataFromRealm() {
        viewModel.getDataFromRealm { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let error):
                this.alert(msg: error.localizedDescription, handler: nil)
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.sectionType(inSection: indexPath.section) {
        case .trending:
            guard let trendingCell = tableView.dequeueReusableCell(withIdentifier: "TrendingCollectionCell", for: indexPath) as? TrendingCollectionCell else { return UITableViewCell() }
            trendingCell.viewModel = viewModel.getCellTrendingForRowAt(atIndexPath: indexPath)
            return trendingCell
        case .recommend:
            guard let recommentCell = tableView.dequeueReusableCell(withIdentifier: "RecommendCell", for: indexPath) as? RecommendCell else { return UITableViewCell() }
            recommentCell.viewModel = viewModel.getCellRecommendForRowAt(atIndexPath: indexPath)
            recommentCell.delegate = self
            return recommentCell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as? CustomHeader else { return nil }
        view.viewModel = viewModel.viewForHeaderInSection(inSection: section)
        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.viewModel = viewModel.pushDataToDetailVC(atIndexPath: indexPath)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(atIndexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

// MARK: - UIScrollViewDelegates
extension HomeViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadMoreInformationForRecommendRestaurant()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loadMoreInformationForRecommendRestaurant()
        }
    }
}

// MARK: - RecommendCellDelegate
extension HomeViewController: RecommendCellDelegate {

    func cell(_ cell: RecommendCell, needsPerform action: RecommendCell.Action) {
        switch action {
        case .callApiSuccess(restaurant: let restaurant):
            viewModel.updateApiSuccess(newRestaurant: restaurant)
        case .changeFavoriteState(id: let id):
            viewModel.changeFavoriteRestaurant(withId: id) { result in
                switch result {
                case .success:
                    self.getDataFromRealm()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
