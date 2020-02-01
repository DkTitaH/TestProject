//
//  MostEmailedTableViewController.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

class MostEmailedView: ViewTable {
    
    let requestService: APIService
    
    init(requestService: AlamofireAPIServiceType) {
        self.requestService = AlamofireAPIService(decoder: .init())
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let url = URL(string:
//            "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json?api-key=4k0JjvtCm6LmqWCXaWgC9X2Ej2tfcG7j")
////        "https://api.nytimes.com/svc/mostpopular/v2/emailed/{period}.json"
        
        self.requestService.getViewedArticles{ result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }

//        self.requestService.
//        let task = url.map { url in
//            self.requestService.requestData(
//                url: url,
//                method: .get,
//                headers: nil,
//                completion: { result in
//                    switch result {
//                    case let .success(data):
//                        let res = try? JSONDecoder().decode(EmailedModel.self, from: data)
//                        print(res?.numResults)
//                    case let .failure(error):
//                        print(error)
//                    }
//                }
//            )
//        }
    }
}

