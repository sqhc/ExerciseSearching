//
//  StoredExerciseView.swift
//  ExerciseSearching
//
//  Created by 沈清昊 on 5/21/23.
//

import SwiftUI

struct StoredExerciseView: View {
    @StateObject var vm = StoredExerciseViewModel()
    @State private var exercises = [MyExercise]()
    
    private func showExercises(){
        exercises = vm.manager.getExercises()
    }
    
    var body: some View {
        VStack{
            List{
                ForEach(exercises, id: \.self) { exercise in
                    VStack(alignment: .leading){
                        Text("Name: \(exercise.name ?? "")")
                        Text("Type: \(exercise.type ?? "")")
                        Text("Force: \(exercise.force ?? "")")
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let exercise = exercises[index]
                        vm.manager.deleteExercise(exercise: exercise)
                        showExercises()
                    }
                }
            }
        }
        .onAppear(perform: showExercises)
    }
}

struct StoredExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        StoredExerciseView()
    }
}
