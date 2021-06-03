//
//  WorkoutScreen.swift
//  PPL
//
//  Created by Chandler Mathews on 6/2/21.
//

import SwiftUI

struct Place: Identifiable, Hashable {
    let id: Int
    let name: String
    let state: String
    let city: String
}

struct PlaceView: View {
    
    let place: Place
    var body: some View {
        HStack {
            content
            Spacer()
        }
        .contentShape(Rectangle())
    }
    
    let isExpanded: Bool
    
    private var content: some View {
        VStack(alignment: .leading) {
            Text(place.name).font(.headline)
            
            if isExpanded{
                VStack(alignment: .leading) {
                    Text(place.state)
                    Text(place.city)
                }
            }
        }
    }
}

struct ListRowModifier: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            content
            Divider()
        }.offset(x: 20)
    }
}

struct PlaceListView: View {
    let places: [Place]
    @State private var selection: Set<Place> = []
    var body: some View {
        ScrollView {
            ForEach(places) { place in
                PlaceView(place: place, isExpanded: self.selection.contains(place))
                    .onTapGesture {
                        self.selectDeselect(place)
                    }
                    .modifier(ListRowModifier())
                    .animation(.easeInOut(duration: 0.3))
            }
        }
    }
    
    func selectDeselect(_ place: Place) {
        if selection.contains(place) {
            selection.remove(place)
        } else {
            selection.insert(place)
        }
    }
}

let places =
    [
        Place(id: 0, name: "Place 1", state: "Cali", city: "SF"),
        Place(id: 1, name: "Place 2", state: "Texas", city: "Dallas")
    ]

struct ExcerciseItem: Identifiable {
    var id = UUID()
    var name: String
    var setsCompleted: Int
    var setsTotal: Int
    var hello: [SetItem]? = nil
}


struct SetItem: Identifiable {
    var id = UUID()
    var name: String
}

struct testListButton: View {
    @State var isExpanded: Bool = false
    
    var body: some View {
        
        VStack {
            ZStack {
                HStack {
                    Text("Hello")
                }
                .frame(width: 100, height: 100, alignment: .center)
                .background(Color.blue)
                .offset(x: 0, y: isExpanded == false ? 0 : 100)
                .animation(.easeInOut(duration: 0.3))
                
                HStack {
                    Text("Hey There")
                    Button("Expand"){
                        isExpanded.toggle()
                    }
                }
                .frame(width: 100, height: 100, alignment: .center)
                .background(Color.red)
            }
        }
    }
}

struct WorkoutScreen: View {
    let SetItems =
        [
            SetItem(name: "Set 1"),
            SetItem(name: "Set 2"),
            SetItem(name: "Set 3")
        ]

    let ExcerciseItems =
        [
            ExcerciseItem(name: "Bench Press", setsCompleted: 0, setsTotal: 3),
            ExcerciseItem(name: "Incline Press", setsCompleted: 0, setsTotal: 3),
            ExcerciseItem(name: "Shoulder Press", setsCompleted: 0, setsTotal: 3),
            ExcerciseItem(name: "Tricep Extension", setsCompleted: 0, setsTotal: 3),
            ExcerciseItem(name: "Tricep Pulldown", setsCompleted: 0, setsTotal: 3)
        ]
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            List(ExcerciseItems){ item in
//                Text("\(item.name)")
//            }
            PlaceListView(places: places)
            
            testListButton()
            
        }
    }
}

struct WorkoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutScreen()
    }
}
