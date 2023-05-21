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
            }
            .navigationTitle("Exercise searching")
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
