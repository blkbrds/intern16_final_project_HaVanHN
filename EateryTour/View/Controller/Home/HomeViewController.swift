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
        let trendingCollectionCell = UINib(nibName: "TrendingCollectionCell", bundle: .main)
        tableView.register(trendingCollectionCell, forCellReuseIdentifier: "TrendingCollectionCell")
        let customHeader = UINib(nibName: "CustomHeader", bundle: Bundle.main)
        tableView.register(customHeader, forHeaderFooterViewReuseIdentifier: "CustomHeader")
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
        HUD.show()
        viewModel.getTrendingRestaurant(limit: 10) { [weak self] (result) in
            HUD.popActivity()
            guard let this = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    this.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                }
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
                DispatchQueue.main.async {
                    this.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
                }
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
            return recommentCell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as? CustomHeader else { return nil }
        view.viewModel = viewModel.viewForHeaderInSection(inSection: section)
        return view
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
