//
//  ExerciseSecondaryView.swift
//  ExerciseSearching
//
//  Created by 沈清昊 on 5/21/23.
//

import SwiftUI

struct ExerciseSecondaryView: View {
    @StateObject var vm: ExerciseSecondaryViewModel
    
    var body: some View {
        ZStack{
            if let exercises = vm.exercises{
                List(exercises, id: \.Youtubelink){ exercise in
                    ExerciseItem(exercise: exercise)
                }
                .listStyle(.plain)
                .navigationTitle("Search by secondary muscle")
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

struct ExerciseSecondaryView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseSecondaryView(vm: ExerciseSecondaryViewModel(secondary: ""))
    }
}
