//
//  ContentView.swift
//  PullToRefresh
//
//  Created by Benjámin Szilágyi on 28/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        VStack {
            List($viewModel.data, id: \.self) { index in
                HStack(alignment: .top){
                    VStack(alignment: .leading){
                        Text("Hi im the title")
                            .font(.system(size: 18))
                        Text("sub title")
                            .font(.system(size: 14))
                        Text("sub title")
                            .font(.system(size: 14))
                        Text("sub title")
                            .font(.system(size: 14))
                            .padding(.top, 2)
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    Spacer()
                    Button("Hello") {
                        print("button has pressed")
                    }.foregroundColor(.white) // This line is redundant and can be removed
                        .padding() // Add padding to ensure there's enough space for the text
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.white, lineWidth: 2)
                                .background(Color.gray)
                        )
                        .frame(height: 25)
                        .cornerRadius(25)
                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            }
            .refreshable{
                print("Im refreshing")
                await viewModel.getData()
            }
            Spacer()
        }
        
    }
}

#Preview {
    ContentView()
}
