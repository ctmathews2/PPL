//
//  ContentView.swift
//  PPL
//
//  Created by Chandler Mathews on 5/20/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var UIState: UIStateModel
    
    init() {
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage     = UIImage()
        UITabBar.appearance().clipsToBounds   = true
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }
    
    var body: some View {
        
        // Full Screen Stack
        TabView {
            
            //First Tab
            ZStack {
                Color.gray
                    .ignoresSafeArea()
                VStack {
                    TopHorizontalPicker()
                    Spacer()
                    HomeListText(listIndex: UIState.activeCard)
                    Spacer()
                    Button("Start"){
                        
                    }
                    .frame(width: UIScreen.screenWidth / 1.5, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.blue)
                    .cornerRadius(20)
                    
                    Spacer()
                    Spacer()
                    
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                //.background(Color.yellow)
            }
            .tabItem({
                Image(systemName: "circle")
                Text("First")
            })
            .tag(0)
            
            //Second Tab
            Text("Second View")
                .font(.title)
                .tabItem({
                    Image(systemName: "square")
                    Text("Second")
                })
                .tag(1)
            
        }
        .accentColor(.white)
        
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UIStateModel())
    }
}


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

struct HomeListText : View {
    var listIndex : Int
    let repList: String =
        """
        3 x 10\n
        3 x 10\n
        3 x 10\n
        3 x 10\n
        3 x 10\n
        """
    var liftTextDict : [Int : String] = [
        0 : """
        Bench Press:\n
        Incline Press:\n
        Shoulder Press:\n
        Tricep Extensions:\n
        Tricep Pulldown:\n
        """,
        1 : """
        Pull Ups:\n
        Barbell Row:\n
        Dumbbell Fly:\n
        Bicep Curl:\n
        Hammer Curl:\n
        """,
        2 : """
        Squat:\n
        Deadlift:\n
        Leg Press:\n
        Hamstring curl:\n
        Quad Extensions:\n
        """
    ]
    
    var body: some View {
        HStack {
            Text(liftTextDict[listIndex]!)
                .fontWeight(.bold)
                .foregroundColor(.white)
                //.multilineTextAlignment(.trailing)
                .font(.system(size: 28))
            Spacer()
            Text(repList)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.system(size: 28))
        }
        .padding(.horizontal, 20)
    }
}
