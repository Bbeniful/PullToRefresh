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
    
    func getData() async {
        do {
            print("loading statu getdata: \(isLoading)")
            try await loadData()
        } catch {
            print("Error happened", error)
        }
    }
    
    
    func loadData() async throws{
        setLoading(true)
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        self.setLoading(false)
        DispatchSerialQueue.main.async { [weak self] in
            print("loading statue loaddata: \(self?.isLoading)")

            print("loading statue loaddata: \(self?.isLoading)")

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
    
    private func setLoading(_ value: Bool) {
        DispatchSerialQueue.main.async { [weak self] in
            self?.isLoading = value
        }
            
        
    }
   
}
