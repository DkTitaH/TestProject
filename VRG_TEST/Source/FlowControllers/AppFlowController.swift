//
//  AppFlowController.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum AppFlowControllerEvents: EventsType {
    
}

class AppFlowController: FlowController<AppFlowControllerEvents> {
    
    private weak var tabBarView: UITabBarController?
    
    let requestService: APIServiceType
    let storageService: StorageService
    
    init(requestService: APIServiceType, storageService: StorageService) {
        self.requestService = requestService
        self.storageService = storageService
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarView?.configureTabBar { tab in
            tab.barStyle = .black
            tab.tintColor = .white
        }
    }
    
    override func start() {
        let controller = ArticlesTabBarViewController(viewTabs: self.tabs())
        
        self.push(viewController: controller)
        self.tabBarView = controller
    }
    
    private func tabs() -> [ViewTab] {
        let requestService = self.requestService
        
        let mostEmailedView = ViewTab(
            title: "Most Emailed",
            controller: self.articleViewController(
                model: EmailedArticles.empty,
                requestService: requestService)
            )
        
        
        let mostSharedView = ViewTab(
            title: "Most Shared",
            controller: self.articleViewController(
                model: SharedArticles.empty,
                requestService: requestService)
            )
        
        
        let mostViewedView = ViewTab(
            title: "Most Viewed",
            controller: self.articleViewController(
                model: ViewedArticles.empty,
                requestService: requestService)
            )
        
        let favoritesView = ViewTab(title: "Favorites", controller: self.favoritesView())
        
        return [mostEmailedView, mostSharedView, mostViewedView, favoritesView]
    }
    
    private func articleViewController<ModelType: ArticlesModelType>(
        model: ModelType,
        requestService: APIServiceType
    )
        -> UIViewController
    {
        let configurator = ArticleViewModelConfigurator(model: BehaviorRelay<ModelType>(value: model), requestService: requestService)

        let viewModel = ArticleViewModel(configurator: configurator)

        viewModel
            .events
            .bind { [weak self] event in
                self?.handle(event: event)
            }
            .disposed(by: self.disposeBag)

        return ArticleView(viewModel: viewModel)
    }

    private func handle(event: ArticleViewEvents) {
        switch event {
        case let .showArticleDetailView(model):
            self.showArticleDetailView(model: model)
        default:
            break
        }
    }
    
    private func favoritesView() -> UIViewController {
        let configurator = FavoritesViewModelConfigurator(storageService: self.storageService)
        let viewModel = FavoritesViewModel(configurator: configurator)
        
        viewModel
            .events
            .bind { [weak self] event in
                self?.handle(event:  event)
            }.disposed(by: self.disposeBag)
        
        return FavoritesView(viewModel: viewModel)
    }
    
    private func handle(event: FavoritesViewEvents) {
        switch event {
        case .updateModel:
            break
        case let .showArticleDetailView(model):
            self.showArticleDetailView(model: model)
        case .deleteAll:
            break
        }
    }
    
    private func showArticleDetailView(model: ArticleModelType) {
        let configurator = ArticleDetailViewModelConfigurator(model: model, storageService: self.storageService)
        let viewModel = ArticleDetailViewModel(configurator: configurator)
        let view = ArticleDetailView(viewModel: viewModel)
        
        self.push(viewController: view)
    }
}
