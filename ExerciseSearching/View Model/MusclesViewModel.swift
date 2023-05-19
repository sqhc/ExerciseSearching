//
//  MusclesViewModel.swift
//  ExerciseSearching
//
//  Created by 沈清昊 on 5/19/23.
//

import Foundation
import Combine

class MusclesViewModel: ObservableObject{
    var searchMusclesString = "https://exerciseapi3.p.rapidapi.com/search/muscles/"
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "exerciseapi3.p.rapidapi.com"
    ]
    
    @Published var muscleList: [String]?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    func fetchMuscles(){
        guard let url = URL(string: searchMusclesString) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> [String] in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                let decoder = JSONDecoder()
                guard let muscles = try? decoder.decode([String].self, from: result.data) else{
                    throw LoadError.failedToDecode
                }
                return muscles
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] muscles in
                self?.muscleList = muscles
            }
            .store(in: &bag)
    }
}

extension MusclesViewModel{
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
