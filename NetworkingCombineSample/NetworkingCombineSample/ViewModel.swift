//
//  ViewModel.swift
//  NetworkingCombineSample
//
//  Created by Balraj Verma on 12/11/20.
//  Copyright © 2020 Balraj Verma. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class ViewModel: ObservableObject {
    var subscriber: AnyCancellable?
    var Event = PassthroughSubject<String, Never>()
    var apiNetworkActivitySubscriber: AnyCancellable?
    
    init() {
        print("Blank Init")
    }

    
    //CallAPi can have a codable type T: codable/decaodeable data which might be result of any json parsed API
    func fetchData(mTLS: Bool) {
        subscriber = Network().doNetworkAgainWithSSLPinning(mTLS: mTLS)
       // Event
                .sink(receiveCompletion: { completion in
                print(completion)
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("------>",error)
                   // fatalError(error.localizedDescription)
                }
            }, receiveValue: { data in
                print("--JSON VALUES-->",data)
                self.Event.send("5")
            })
    }
    
}
