//
//  ArticleView.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 03.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArticleView<Model>: View<ArticleViewModel<Model>, ArticleViewModelConfigurator<Model>, ArticleViewEvents>, UITableViewDataSource
    where Model: ArticlesModelType
{
    @IBOutlet var tableView: UITableView?
    
    private var model: Model?
    
    init(viewModel: ArticleViewModel<Model>) {
        
        super.init(viewModel: viewModel, nibName: "ArticleView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.dataSource = self
    }
    
    override func fill(viewModel: ArticleViewModel<Model>) {
        viewModel
            .model
            .bind {
                self.model = $0
                
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
            .disposed(by: self.disposeBag)
        
        self.tableView?
            .rx
            .itemSelected
            .map { index in
                self.model?.results[index.row]
            }.bind { model in
                (model as? ArticleModelType)
                    .do {
                        viewModel.eventHandler.onNext(.showArticleDetailView($0))
                    }
            }.disposed(by: self.disposeBag)
        
        self.configureRefresheControl(viewModel: viewModel)
        
        viewModel.eventHandler.onNext(.updateModel)
    }
    
    func configureRefresheControl(viewModel: ArticleViewModel<Model>) {
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
            .disposed(by: self.disposeBag)
        
        self.tableView?.addSubview(refreshControl)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = self.model?.results[indexPath.row]
        let cell = UITableViewCell()
        
        (article as? ArticleModelType)
            .do {
                cell.textLabel?.text = $0.title
            }
        
        return cell
    }
}
