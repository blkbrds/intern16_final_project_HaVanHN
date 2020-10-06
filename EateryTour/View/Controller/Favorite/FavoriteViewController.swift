//
//  FavoriteViewController.swift
//  EateryTour
//
//  Created by NganHa on 9/9/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class FavoriteViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: TableView!

    // MARK: - Propeties
    private var viewModel = FavoriteViewModel()

    // MARK: - Initialize

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Override functions

    // MARK: - Private functions
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let cell = UINib(nibName: "RecommendCell", bundle: Bundle.main)
        tableView.register(cell, forCellReuseIdentifier: "FavoriteCell")
    }
    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions

}

// MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? RecommendCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getCellForRowAt(atIndexPath: indexPath)
        return cell
    }
}
