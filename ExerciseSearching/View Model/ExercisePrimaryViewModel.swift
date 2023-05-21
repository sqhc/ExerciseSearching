//
//  ExercisePrimaryViewModel.swift
//  ExerciseSearching
//
//  Created by 沈清昊 on 5/20/23.
//

import Foundation
import Combine

class ExercisePrimaryViewModel: ObservableObject{
    let primary: String
    
    var searchExerciseWithPrimary = "https://exerciseapi3.p.rapidapi.com/search/?primaryMuscle="
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "exerciseapi3.p.rapidapi.com"
    ]
    
    @Published var exercises: [Exercise]?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    init(primary: String){
        self.primary = primary
    }
    
    func fetchExercises(){
        searchExerciseWithPrimary += "\(primary.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
        
        guard let url = URL(string: searchExerciseWithPrimary) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> [Exercise] in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                let decoder = JSONDecoder()
                guard let exercises = try? decoder.decode([Exercise].self, from: result.data) else{
                    throw LoadError.failedToDecode
                }
                return exercises
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] exercises in
                self?.exercises = exercises
            }
            .store(in: &bag)
    }
}

extension ExercisePrimaryViewModel{
    enum LoadError: LocalizedError{
        case custom(error: Error)
        case failedToDecode
        case invalidStatusCode
        case failedToUnwrapOptional
        
        var errorDescription: String?{
            switch self {
            case .custom(let error):
                return error.localizedDescription
            case .failedToDecode:
                return "Unable to decode data."
            case .invalidStatusCode:
                return "GET request failed due to invalid status code."
            case .failedToUnwrapOptional:
                return "Unable to unwrap optional value."
            }
        }
    }
}
