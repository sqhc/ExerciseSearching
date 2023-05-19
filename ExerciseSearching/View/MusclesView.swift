//
//  MusclesView.swift
//  ExerciseSearching
//
//  Created by 沈清昊 on 5/19/23.
//

import SwiftUI

struct MusclesView: View {
    @StateObject var vm = MusclesViewModel()
    
    var body: some View {
        VStack{
            if let muscles = vm.muscleList{
                Section {
                    Text("Muscles")
                } header: {
                    List(muscles, id: \.self){ muscle in
                        Text(muscle)
                    }
                }
                .listStyle(.sidebar)
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchMuscles)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct MusclesView_Previews: PreviewProvider {
    static var previews: some View {
        MusclesView()
    }
}
