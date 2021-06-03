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
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
    }
    
    var body: some View {
        
        // Full Screen Stack
        TabView {
            
            //First Tab
            HomeScreen()
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
        .accentColor(.black)
        
    }
}

// Size
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UIStateModel())
    }
}
