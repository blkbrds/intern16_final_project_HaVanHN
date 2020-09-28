//
//  DetailViewController.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class DetailViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: TableView!

    // MARK: - Propeties
    private var viewModel = DetailViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Override functions

    // MARK: - Private functions
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let informationCell = UINib(nibName: "InformationCell", bundle: Bundle.main)
        tableView.register(informationCell, forCellReuseIdentifier: "InformationCell")
        let mapCell = UINib(nibName: "MapCell", bundle: Bundle.main)
        tableView.register(mapCell, forCellReuseIdentifier: "MapCell")
        let photoCell = UINib(nibName: "PhotoCollectionCell", bundle: Bundle.main)
        tableView.register(photoCell, forCellReuseIdentifier: "PhotoCollectionCell")
    }
    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions

}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.sectionType(atSection: indexPath.section) {
        case .information:
            guard let informationCell = tableView.dequeueReusableCell(withIdentifier: "InformationCell", for: indexPath) as? InformationCell else { return UITableViewCell() }
            informationCell.viewModel = viewModel.getCellForRowAtInformationSection(atIndexPath: indexPath)
            return informationCell
        case .map:
            guard let mapCell = tableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath) as? MapCell else { return UITableViewCell() }
            mapCell.viewModel = viewModel.getCellForRowAtMapSection(atIndexPath: indexPath)
            return mapCell
        case .photo:
            guard let photoCell = tableView.dequeueReusableCell(withIdentifier: "PhotoCollectionCell", for: indexPath) as? PhotoCollectionCell else { return UITableViewCell() }
            photoCell.viewModel = viewModel.getCellForRowAtPhotoSection(atIndexPath: indexPath)
            return photoCell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    
}
