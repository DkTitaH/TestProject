//
//  ArticleDetailView.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 02.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ArticleDetailView: View<ArticleDetailViewModel, ArticleDetailViewModelConfigurator, ArticleDetailViewEvents> {

    @IBOutlet var sourceLabel: UILabel?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var countLabel: UILabel?
    @IBOutlet var publishedDateLabel: UILabel?
    @IBOutlet var abstractLabel: UILabel?
    @IBOutlet var keywordLabel: UILabel?
    
    override func fill(viewModel: ArticleDetailViewModel, disposeBag: DisposeBag) {
        self.fill(model: viewModel.model)
        self.configureNavigationBarItem(viewModel: viewModel, disposeBag: disposeBag)
    }
    
    private func fill(model: ArticleModelType) {
        self.sourceLabel?.text = model.source
        self.titleLabel?.text = model.title
        self.countLabel?.text = "\(model.countType): \(model.count)"
        self.publishedDateLabel?.text = model.publishedDate
        self.abstractLabel?.text = model.abstract
        self.keywordLabel?.text = model.adxKeywords
    }
    
    private func configureNavigationBarItem(viewModel: ArticleDetailViewModel, disposeBag: DisposeBag) {
        let (event, item) = viewModel.model is DefaultArticleModel
            ? (ArticleDetailViewEvents.deleteFromeFavorites, UIBarButtonItem.SystemItem.trash)
            : (.addToFavorites, .save)
        
        self.addRightNavigationItem(viewModel: viewModel, with: event, type: item, disposeBag: disposeBag)
    }
    
    private func addRightNavigationItem(
        viewModel: ArticleDetailViewModel,
        with event: ArticleDetailViewEvents,
        type: UIBarButtonItem.SystemItem,
        disposeBag: DisposeBag
    ) {
        
        let item = UIBarButtonItem(barButtonSystemItem: type, target: self, action: nil)
        
        item
            .rx
            .tap
            .map {
                event
            }
            .subscribe(viewModel.eventHandler)
            .disposed(by: disposeBag)
        
        self.navigationItem.rightBarButtonItem = item
    }
}
