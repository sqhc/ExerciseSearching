//
//  ContentView.swift
//  ExerciseSearching
//
//  Created by 沈清昊 on 5/19/23.
//

import SwiftUI

struct ContentView: View {
    @State var name = ""
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
