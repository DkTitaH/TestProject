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
    
    let requestService: APIService
    
    init(requestService: APIService) {
        self.requestService = requestService
        
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
        
        let mostEmailedView = ViewTab(title: "Most Emailed", controller: self.mostEmailedView(requestService: requestService))
        let mostSharedView = ViewTab(title: "Most Shared", controller: self.mostSharedView(requestService: requestService))
        let mostViewedView = ViewTab(title: "Most Viewed", controller: self.mostViewedView(requestService: requestService))
        let favoritesView = ViewTab(title: "Favorites", controller: self.favoritesView())
        
        return [mostEmailedView, mostSharedView, mostViewedView, favoritesView]
    }
    
    private func mostEmailedView(requestService: APIService) -> UIViewController {
        let configurator = MostEmailedViewModelConfigurator(requestService: requestService)
        let viewModel = MostEmailedViewModel(configurator: configurator)
        
        viewModel
            .events
            .bind { [weak self] event in
                self?.handle(event: event)
            }
            .disposed(by: self.disposeBag)
        
        return MostEmailedView(viewModel: viewModel)
    }
    
    private func handle(event: MostEmailedViewEvents) {
        switch event {
        case let .showEmailedArticleDetailView(model):
            print("emailed article model: \(model))")
        default:
            break
        }
    }
    
    private func mostViewedView(requestService: APIService) -> UIViewController {
        let configurator = MostViewedViewModelConfigurator(requestService: requestService)
        let viewModel = MostViewedViewModel(configurator: configurator)
        
        viewModel
            .events
            .bind { [weak self] event in
                self?.handle(event: event)
            }
            .disposed(by: self.disposeBag)
        
        return MostViewedView(viewModel: viewModel)
    }
    
    private func handle(event: MostViewedViewEvents) {
        switch event {
        case let .showViewedArticleDetailView(model):
            print("viewed article model: \(model))")
        default:
            break
        }
    }
    
    private func mostSharedView(requestService: APIService) -> UIViewController {
        let configurator = MostSharedViewModelConfigurator(requestService: requestService)
        let viewModel = MostSharedViewModel(configurator: configurator)
        
        viewModel
            .events
            .bind { [weak self] event in
                self?.handle(event: event)
            }
            .disposed(by: self.disposeBag)
        
        return MostSharedView(viewModel: viewModel)
    }
    
    private func handle(event: MostSharedViewEvents) {
        switch event {
        case let .showSharedArticleDetailView(model):
            print("shared article model: \(model))")
        default:
            break
        }
    }
    
    private func favoritesView() -> UIViewController {
        let configurator = FavoritesViewModelConfigurator(requestService: self.requestService)
        let viewModel = FavoritesViewModel(configurator: configurator)
        
        
        return FavoritesView(viewModel: viewModel)
    }
}

extension UITabBarController {
    
    func configureTabBar(_ action: @escaping (UITabBar) -> ())  {
        return action(self.tabBar)
    }
}
