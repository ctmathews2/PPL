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
        
        VStack {
            CustomPickerView(selectedIndex: $selectedIndex)
                        .background(Rectangle().fill(Color(white: 0.75)))
            Picker(selection: $selectedFlavor, label: Text("Data")){
                VStack(spacing: 50){
                    Text("Push").tag(Flavor.choc)
                        .rotationEffect(Angle(degrees: 270))
                        //.font(.system(size: 80))
                    Text("Pull").tag(Flavor.vani)
                        .rotationEffect(Angle(degrees: 270))
                    Text("Legs").tag(Flavor.stra)
                        .rotationEffect(Angle(degrees: 270))
                }
            }
            .labelsHidden()
            .rotationEffect(Angle(degrees: 90))
            .frame(height: 400)
            .clipped()
            
            Text("Selected: \(selectedFlavor.rawValue)")
        }
        .ignoresSafeArea()
        .background(Color.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
