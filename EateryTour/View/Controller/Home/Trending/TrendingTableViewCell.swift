//
//  TrendingTableViewCell.swift
//  EateryTour
//
//  Created by NganHa on 9/10/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class TrendingTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Propeties

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
        collectionView.delegate = self
        collectionView.dataSource = self
        let restauRantCell = UINib(nibName: "RestaurantCell", bundle: Bundle.main)
        collectionView.register(restauRantCell, forCellWithReuseIdentifier: "RestaurantCell")
    }
    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TrendingTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2.5 - 10, height: 240)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12)
    }
}

// MARK: - UICollectionViewDataSource
extension TrendingTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let restaurantCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCell else { return UICollectionViewCell() }
        return restaurantCell
    }
}
