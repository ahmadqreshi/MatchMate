//
//  LoaderView.swift
//  MatchMate
//
//  Created by Ahmad Qureshi on 27/01/25.
//

import SwiftUI

struct LoaderView: View {
    @State private var shouldAnimate = false
    @State var leftOffset: CGFloat = -100
    @State var rightOffset: CGFloat = 100
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue)
            .frame(width: 40, height: 10)
            .offset(x: shouldAnimate ? rightOffset : leftOffset)
            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: shouldAnimate)
            .onAppear {
                self.shouldAnimate = true
            }
    }
}

#Preview {
    LoaderView()
}
