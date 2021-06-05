//
//  WorkoutScreen.swift
//  PPL
//
//  Created by Chandler Mathews on 6/2/21.
//

import SwiftUI


struct SetItem: View {
    var liftItem : ExcerciseItem
    var repsCompleted : Int = 0
    var weight : Int = 0
    @State var showPopUp : Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Set 1")
                    Spacer()
                    Text("Weight: \(weight)")
                    Spacer()
                    Text("Reps: \(selection) (10)")
                }
                Button("Modal") {
                    self.isModal = true
                }.sheet(isPresented: $isModal, content: {
                    self.modal
                })
            }
        }
    }
    
    @State var isModal: Bool = false
    @State private var showingSheet = false
    @State var selection : String = "Value 0"


    var modal: some View {
        VStack {
            Text("Modal")
            Form {
                Section {
                    Picker(selection: $selection, label:
                        Text("Picker Name")
                        , content: {
                            Text("Value 1").tag(0)
                            Text("Value 2").tag(1)
                            Text("Value 3").tag(2)
                            Text("Value 4").tag(3)
                    })
                        .pickerStyle(WheelPickerStyle())
                }
            }
            Text("\(selection)")
        }
    }
}

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
            //Spacer()
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(excercise.name).font(.largeTitle)
                Spacer()
                Text("\(excercise.setsCompleted)/\(excercise.setsTotal)").font(.largeTitle)
            }
            .contentShape(Rectangle())
            .frame( height: 100, alignment: .center)
            .background(Color.blue)
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.black), alignment: .bottom)
            
            
            
            if isExpanded{
                // This is where I would put the sets object
                VStack(alignment: .leading) {
                    // For loops for sets item array?
//                    Text("\(excercise.setsCompleted)")
//                    Text("\(excercise.setsTotal)")
                    SetItem(liftItem: excercise)
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
            //Divider()
        }.offset(x: 0)
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
                Text("Push")
                    .frame(maxWidth: .infinity, maxHeight: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.top, 20)
                    .background(Color.green)
                //ExcerciseListView(excercises: ExcerciseItems)
            }
            .ignoresSafeArea()
    }
}

struct WorkoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutScreen()
    }
}
