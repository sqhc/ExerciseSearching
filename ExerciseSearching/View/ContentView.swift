//
//  ContentView.swift
//  ExerciseSearching
//
//  Created by 沈清昊 on 5/19/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink("Search muscles") {
                    MusclesView()
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
