//
//  ExerciseDataModel.swift
//  ExerciseSearching
//
//  Created by 沈清昊 on 5/20/23.
//

import Foundation

struct Exercise: Codable{
    let Force: String?
    let Name: String?
    let PrimaryMuscles: [String]?
    let SecondaryMuscles: [String]?
    let type: String?
    let WorkoutType: [String]?
    let Youtubelink: String?
    
    private enum CodingKeys: String, CodingKey{
        case Force
        case Name
        case PrimaryMuscles = "Primary Muscles"
        case SecondaryMuscles
        case type = "Type"
        case WorkoutType = "Workout Type"
        case Youtubelink = "Youtube link"
    }
}
