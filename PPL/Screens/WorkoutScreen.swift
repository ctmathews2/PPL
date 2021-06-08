//
//  WorkoutScreen.swift
//  PPL
//
//  Created by Chandler Mathews on 6/2/21.
//

import SwiftUI


//struct SetItem: View {
//    var liftItem : ExcerciseItem
//    var repsCompleted : Int = 0
//    var weight : Int = 0
//    @State var showPopUp : Bool = false
//
//    var body: some View {
//        ZStack {
//            VStack {
//                HStack {
//                    Text("Set 1")
//                    Spacer()
//                    Text("Weight: \(weight)")
//                    Spacer()
//                    Text("Reps: \(selection) (10)")
//                }
//                Button("Modal") {
//                    self.isModal = true
//                }.sheet(isPresented: $isModal, content: {
//                    self.modal
//                })
//            }
//        }
//    }
//
//    @State var isModal: Bool = false
//    @State private var showingSheet = false
//    @State var selection : String = "Value 0"
//
//
//    var modal: some View {
//        VStack {
//            Text("Modal")
//            Form {
//                Section {
//                    Picker(selection: $selection, label:
//                        Text("Picker Name")
//                        , content: {
//                            Text("Value 1").tag(0)
//                            Text("Value 2").tag(1)
//                            Text("Value 3").tag(2)
//                            Text("Value 4").tag(3)
//                    })
//                        .pickerStyle(WheelPickerStyle())
//                }
//            }
//            Text("\(selection)")
//        }
//    }
//}
//struct SetItem: Identifiable {
//    static func == (lhs: SetItem, rhs: SetItem) -> Bool {
//        return lhs.id == rhs.id
//    }
//
//    var id = UUID()
//    @State var reps : Int = 0
//    @State var weight : Int = 0
//}

class SetItem: ObservableObject, Identifiable {
    var id = UUID()
    
    @Published var reps: Int = 0
    @Published var weight: Int = 0
}

struct ExcerciseItem: Identifiable {
    static func == (lhs: ExcerciseItem, rhs: ExcerciseItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var name: String
    var setsCompleted: Int
    var setsTotal: Int
    @State var setItems: [SetItem]
    //Array of set objects
}

struct ExcerciseCellView: View {
    let excercise: ExcerciseItem
    let isExpanded: Bool
    @Binding var isShowing: Bool
    @Binding var activeItem: SetItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(excercise.name).font(.largeTitle)
                    //Spacer()
                    Text("\(excercise.setsCompleted)/\(excercise.setsTotal)").font(.largeTitle)
                }
                .contentShape(Rectangle())
                .frame( height: 100, alignment: .center)
                .background(Color.blue)
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.black), alignment: .bottom)



                if isExpanded{
                    // This is where I would put the sets object
                    VStack(alignment: .leading) {
                        ForEach(excercise.setItems) { set in
                            Text("Reps: \(set.reps) Weight \(set.weight)")
                                .onTapGesture {
                                    isShowing.toggle()
                                    activeItem = set
                                }
                        }
                    }
                }
            }
        }
    }
    
}

struct ExcerciseListView: View {
    let excercises: [ExcerciseItem]
    let fakeItem : ExcerciseItem = ExcerciseItem(name: "", setsCompleted: 0, setsTotal: 0, setItems: [SetItem()])
    @State private var selection: [ExcerciseItem] = [ExcerciseItem(name: "", setsCompleted: 0, setsTotal: 0, setItems: [SetItem()])]
    @State private var testSelect: Bool = false
    @Binding var isShowing: Bool
    @Binding var activeItem: SetItem
    
    var body: some View {
        ScrollView {
            ForEach(ExcerciseItems) { excercise in
                ExcerciseCellView(excercise: excercise, isExpanded: (selection[0] == excercise), isShowing: self.$isShowing, activeItem: self.$activeItem)
                    .onTapGesture {
                        self.selectDeselect(excercise)
                    }
                    .modifier(ListRowModifier())
                    .animation(.easeInOut(duration: 0.3))
            }
        }
    }
    
    func selectDeselect(_ excercise: ExcerciseItem) {
//        if selection.contains(excercise) {
//            selection.remove(excercise)
//        } else {
//            selection.insert(excercise)
//        }
        if selection[0] == excercise {
            selection[0] = fakeItem
        } else {
            selection[0] = excercise
        }
        
        //testSelect.toggle()
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

let testSetArray =
    [ SetItem(), SetItem(), SetItem() ]

let ExcerciseItems =
    [
        ExcerciseItem(name: "Bench Press", setsCompleted: 0, setsTotal: 3, setItems: [ SetItem(), SetItem(), SetItem() ]),
        ExcerciseItem(name: "Incline Press", setsCompleted: 0, setsTotal: 3, setItems:     [ SetItem(), SetItem(), SetItem() ]),
        ExcerciseItem(name: "Shoulder Press", setsCompleted: 0, setsTotal: 3, setItems:     [ SetItem(), SetItem(), SetItem() ]),
        ExcerciseItem(name: "Tricep Extension", setsCompleted: 0, setsTotal: 3, setItems:     [ SetItem(), SetItem(), SetItem() ]),
        ExcerciseItem(name: "Tricep Pulldown", setsCompleted: 0, setsTotal: 3, setItems:     [ SetItem(), SetItem(), SetItem() ])
    ]

struct WorkoutScreen: View {
    @State var isShowing : Bool = false
    @State var activeItem : SetItem = SetItem()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Push")
                    .frame(maxWidth: .infinity, maxHeight: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.top, 20)
                    .background(Color.green)
                ExcerciseListView(excercises: ExcerciseItems, isShowing: self.$isShowing, activeItem: self.$activeItem)
            }
            .ignoresSafeArea()
            
            if isShowing {
                VStack {
                    Text("Pop UP")
                    Text("This item reps:\(activeItem.reps)")
                    Text("This item weight:\(activeItem.weight)")
                    Button("Increase reps") {
                        activeItem.reps += 1
                    }
                    Button("Increase weigth") {
                        activeItem.weight += 1
                    }
                    Button("Dismiss") {
                        isShowing.toggle()
                    }
                }
                .frame(width: 300, height: 500, alignment: .center)
                .background(Color.yellow)
            }
        }
    }
}

struct WorkoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutScreen()
    }
}

// Z Stack on top with toggle
// Struct that takes excercse object and set item #
// - has picker and returns
