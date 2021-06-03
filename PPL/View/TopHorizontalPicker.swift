//
//  TopHorizontalPicker.swift
//  PPL
//
//  Created by Chandler Mathews on 6/2/21.
//

import SwiftUI

struct TopHorizontalPicker: View {
    let spacing: CGFloat = 16
    let widthOfHiddenCards: CGFloat = 100 /// UIScreen.main.bounds.width - 10
    let cardHeight: CGFloat = 279
    
    let items = [
        Card(id: 0, name: "Push"),
        Card(id: 1, name: "Pull"),
        Card(id: 2, name: "Legs"),
    ]
    var body: some View {
        VStack {
            Carousel(
                numberOfItems: CGFloat(items.count),
                spacing: spacing,
                widthOfHiddenCards: widthOfHiddenCards
            ) {
                ForEach(items, id: \.self.id) { item in
                    Item(
                        _id: Int(item.id),
                        spacing: spacing,
                        widthOfHiddenCards: widthOfHiddenCards,
                        cardHeight: cardHeight
                    ) {
                        Text("\(item.name)")
                            .font(.system(size: 80))
                    }
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .shadow(color: Color("shadow1"), radius: 4, x: 0, y: 4)
                    .transition(AnyTransition.slide)
                    .animation(.spring())
                }
            }
        }
        .ignoresSafeArea()
        .frame(width: UIScreen.screenWidth)
        .background(Color.blue)
        .cornerRadius(30)
    }
}
