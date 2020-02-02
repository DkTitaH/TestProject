//
//  MostViewedView.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit

class MostViewedView: View<MostViewedViewModel, MostViewedViewModelConfigurator, MostViewedViewEvents>, UITableViewDataSource {

    @IBOutlet var tableView: UITableView?
    
    private var model: ViewedModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.dataSource = self
    }
    
    override func fill(viewModel: MostViewedViewModel) {
        viewModel
            .viewedModel
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
                model.do { viewModel.eventHandler.onNext(.showViewedArticleDetailView($0)) }
                
            }.disposed(by: self.disposeBag)
        
        viewModel.eventHandler.onNext(.getViewedModel)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = self.model?.results[indexPath.row]
        let cell = UITableViewCell()
        
        cell.textLabel?.text = article?.title
        cell.detailTextLabel?.text = article?.publishedDate
        
        return cell
    }
}
