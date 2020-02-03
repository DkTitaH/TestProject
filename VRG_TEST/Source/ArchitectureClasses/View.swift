//
//  View.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class View<ViewModelType, Configurator, Events: EventsType>: UIViewController
    where ViewModelType: ViewModel<Configurator, Events>, Configurator: ConfiguratorType
{
    
    private let viewModel: ViewModelType
    
    let disposeBag = DisposeBag()
    
    init(viewModel: ViewModelType, nibName: String? = nil, bundle: Bundle? = nil) {
        self.viewModel = viewModel
        
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fill(viewModel: self.viewModel)
    }
    
    open func fill(viewModel: ViewModelType) {
        
    }
}

class TableView<ViewModelType, Cell: UITableViewCell, Configurator, Events: EventsType>: UITableViewController
    where ViewModelType: ViewModel<Configurator, Events>, Configurator: ConfiguratorType
{
    private let viewModel: ViewModelType
    
    init(viewModel: ViewModelType, bundle: Bundle? = nil) {
        self.viewModel = viewModel
        
        super.init(nibName: "\(type(of: self))", bundle: bundle)
        
        let cellType = Cell.self
        self.tableView.register(cellType, forCellReuseIdentifier: "\(cellType)")
//        self.tableView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareBindings(viewModel: self.viewModel)
    }
    
    open func prepareBindings(viewModel: ViewModelType) {
        
    }
}
