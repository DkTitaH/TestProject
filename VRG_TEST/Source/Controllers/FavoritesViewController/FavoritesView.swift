//
//  FavoritesView.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesView: View<FavoritesViewModel, FavoritesViewModelConfigurator, FavoritesViewEvents>, UITableViewDataSource {

    @IBOutlet var tableView: UITableView?    
    @IBOutlet var deleteAllFavoritesButton: UIButton?
    
    private var model: [ArticleModelType]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.dataSource = self
    }
    
    override func fill(viewModel: FavoritesViewModel, disposeBag: DisposeBag) {
        viewModel
            .model
            .bind {
                self.model = $0
                
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
            .disposed(by: disposeBag)
        
        self.deleteAllFavoritesButton?
            .rx
            .tap
            .map {
                FavoritesViewEvents.deleteAll
            }
            .subscribe(viewModel.eventHandler)
            .disposed(by: disposeBag)
        
        self.rx
            .viewWillAppear
            .map {
                FavoritesViewEvents.updateModel
            }
            .subscribe(viewModel.eventHandler)
            .disposed(by: disposeBag)
        
        self.tableView?
            .rx
            .itemSelected
            .map { index in
                self.model?[index.row]
            }.bind { model in
                model.do { viewModel.eventHandler.onNext(.showArticleDetailView($0)) }
            }.disposed(by: disposeBag)
        
        self.configureRefresheControl(viewModel: viewModel, disposeBag: disposeBag)
        
        viewModel.eventHandler.onNext(.updateModel)
    }
    
    func configureRefresheControl(viewModel: FavoritesViewModel, disposeBag: DisposeBag) {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .observeOn(MainScheduler.asyncInstance)
            .bind { [weak viewModel, weak refreshControl] in
                viewModel?.eventHandler.onNext(.updateModel)
                
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                    refreshControl?.endRefreshing()
                }
            }
            .disposed(by: disposeBag)
        
        self.tableView?.addSubview(refreshControl)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = self.model?[indexPath.row]
        let cell = UITableViewCell()
        
        cell.textLabel?.text = article?.title
        cell.detailTextLabel?.text = article?.publishedDate
        
        return cell
    }
}
