//
//  MatchesCardView.swift
//  MatchMate
//
//  Created by Ahmad Qureshi on 27/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct MatchesCardView: View {
    @Binding var data: ProfileMatchesModel
    
    var status: MatchStatus {
        return MatchStatus(rawValue: data.status) ?? .pending
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            WebImage(url: URL(string: data.imageUrl)) { image in
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
            
            Text(data.name)
                .foregroundStyle(.blue)
                .fontWeight(.bold)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Text(data.address)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
                .lineLimit(2)
            
            
            switch status {
            case .accepted:
                Text("Accepted")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                    )
            case .pending:
                HStack(spacing: 50) {
                    declineButton

                    acceptButton
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 10)
            case .rejected:
                Text("Rejected")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                    )
            }
    
        }
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
            data.status = MatchStatus.accepted.rawValue
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
            data.status = MatchStatus.rejected.rawValue
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
    MatchesCardView(
        data: .constant(ProfileMatchesModel(
            id: "",
            imageUrl: "",
            name: "",
            address: "",
            status: MatchStatus.accepted.rawValue
        ))
    )
}
