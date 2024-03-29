//
//  ContentView.swift
//  PullToRefresh
//
//  Created by Benjámin Szilágyi on 28/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = MainViewModel()
    @State var testBool = false
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                PlaceholderLoading()
                
            } else {
                ListView(data: $viewModel.data){
                    
                    try? await viewModel.loadData(delay: 5_000_000_000)
                }
            }
        }.onAppear {
            print("loading state: \(self.testBool)")
        }
        .task {
            viewModel.testLoading()

            try? await viewModel.loadData(delay: 0)
        }
    }
    
    struct ListView: View {
        
        var data: Binding<[String]>
        var refreshCall: () async -> Void
        
        var body: some View {
            List(data, id: \.self) { index in
                ListItem()
            }
            .refreshable{
                print("Im refreshing")
                await refreshCall()
            }
            .frame( maxWidth: .infinity)
            .edgesIgnoringSafeArea(.bottom)
            .listStyle(GroupedListStyle()) // or PlainListStyle()
            Spacer()
        }
    }
}


struct PlaceholderLoading: View {
    var body: some View {
        List(1..<100) { index in
            VStack{
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
                }
                .redacted(reason: .placeholder)
                .shimmer()
            }
        }
        .frame( maxWidth: .infinity)
        .edgesIgnoringSafeArea(.bottom)
        .listStyle(GroupedListStyle())
       
    }
}

struct ListItem: View {
    var body: some View {
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
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
}

#Preview {
    //ContentView()
    //PlaceholderLoading()
    ListItem()
}
