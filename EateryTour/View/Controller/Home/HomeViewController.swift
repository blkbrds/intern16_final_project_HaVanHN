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
    private var slideToRight: Bool = true
    private var location: CLLocation?
    private var trendingCell: TrendingTableViewCell?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //getCurrentLocation()
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
        let trendingCell = UINib(nibName: "TrendingTableViewCell", bundle: Bundle.main)
        tableView.register(trendingCell, forCellReuseIdentifier: "trendingCell")
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
            if self.slideToRight {
                self.pageControl.currentPage += 1
                self.collectionView.scrollToItem(at: IndexPath(item: self.pageControl.currentPage, section: 0), at: .right, animated: true)
                if self.pageControl.currentPage == 4 {
                    self.slideToRight = false
                }
            } else {
                self.pageControl.currentPage -= 1
                self.collectionView.scrollToItem(at: IndexPath(item: self.pageControl.currentPage, section: 0), at: .left, animated: true)
                if self.pageControl.currentPage == 0 {
                    self.slideToRight = true
                }
            }
        }
    }

    private func loadApi() {
        viewModel.getTrendingRestaurant { (done) in
            if done {
                self.tableView.reloadData()
                for cell in self.tableView.visibleCells {
                    if let cell = cell as? TrendingTableViewCell {
                        cell.getInformation { (done, error) in
                            if !done {
                                self.showAlert(error: error)
                            }
                        }
                    }
                }
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
        // print(viewModel.restaurant?.count)
        return viewModel.restaurant?.count ?? 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        trendingCell = tableView.dequeueReusableCell(withIdentifier: "trendingCell", for: indexPath) as? TrendingTableViewCell
        trendingCell?.viewModel = viewModel.getCellForRowAt(atIndexPath: indexPath)
        return trendingCell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let uiView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
        let label = UILabel(frame: CGRect(x: 15, y: 20, width: tableView.bounds.width, height: 30))
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        label.attributedText = NSAttributedString(string: "Trending", attributes: attributes)
        uiView.addSubview(label)
        return uiView
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
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
                if let cell = cell as? TrendingTableViewCell {
                    cell.getInformation { (done, error) in
                        if !done {
                            self.showAlert(error: error)
                        }
                    }
                }
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in tableView.visibleCells {
            if let cell = cell as? TrendingTableViewCell {
                cell.getInformation { (done, error) in
                    if !done {
                        self.showAlert(error: error)
                    }
                }
            }
        }
    }
}
