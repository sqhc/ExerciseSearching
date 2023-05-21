//
//  ExercisePrimaryView.swift
//  ExerciseSearching
//
//  Created by 沈清昊 on 5/20/23.
//

import SwiftUI

struct ExercisePrimaryView: View {
    @StateObject var vm: ExercisePrimaryViewModel
    
    var body: some View {
        ZStack{
            if let exercises = vm.exercises{
                List(exercises, id: \.Youtubelink){ exercise in
                    ExerciseItem(exercise: exercise)
                }
                .listStyle(.plain)
                .navigationTitle("Search by primary muscle")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchExercises)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct ExercisePrimaryView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisePrimaryView(vm: ExercisePrimaryViewModel(primary: ""))
    }
}
