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

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        configTableView()
        getDataFromRealm()
        addObserve()
    }

    // MARK: - Override functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
    }

    // MARK: - Private functions
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let cell = UINib(nibName: "RecommendCell", bundle: Bundle.main)
        tableView.register(cell, forCellReuseIdentifier: "FavoriteCell")
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

    private func configNavigationBar() {
        navigationItem.title = "Favorite"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1602264941, green: 0.4939214587, blue: 0.4291425645, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let deleteItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-broken-heart"), style: .plain, target: self, action: #selector(tabOnDeleteButton))
        deleteItem.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = deleteItem
    }

    private func addObserve() {
        viewModel.setupObserver {
            self.tableView.reloadData()
        }
    }

    // MARK: - Objc functions
    @objc private func tabOnDeleteButton() {
        viewModel.deleteAllFavoriteRestaurant { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.getDataFromRealm()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

// MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
        cell.loadMoreInformation { result in
            switch result {
            case .success:
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        cell.delegate = self
        return cell
    }
}

// MARK: - RecommendCellDelegate
extension FavoriteViewController: RecommendCellDelegate {

    func cell(_ cell: RecommendCell, needsPerform action: RecommendCell.Action) {
        switch action {
        case .changeFavoriteState(id: let id):
            viewModel.deleteFavoriteRestaurant(withId: id) { result in
                print(id)
                switch result {
                case .success:
                    self.getDataFromRealm()
                case .failure(let error):
                    print(error)
                }
            }
        case .callApiSuccess(restaurant:_):
            break
        }
    }
}
