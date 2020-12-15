//
//  ContentView.swift
//  NetworkingCombine
//
//  Created by Balraj Verma on 11/30/20.
//

import SwiftUI
import Alamofire
import Combine

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    func subscribeEvent() {
        viewModel.apiNetworkActivitySubscriber = viewModel.Event
            .sink(receiveCompletion: { completion in
                print("Completion from passthrough====", completion)
                
            }, receiveValue: { value in
                print("Value from passthrough====",value)
            })
    }
        
    var body: some View {
        HStack(spacing: 60) {
            Text("Call API using SSL pinning")
                .onAppear( perform: {
                    self.subscribeEvent()
                }
                )
                .font(.headline)
                .padding()
                .onTapGesture(count: 1, perform: {
                    print("Calling API")
                    self.viewModel.fetchData(mTLS: false)
                })
            
            Text("Call API using mTLS")
                .onAppear( perform: {
                    self.subscribeEvent()
                }
                )
                .font(.headline)
                .padding()
                .onTapGesture(count: 1, perform: {
                    print("Calling API")
                    self.viewModel.fetchData(mTLS: true)
                })
        }
    }
}
