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
    var viewModel: DetailViewModel? {
        didSet {
            getInformationForDetail()
        }
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configBackButton()
        configStatusBar()
        getDataForPhotoCell()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }

    // MARK: - Override functions
    override func viewWillLayoutSubviews() {
        view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        view.layoutIfNeeded()
    }

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
        let commentCell = UINib(nibName: "CommentCell", bundle: Bundle.main)
        tableView.register(commentCell, forCellReuseIdentifier: "CommentCell")
    }

    private func configStatusBar() {
        navigationController?.navigationBar.barStyle = .black
    }

    private func getDataForPhotoCell() {
         guard let viewModel = viewModel else { return }
        viewModel.getDataForCellPhoto { (result) in
            switch result {
            case .success:
                self.tableView.reloadData()
            case .failure(let err):
                self.alert(msg: err.localizedDescription, handler: nil)
            }
        }
    }

    private func configBackButton() {
        backButton.tintColor = .white
    }

    private func getInformationForDetail() {
        HUD.show()
        viewModel?.getInformation(completion: { result in
            HUD.popActivity()
            switch result {
            case .success:
                self.tableView.reloadData()
            case .failure(let error):
                self.alert(msg: error.localizedDescription, handler: nil)
            }
        })
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
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                guard let viewModel = viewModel else { return 2 }
        return viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let viewModel = viewModel else { return UITableViewCell() }
        switch viewModel.sectionType(atSection: indexPath.section) {
        case .information:
            guard let informationCell = tableView.dequeueReusableCell(withIdentifier: "InformationCell", for: indexPath) as? InformationCell else { return UITableViewCell() }
            informationCell.viewModel = viewModel.getCellForRowAtInformationSection(atIndexPath: indexPath)
            informationCell.delegate = self
            return informationCell
        case .map:
            guard let mapCell = tableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath) as? MapCell else { return UITableViewCell() }
            mapCell.viewModel = viewModel.getCellForRowAtMapSection(atIndexPath: indexPath)
            mapCell.delegate = self
            return mapCell
        case .photo:
            guard let photoCell = tableView.dequeueReusableCell(withIdentifier: "PhotoCollectionCell", for: indexPath) as? PhotoCollectionCell else { return UITableViewCell() }
            photoCell.viewModel = viewModel.getCellForRowAtPhotoSection(atIndexPath: indexPath)
            return photoCell
        case .comment:
            guard let commentCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell else { return UITableViewCell() }
            commentCell.viewModel = viewModel.getCellForRowAtCommentSection(atIndexPath: indexPath)
            return commentCell
        }
    }
}

// MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         guard let viewModel = viewModel else { return 200 }
        return viewModel.getheightForRowAt(atIndexPath: indexPath)
    }
}

// MARK: - MapCellDelegate
extension DetailViewController: MapCellDelegate {

    func view(_ view: MapCell, needsPerform action: MapCell.Action) {
        switch action {
        case .pushToMapDetail(lat: let lat, lng: let lng):
            let mapDetailVC = MapDetailViewController()
            mapDetailVC.viewModel = MapDetailViewModel(lat: lat, lng: lng)
            navigationController?.pushViewController(mapDetailVC, animated: true)
        }
    }
}

// MARK: - InformationCellDelegate
extension DetailViewController: InformationCellDelegate {

    func cell(_ cell: InformationCell, needsPerform action: InformationCell.Action) {
        switch action {
        case .saveDataIntoRealm:
             guard let viewModel = viewModel else { return }
            viewModel.addDetailIntoRealm { (result) in
                switch result {
                case .success:
                    print("hihi")
                case .failure:
                    print("huhu")
                }
            }
        }
    }
}
