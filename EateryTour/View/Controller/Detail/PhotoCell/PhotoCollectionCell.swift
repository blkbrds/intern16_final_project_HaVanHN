//
//  PhotoCell.swift
//  EateryTour
//
//  Created by NganHa on 9/27/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class PhotoCollectionCell: TableCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: CollectionView!

    // MARK: - Propeties
    var viewModel: PhotoCollectionCellViewModel? {
        didSet {
            self.collectionView.reloadData()
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
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "PhotoCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: "PhotoCell")
    }

    private func updateUI() {

    }
    // MARK: - Public functions

    // MARK: - Objc functions

    // MARK: - IBActions
}

// MARK: - UICollectionViewDataSource
extension PhotoCollectionCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 10 }
        return viewModel.numberOfItemInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel?.getCellForRowAt(atIndexPath: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotoCollectionCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
