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
    @IBOutlet private weak var backButton: Button!

    // MARK: - Propeties
    var viewModel = DetailViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabbar()
        configTableView()
        configStatusBar()
        getDataForPhotoCell()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.layoutIfNeeded()
        backButton.tintColor = .white
    }

    // MARK: - Override functions

    // MARK: - Private functions
    private func configTabbar() {
        tabBarController?.tabBar.isHidden = true
    }

    private func configTableView() {
        let informationCell = UINib(nibName: "InformationCell", bundle: Bundle.main)
        tableView.register(informationCell, forCellReuseIdentifier: "InformationCell")
        let mapCell = UINib(nibName: "MapCell", bundle: Bundle.main)
        tableView.register(mapCell, forCellReuseIdentifier: "MapCell")
        let photoCell = UINib(nibName: "PhotoCollectionCell", bundle: Bundle.main)
        tableView.register(photoCell, forCellReuseIdentifier: "PhotoCollectionCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func configStatusBar() {
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        navigationController?.navigationBar.barStyle = .black
    }

    private func getDataForPhotoCell() {
        viewModel.getDataForCellPhoto { (result) in
            switch result {
            case .success:
                self.tableView.reloadData()
            case .failure(let err):
                self.alert(msg: err.localizedDescription, handler: nil)
            }
        }
    }
    private func configNavigationBar() {
<<<<<<< HEAD
=======

>>>>>>> feature/detail/implement_ui_screen
    }

    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions
    @IBAction private func backButtonTouchUpInside(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
    }
}

// MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getheightForRowAt(atIndexPath: indexPath)
    }
}
