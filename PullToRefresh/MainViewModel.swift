//
//  MainViewModel.swift
//  PullToRefresh
//
//  Created by Benjámin Szilágyi on 28/03/2024.
//

import Foundation

class MainViewModel: ObservableObject{
    
    @Published var data: [String] = []
    @Published var isLoading: Bool = false
    
    init(data: [String] = [], isLoading: Bool = false) {
        self.data = data
        self.isLoading = isLoading
        
    }
    
    func getData() async {
        do {
            print("loading statu getdata: \(isLoading)")
            try await loadData(delay:5_000_000_000)
        } catch {
            print("Error happened", error)
        }
    }
    
    func testLoading() {
        Task {
            self.isLoading = true
            print("Show Progress: \(self.isLoading ? "True" : "False")")
            try await Task.sleep(nanoseconds: 5_000_000_000)
            self.isLoading = false
            print("Show Progress: \(self.isLoading ? "True" : "False")")
        }
    }
    
    
    func loadData(delay second: UInt64) async throws{
        testLoading()
        try? await Task.sleep(nanoseconds: second)
        DispatchQueue.main.async {
            self.data = self.createData()

        }
    }
    
    private func createData() -> [String] {
        var tmpArray : [String] = []
        for index in 0...self.data.count + 2 {
            tmpArray.append("Item \(index)")
        }
        return tmpArray
    }
    
    private func setLoading(_ value: Bool) {
        DispatchSerialQueue.main.async { [weak self] in
            //self?.isLoading = value
        }
            
        
    }
   
}
