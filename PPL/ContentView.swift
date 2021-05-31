//
//  ContentView.swift
//  PPL
//
//  Created by Chandler Mathews on 5/20/21.
//

import SwiftUI

enum Flavor: String, CaseIterable, Identifiable {
    case choc
    case vani
    case stra
    
    var id: String { self.rawValue }
}



struct ContentView: View {
    @State private var selectedFlavor = Flavor.choc
    @State private var selectedIndex: Int = 0
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .blue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .normal)
    }
    
    var body: some View {
        //Text("Hello, Chandler!")
        let spacing: CGFloat = 16
        let widthOfHiddenCards: CGFloat = 32 /// UIScreen.main.bounds.width - 10
        let cardHeight: CGFloat = 279
        
        let items = [
            Card(id: 0, name: "Push"),
            Card(id: 1, name: "Pull"),
            Card(id: 2, name: "Legs"),
        ]
        
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
                            .font(.system(size: 100))
                    }
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .shadow(color: Color("shadow1"), radius: 4, x: 0, y: 4)
                    .transition(AnyTransition.slide)
                    .animation(.spring())
                }
            }
            .environmentObject(UIStateModel())
            Spacer()
        }
        .ignoresSafeArea()
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight+20)
        .background(Color.blue)
        
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
