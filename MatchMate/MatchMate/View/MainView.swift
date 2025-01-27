//
//  ContentView.swift
//  MatchMate
//
//  Created by Ahmad Qureshi on 27/01/25.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = ProfileMatchesViewModel(dataRepo: ProfileMatchesDataRepository())
    
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Profile Matches")
                .foregroundStyle(.black)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            Group {
                if viewModel.isLoading {
                    LoaderView()
                } else if !viewModel.isLoading && !viewModel.errorMessage.isEmpty {
                    Text("Error: \(viewModel.errorMessage)")
                } else {
                    ScrollView(.vertical) {
                        VStack(spacing: 0) {
                            ForEach($viewModel.userMatches, id: \.id) { data in
                                MatchesCardView(data: data)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        .onAppear {
            viewModel.fetchUserMatches()
        }
        
    }
}

#Preview {
    MainView()
}
