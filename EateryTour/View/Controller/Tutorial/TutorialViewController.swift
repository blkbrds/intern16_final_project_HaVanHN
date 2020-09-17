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
    @IBOutlet private weak var view1: UIView!
    @IBOutlet private weak var view2: UIView!
    @IBOutlet private weak var view3: UIView!
    
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
        if scrollView.contentOffset.x < width {
            pageControl.currentPage = 0
        } else if scrollView.contentOffset.x < width * 2 && scrollView.contentOffset.x >= width {
            pageControl.currentPage = 1
        } else {
            pageControl.currentPage = 2
        }
    }
}
