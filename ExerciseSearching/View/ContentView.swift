//
//  ContentView.swift
//  ExerciseSearching
//
//  Created by 沈清昊 on 5/19/23.
//

import SwiftUI

struct ContentView: View {
    @State var name = ""
    @State var primaryMuscle = ""
    @State var secondaryMuscle = ""
    @State var show = false
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink("Search muscles") {
                    MusclesView()
                }
                Divider()
                TextField("Exercise name", text: $name)
                    .frame(width: 400, height: 25)
                    .background(Color.gray.opacity(0.3).cornerRadius(20))
                    .padding(10)
                NavigationLink("Search by name") {
                    ExerciseNameView(vm: ExerciseNameViewModel(name: name))
                }
                Divider()
                SearchByPrimary(primary: $primaryMuscle)
                NavigationLink("Search by primary muscle") {
                    ExercisePrimaryView(vm: ExercisePrimaryViewModel(primary: primaryMuscle))
                }
                Divider()
                SearchBySecondary(secondary: $secondaryMuscle)
                NavigationLink("Search by secondary muscle") {
                    ExerciseSecondaryView(vm: ExerciseSecondaryViewModel(secondary: secondaryMuscle))
                }
            }
            .navigationTitle("Exercise searching")
            .toolbar {
                ToolbarItem{
                    Button {
                        show.toggle()
                    } label: {
                        Image(systemName: "star.fill")
                    }
                    .sheet(isPresented: $show) {
                        StoredExerciseView()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchByPrimary: View{
    @Binding var primary: String
    
    var body: some View{
        VStack(alignment: .leading){
            Text("Please select the primary muscle by long tap.")
            Text("Primary muscle: \(primary)")
        }
        .foregroundColor(.white)
        .padding(30)
        .background(Color.blue.cornerRadius(30))
        .contextMenu{
            Button {
                primary = "trapezius"
            } label: {
                Text("trapezius")
            }

            Button {
                primary = "deltoid"
            } label: {
                Text("deltoid")
            }

            Button {
                primary = "pectoralis major"
            } label: {
                Text("pectoralis major")
            }

            Button {
                primary = "triceps"
            } label: {
                Text("triceps")
            }

            Button {
                primary = "biceps"
            } label: {
                Text("biceps")
            }

            Button {
                primary = "abdominal"
            } label: {
                Text("abdominal")
            }

            Button {
                primary = "serratus anterior"
            } label: {
                Text("serratus anterior")
            }

            Button {
                primary = "latissimus dorsi"
            } label: {
                Text("latissimus dorsi")
            }

            Button {
                primary = "external oblique"
            } label: {
                Text("external oblique")
            }

            Button {
                primary = "brachioradialis"
            } label: {
                Text("brachioradialis")
            }
        }
    }
}

struct SearchBySecondary: View{
    @Binding var secondary: String
    
    var body: some View{
        VStack(alignment: .leading){
            Text("Please select the primary muscle by long tap.")
            Text("Secondary muscle: \(secondary)")
        }
        .foregroundColor(.white)
        .padding(30)
        .background(Color.red.cornerRadius(30))
        .contextMenu{
            Button {
                secondary = "trapezius"
            } label: {
                Text("trapezius")
            }

            Button {
                secondary = "deltoid"
            } label: {
                Text("deltoid")
            }

            Button {
                secondary = "pectoralis major"
            } label: {
                Text("pectoralis major")
            }

            Button {
                secondary = "triceps"
            } label: {
                Text("triceps")
            }

            Button {
                secondary = "biceps"
            } label: {
                Text("biceps")
            }

            Button {
                secondary = "abdominal"
            } label: {
                Text("abdominal")
            }

            Button {
                secondary = "serratus anterior"
            } label: {
                Text("serratus anterior")
            }

            Button {
                secondary = "latissimus dorsi"
            } label: {
                Text("latissimus dorsi")
            }

            Button {
                secondary = "external oblique"
            } label: {
                Text("external oblique")
            }

            Button {
                secondary = "brachioradialis"
            } label: {
                Text("brachioradialis")
            }
        }
    }
}
