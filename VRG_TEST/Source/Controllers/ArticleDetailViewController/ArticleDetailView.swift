//
//  ArticleDetailView.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 02.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit

class ArticleDetailView: View<ArticleDetailViewModel, ArticleDetailViewModelConfigurator, ArticleDetailViewEvents> {

    @IBOutlet var sourceLabel: UILabel?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var countLabel: UILabel?
    @IBOutlet var publishedDateLabel: UILabel?
    @IBOutlet var abstractLabel: UILabel?
    @IBOutlet var keywordLabel: UILabel?
    
    override func fill(viewModel: ArticleDetailViewModel) {
        self.fill(model: viewModel.model)
        self.configureNavigationBarItem(viewModel: viewModel)
    }
    
    private func fill(model: ArticleModelType) {
        self.sourceLabel?.text = model.source
        self.titleLabel?.text = model.title
        self.countLabel?.text = "\(model.countType): \(model.count)"
        self.publishedDateLabel?.text = model.publishedDate
        self.abstractLabel?.text = model.abstract
        self.keywordLabel?.text = model.adxKeywords
    }
    
    private func configureNavigationBarItem(viewModel: ArticleDetailViewModel) {
        let item = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
        
        item
            .rx
            .tap
            .map {
                ArticleDetailViewEvents.addToFavorites
            }
            .subscribe(viewModel.eventHandler)
            .disposed(by: self.disposeBag)
        
        self.navigationItem.rightBarButtonItem = item
    }
}
