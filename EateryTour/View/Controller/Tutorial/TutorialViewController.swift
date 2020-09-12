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

    // MARK: - Propeties
    private var width = UIScreen.main.bounds.width

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configScrollView()
        configSecondUse()
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
    }

    private func configSecondUse() {
        UserDefaults.standard.set(true, forKey: "secondUse")
    }

    // MARK: - IBActions
    @IBAction private func getStartedButtonTouchUpInside(_ sender: Button) {
        AppDelegate.shared.changeRoot(rootType: .tabbar)
    }
}

// MARK: - UIScrollViewDelegate
extension TutorialViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x < width && scrollView.contentOffset.x >= 0 {
            pageControl.currentPage = 0
        } else if scrollView.contentOffset.x < width * 2 && scrollView.contentOffset.x >= width {
            pageControl.currentPage = 1
        } else {
            pageControl.currentPage = 2
        }
    }
}
