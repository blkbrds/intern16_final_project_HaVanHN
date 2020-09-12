//
//  HomeViewController.swift
//  EateryTour
//
//  Created by Khoa Vo T.A. on 9/7/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

enum SectionType {
    case trending
    case category
}

final class HomeViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Propeties
    private var viewModel = HomeViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        customNavigationBar()
        configCollectionView()
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
        let categoryCell = UINib(nibName: "CategoryTableViewCell", bundle: Bundle.main)
        tableView.register(categoryCell, forCellReuseIdentifier: "categoryCell")
        let header = UINib(nibName: "CustomHeaderView", bundle: Bundle.main)
        tableView.register(header, forHeaderFooterViewReuseIdentifier: "header")
    }

    private func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let slideCell = UINib(nibName: "SliderCell", bundle: Bundle.main)
        collectionView.register(slideCell, forCellWithReuseIdentifier: "SliderCell")
    }

    private func customNavigationBar() {
        title = "Eatery Tour"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1602264941, green: 0.4939214587, blue: 0.4291425645, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = viewModel.getSectionType(section: indexPath.section)
        switch sectionType {
        case .trending:
            guard let trendingCell = tableView.dequeueReusableCell(withIdentifier: "trendingCell", for: indexPath) as? TrendingTableViewCell else { return UITableViewCell() }
            return trendingCell
        case .category:
            guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
            return categoryCell
        }
    }

    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CustomHeaderView else { return UIView() }
        let type = viewModel.getSectionType(section: section)
        header.viewModel = viewModel.getConfigSection(sectionType: type)
        return header
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
        return viewModel.imageList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let slideCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as? SliderCell else { return UICollectionViewCell() }
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
