//
//  WorkoutScreen.swift
//  PPL
//
//  Created by Chandler Mathews on 6/2/21.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Press to dismiss") {
            presentationMode.wrappedValue.dismiss()
        }
        .font(.title)
        .padding()
        .background(Color.black)
    }
}

struct SetItem: View {
    var liftItem : ExcerciseItem
    var repsCompleted : Int = 0
    var weight : Int = 0
    @State var showPopUp : Bool = false
    @EnvironmentObject var helper : Helper
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Set 1")
                    Spacer()
                    Text("Weight: \(weight)")
                    Spacer()
                    Text("Reps: \(repsCompleted) (10)")
                }
                Button("Modal") {
                    self.isModal = true
                }.sheet(isPresented: $isModal, content: {
                    self.modal
                })
                Button("Show Sheet") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    SheetView()
                }
                Button(action: {
                    //self.showPopUp = true
                    self.helper.changeField(text: liftItem.name)
                }, label: {
                    Text("Show custom pop up")
                })
            }
        }
    }
    
    @State var isModal: Bool = false
    @State private var showingSheet = false


    var modal: some View {
        Text("Modal")
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
            //.frame(width: UIScreen.screenWidth, height: isExpanded == true ? 200 : 150, alignment: .center)
            //.border( /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .frame( height: 100, alignment: .center)
            .background(Color.blue)
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.black), alignment: .bottom)
            
            
            
            if isExpanded{
                // This is where I would put the sets object
                VStack(alignment: .leading) {
                    // For loops for sets item array?
//                    Text("\(excercise.setsCompleted)")
//                    Text("\(excercise.setsTotal)")
                    HStack {
                        Text("Set 1")
                        Spacer()
                        Text("Add Reps:")
                        Spacer()
                        Text("Add Weight:")
                    }
                    .background(Color.red)
                    HStack {
                        Text("Set 2")
                        Spacer()
                        Text("Add Reps:")
                        Spacer()
                        Text("Add Weight:")
                    }
                    .background(Color.red)
                    HStack {
                        Text("Set 3")
                        Spacer()
                        Text("Add Reps:")
                        Spacer()
                        Text("Add Weight:")
                    }
                    .background(Color.red)
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

class Helper: ObservableObject {

    @Published var myGlobbal : Bool = false
    @Published var globalText : String = "hey"

    func changeField(text: String) {
        myGlobbal.toggle()
        globalText = text
    }
}

struct WorkoutScreen: View {
    @EnvironmentObject var helper : Helper
    var body: some View {
        ZStack {
            VStack {
                Text("Push")
                    .frame(maxWidth: .infinity, maxHeight: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.top, 20)
                    .background(Color.green)
                ExcerciseListView(excercises: ExcerciseItems)
            }
            .ignoresSafeArea()
            if self.helper.myGlobbal {
                ZStack {
                    Color.white
                    VStack {
                        Text("Custom Pop Up")
                        Text("\(self.helper.globalText)")
                        Spacer()
                        Button(action: {
                            //self.showPopUp = false
                            self.helper.changeField(text: "Closed")
                        }, label: {
                            Text("Close")
                        })
                    }.padding()
                }
                .frame(width: 300, height: 200)
                .cornerRadius(20).shadow(radius: 20)
            }
        }
    }
}

struct WorkoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutScreen()
            .environmentObject(Helper())

    }
}
