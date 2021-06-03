//
//  HomeScreen.swift
//  PPL
//
//  Created by Chandler Mathews on 6/2/21.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var UIState: UIStateModel
    
    var body: some View {

        NavigationView {
            ZStack {
                Color.gray
                    .ignoresSafeArea()
                VStack {
                    TopHorizontalPicker()
                    Spacer()
                    HomeListText(listIndex: UIState.activeCard)
                    Spacer()
                    NavigationLink(destination: WorkoutScreen()) {
                        Text("Go Next")
                            .frame(width: UIScreen.screenWidth / 1.5, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                    Spacer()
                    Spacer()
                    
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                //.background(Color.yellow)
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(UIStateModel())
    }
}
