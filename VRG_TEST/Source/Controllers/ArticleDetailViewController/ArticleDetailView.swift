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


fileprivate struct Constants {
    
    static let removedMessage = "Article was removed from favorites"
    static let savedMessage = "Article was saved to favorites"
}

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
        let (event, item, allertText) = viewModel.model is DefaultArticleModel
            ? (
                ArticleDetailViewEvents.deleteFromeFavorites,
                UIBarButtonItem.SystemItem.trash,
                Constants.removedMessage
            )
            : (
                .addToFavorites,
                .save,
                Constants.savedMessage
            )
        
        self.addRightNavigationItem(viewModel: viewModel, with: event, type: item, allertText: allertText, disposeBag: disposeBag)
    }
    
    private func addRightNavigationItem(
        viewModel: ArticleDetailViewModel,
        with event: ArticleDetailViewEvents,
        type: UIBarButtonItem.SystemItem,
        allertText: String,
        disposeBag: DisposeBag
    ) {
        
        let item = UIBarButtonItem(barButtonSystemItem: type, target: self, action: nil)
        
        item
            .rx
            .tap
            .observeOn(MainScheduler.asyncInstance)
            .map { [weak self] in
                self?.showAlertViewController(text: allertText)
                
                return event
            }
            .subscribe(viewModel.eventHandler)
            .disposed(by: disposeBag)
        
        self.navigationItem.rightBarButtonItem = item
    }
    
    private func itemAction(text: String) {
        self.showAlertViewController(text: text)
    }
    
    private func showAlertViewController(text: String) { // need keep out to Flow controller
        let allert = UIAlertController(title: "", message: text, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel) { _ in
            self.navigationItem.rightBarButtonItem = nil
        }
        
        allert.addAction(action)
        
        self.present(allert, animated: false)
    }
}
