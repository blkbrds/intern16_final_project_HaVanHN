//
//  TutorialViewController.swift
//  EateryTour
//
//  Created by Khoa Vo T.A. on 9/7/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import UIKit

final class TutorialViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var containView: UIView!
    @IBOutlet private weak var scrollView: ScrollView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var getStartedButton: Button!
    @IBOutlet private weak var tutorial01ImageView: ImageView!
    @IBOutlet private weak var tutorial02ImageView: ImageView!
    @IBOutlet private weak var tutorial03ImageView: ImageView!
    @IBOutlet private weak var title01Label: Label!
    @IBOutlet private weak var title02Label: Label!
    @IBOutlet private weak var title03Label: Label!
    @IBOutlet private weak var description01Label: Label!
    @IBOutlet private weak var description02Label: Label!
    @IBOutlet private weak var description03Label: Label!

    // MARK: - Propeties
    private var width = UIScreen.main.bounds.width

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configScrollView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarStyle = .lightContent
    }

    // MARK: - Private functions
    private func configUI() {
        getStartedButton.layer.cornerRadius = 10
    }

    private func configScrollView() {
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
    }

    private func configFirstUse() {
        ud.set(true, forKey: UserDefaultKeys.secondUse)
    }

    // MARK: - IBActions
    @IBAction private func getStartedButtonTouchUpInside(_ sender: Button) {
    }
}

// MARK: - UIScrollViewDelegate
extension TutorialViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / width
        pageControl.currentPage = Int(round(pageIndex))
        let offsetX = scrollView.contentOffset.x
        tutorial01ImageView.alpha = 1 - (offsetX / width)
        title01Label.alpha = 1 - (offsetX / width)
        description01Label.alpha = 1 - (offsetX / width)
        tutorial03ImageView.alpha = (offsetX - width) / width
        title03Label.alpha = (offsetX - width) / width
        description03Label.alpha = (offsetX - width) / width
        if offsetX <= width {
            tutorial02ImageView.alpha = offsetX / width
            title02Label.alpha = offsetX / width
            description02Label.alpha = offsetX / width
        } else {
            tutorial02ImageView.alpha = 1 - (offsetX - width) / width
            title02Label.alpha = 1 - (offsetX - width) / width
            description02Label.alpha = 1 - (offsetX - width) / width
        }
    }
}
