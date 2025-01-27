//
//  MatchesCardView.swift
//  MatchMate
//
//  Created by Ahmad Qureshi on 27/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct MatchesCardView: View {
    @State var isButtonPressed: Bool = false
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            WebImage(url: URL(string: "https://randomuser.me/api/portraits/med/men/83.jpg")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: screenWidth/3, height: screenWidth/3, alignment: .center)
                .padding(.top, 20)
            
            Text("Charles Baggage")
                .foregroundStyle(.blue)
                .fontWeight(.bold)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Text("56, washington, london NY near SLU, SOUTH pacific")
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
                .lineLimit(2)
            
            if isButtonPressed {
                Text("Accepted")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                    )
                
            } else {
                HStack(spacing: 50) {
                    declineButton

                    acceptButton
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 10)
            }
    
        }
        .animation(.linear, value: isButtonPressed)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .black.opacity(0.5), radius: 10)
        }
        .frame(height: 400)
    }
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var acceptButton: some View {
        Button {
            isButtonPressed = true
        } label: {
            Circle()
                .stroke(.blue, lineWidth: 2)
                .frame(width: 50, height: 50)
                .overlay {
                    Text("\u{2713}")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.blue)
                }
        }
    }
    
    var declineButton: some View {
        Button {
            isButtonPressed = true
        } label: {
            Circle()
                .stroke(.blue, lineWidth: 2)
                .frame(width: 50, height: 50)
                .overlay {
                    Text("X")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.blue)
                }
        }
    }
}

#Preview {
    MatchesCardView()
}
