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
            VStack {
                Text("Second View")
                    .font(.title)
                List {
                    Section(header: Text("UIKit"), footer: Text("We will miss you")) {
                        VStack {
                            HStack{
                                Text("Upper left")
                                Spacer()
                                Text("Upper right")
                            }
                            HStack{
                                Text("lower left")
                                Spacer()
                                Text("lower right")
                            }
                        }
                        Text("UITableView")
                        Text("UITableView")
                        Text("UITableView")
                    }

                    Section(header: Text("SwiftUI"), footer: Text("A lot to learn")) {
                        Text("List")
                        Text("List")
                        Text("List")
                        Text("List")
                    }
                }
            }
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
