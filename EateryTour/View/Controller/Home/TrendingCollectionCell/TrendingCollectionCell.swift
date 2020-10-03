//
//  TrendingCollectionCellTableViewCell.swift
//  EateryTour
//
//  Created by NganHa on 10/1/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

class TrendingCollectionCell: TableCell {

    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: CollectionView!

    // MARK: - Propeties
    var viewModel = TrendingCollectionCellViewModel() {
        didSet {
            getMoreInformationForCell()
            collectionView.reloadData()
            getMoreInformationForCell()
        }
    }
    // MARK: - Initialize

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }

    // MARK: - Override functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Private functions
    private func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let trendingCell = UINib(nibName: "TrendingCell", bundle: Bundle.main)
        collectionView.register(trendingCell, forCellWithReuseIdentifier: "TrendingCell")
    }

    private func getMoreInformationForCell() {
        for cell in  collectionView.visibleCells {
            if let cell = cell as? TrendingCell {
                cell.getInformation { (result) in
                    switch result {
                    case .success:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }

    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions

}

// MARK: - UICollectionViewDelegateFlowLayout
extension TrendingCollectionCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 260)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

// MARK: - UIScrollViewDelegate
extension TrendingCollectionCell: UIScrollViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            getMoreInformationForCell()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        getMoreInformationForCell()
    }
}

// MARK: - UICollectionViewDataSource
extension TrendingCollectionCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //guard let viewModel = viewModel else { return 10 }
        return viewModel.numberOfRowInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //guard let viewModel = viewModel else { return UICollectionViewCell() }
        guard let trendingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCell", for: indexPath) as? TrendingCell else { return CollectionCell() }
        trendingCell.viewModel = viewModel.getCellForRowAt(atIndexPath: indexPath)
        trendingCell.delegate = self
        return trendingCell
    }
}

// MARK: - TrendingCellDelegate
extension TrendingCollectionCell: TrendingCellDelegate {

    func cell(_ cell: TrendingCell, needsPerform action: TrendingCell.Action) {
        switch action {
        case .callApiSuccess(restaurant: let restaurant):
            viewModel.updateApiSuccess(newRestaurant: restaurant)
        }
    }
}