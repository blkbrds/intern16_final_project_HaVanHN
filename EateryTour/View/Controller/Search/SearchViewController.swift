//
//  SearchViewController.swift
//  EateryTour
//
//  Created by NganHa on 9/9/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class SearchViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: TableView!

    // MARK: - Propeties
    var viewModel = SearchViewModel()
    //var searchString: String = ""

    // MARK: - Initialize

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configSearchBar()
        getMoreInformationForCell()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //statusBarStyle = .lightContent
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Override functions

    // MARK: - Private functions
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "SearchCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "SearchCell")
    }

    private func configSearchBar() {
        searchBar.delegate = self
    }

    private func getSearchingList(searhKey: String) {
        viewModel.getRestaurantsForSearching(queryString: searhKey) { (result) in
            switch result {
            case .success:
                self.tableView.reloadData()
            case .failure(let error):
                self.alert(msg: error.localizedDescription, handler: nil)
            }
        }
    }

    private func getMoreInformationForCell() {
        for cell in tableView.visibleCells {
            if let cell = cell as? SearchCell {
                cell.getMoreInformationForCell()
            }
        }
    }

    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions
}

// MARK: -
extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getCellForRowAt(atIndexPath: indexPath)
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.restaurants = []
        getSearchingList(searhKey: searchText)
    }
}
