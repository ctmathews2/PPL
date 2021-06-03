//
//  WorkoutScreen.swift
//  PPL
//
//  Created by Chandler Mathews on 6/2/21.
//

import SwiftUI

struct ExcerciseItem: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var setsCompleted: Int
    var setsTotal: Int
    //var hello: [SetItem]? = nil
    //Array of set objects
}

struct ExcerciseCellView: View {
    let excercise: ExcerciseItem
    let isExpanded: Bool
    
    var body: some View {
        HStack {
            content
            Spacer()
        }
        .contentShape(Rectangle())
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            Text(excercise.name).font(.headline)
            
            if isExpanded{
                // This is where I would put the sets object
                VStack(alignment: .leading) {
                    Text("\(excercise.setsCompleted)")
                    Text("\(excercise.setsTotal)")
                }
            }
        }
    }
}

struct ExcerciseListView: View {
    let excercises: [ExcerciseItem]
    @State private var selection: Set<ExcerciseItem> = []
    
    var body: some View {
        ScrollView {
            ForEach(ExcerciseItems) { excercise in
                ExcerciseCellView(excercise: excercise, isExpanded: self.selection.contains(excercise))
                    .onTapGesture {
                        self.selectDeselect(excercise)
                    }
                    .modifier(ListRowModifier())
                    .animation(.easeInOut(duration: 0.3))
            }
        }
    }
    
    func selectDeselect(_ excercise: ExcerciseItem) {
        if selection.contains(excercise) {
            selection.remove(excercise)
        } else {
            selection.insert(excercise)
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

let ExcerciseItems =
    [
        ExcerciseItem(name: "Bench Press", setsCompleted: 0, setsTotal: 3),
        ExcerciseItem(name: "Incline Press", setsCompleted: 0, setsTotal: 3),
        ExcerciseItem(name: "Shoulder Press", setsCompleted: 0, setsTotal: 3),
        ExcerciseItem(name: "Tricep Extension", setsCompleted: 0, setsTotal: 3),
        ExcerciseItem(name: "Tricep Pulldown", setsCompleted: 0, setsTotal: 3)
    ]

struct WorkoutScreen: View {
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            ExcerciseListView(excercises: ExcerciseItems)
        }
    }
}

struct WorkoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutScreen()
    }
}
