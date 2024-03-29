//
//  MainViewModel.swift
//  PullToRefresh
//
//  Created by Benjámin Szilágyi on 28/03/2024.
//

import Foundation

class MainViewModel: ObservableObject{
    
    @Published var data: [String] = []
    
    func getData() async {
        do {
            try await loadData()
        } catch {
            print("Error happened", error)
        }
    }
    
    
    func loadData() async throws{
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        DispatchSerialQueue.main.async { [weak self] in
            self?.data = self!.createData()
        }
       
    }
    
    private func createData() -> [String] {
        var tmpArray : [String] = []
        for index in 0...self.data.count + 2 {
            tmpArray.append("Item \(index)")
        }
        return tmpArray
    }
   
}
