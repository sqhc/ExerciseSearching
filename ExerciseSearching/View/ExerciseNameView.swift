//
//  ExerciseNameView.swift
//  ExerciseSearching
//
//  Created by 沈清昊 on 5/20/23.
//

import SwiftUI
import AVKit

struct ExerciseNameView: View {
    @StateObject var vm: ExerciseNameViewModel
    
    var body: some View {
        ZStack{
            if let exercises = vm.exercises{
                List(exercises, id: \.Youtubelink){ exercise in
                    ExerciseItem(exercise: exercise)
                }
                .listStyle(.plain)
                .navigationTitle("Search by name")
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

struct ExerciseNameView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseNameView(vm: ExerciseNameViewModel(name: ""))
    }
}

struct ExerciseItem: View{
    var exercise: Exercise
    @State var player = AVPlayer()
    
    var body: some View{
        VStack(alignment: .leading){
            Text("Name: \(exercise.Name ?? "")")
            Text("Force: \(exercise.Force ?? "")")
            Text("Type: \(exercise.type ?? "")")
            if let primaries = exercise.PrimaryMuscles{
                Section {
                    ForEach(primaries, id: \.self) { primary in
                        Text(primary)
                    }
                    .frame(height: 100)
                } header: {
                    Text("Primary muscles")
                }
            }
            
            if let secondaries = exercise.SecondaryMuscles{
                Section {
                    ForEach(secondaries, id: \.self) { secondary in
                        Text(secondary)
                    }
                    .frame(height: 100)
                } header: {
                    Text("Secondary muscles")
                }
            }
            
            if let workOuts = exercise.WorkoutType{
                Section {
                    ForEach(workOuts, id: \.self){ workOut in
                        Text(workOut)
                    }
                    .frame(height: 100)
                } header: {
                    Text("Work out types")
                }
            }
            
            VideoPlayer(player: player)
                .frame(width: 400, height: 200)
                .onAppear {
                    player = AVPlayer(url: URL(string: exercise.Youtubelink ?? "")!)
                }
        }
    }
}
