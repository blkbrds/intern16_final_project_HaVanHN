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

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        customNavigationBar()
        configCollectionView()
        configSlide()
        loadApi()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarStyle = .lightContent
    }

    // MARK: - Private functions
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let trendingCell = UINib(nibName: "TrendingCell", bundle: Bundle.main)
        tableView.register(trendingCell, forCellReuseIdentifier: "TrendingCell")
        tableView.sectionIndexBackgroundColor = UIColor.white
        tableView.sectionIndexTrackingBackgroundColor = UIColor.white
    }

    private func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let slideCell = UINib(nibName: "SliderCell", bundle: Bundle.main)
        collectionView.register(slideCell, forCellWithReuseIdentifier: "SliderCell")
    }

    private func customNavigationBar() {
        navigationItem.title = "Eatery Tour"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1602264941, green: 0.4939214587, blue: 0.4291425645, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    private func configSlide() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            if self.pageControl.currentPage <= 3 {
                self.pageControl.currentPage += 1
            } else {
                self.pageControl.currentPage = 0
            }
            self.collectionView.scrollToItem(at: IndexPath(item: self.pageControl.currentPage, section: 0), at: .right, animated: true)
        }
    }

    private func loadApi() {
        viewModel.getTrendingRestaurant(limit: 20) { (done, error) in
            if done {
                self.tableView.reloadData()
                for cell in self.tableView.visibleCells {
                    if let cell = cell as? TrendingCell {
                        cell.getInformation { (done, error) in
                            if !done {
                                print(error)
                            }
                        }
                    }
                }
            } else {
                self.showAlert(error: error)
            }
        }
    }

    private func showAlert(error: String) {
        let alert = UIAlertController(title: "Fail to get restaurant", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "error", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trendingCell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell", for: indexPath) as? TrendingCell
        trendingCell?.viewModel = viewModel.getCellForRowAt(atIndexPath: indexPath)
        trendingCell?.delegate = self
        return trendingCell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageListSlide.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let slideCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as? SliderCell else { return CollectionCell() }
        slideCell.viewModel = viewModel.getImageForSlide(atIndexPath: indexPath)
        return slideCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.bounds.height)
    }
}

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            for cell in tableView.visibleCells {
                if let cell = cell as? TrendingCell {
                    cell.getInformation { (done, error) in
                        if !done {
                            print(error)
                        }
                    }
                }
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in tableView.visibleCells {
            if let cell = cell as? TrendingCell {
                cell.getInformation { (done, error) in
                    if !done {
                        print(error)
                    }
                }
            }
        }
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
