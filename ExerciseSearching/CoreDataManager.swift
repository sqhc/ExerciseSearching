//
//  CoreDataManager.swift
//  ExerciseSearching
//
//  Created by 沈清昊 on 5/21/23.
//

import Foundation
import CoreData

class CoreDataManager{
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "SavedExericse")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func saveExercise(exercise: Exercise){
        let myExercise = MyExercise(context: container.viewContext)
        
        myExercise.name = exercise.Name
        myExercise.type = exercise.type
        myExercise.force = exercise.Force
        
        do{
            try container.viewContext.save()
        }
        catch{
            print("Failed to save exercise: \(error)")
        }
    }
    
    func getExercises()-> [MyExercise]{
        let request: NSFetchRequest<MyExercise> = MyExercise.fetchRequest()
        
        do{
            return try container.viewContext.fetch(request)
        } catch{
            return []
        }
    }
    
    func checkExist(name: String) -> Bool{
        let request: NSFetchRequest<MyExercise> = MyExercise.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "name == \(name)")
        
        do{
            return try container.viewContext.fetch(request).count == 1
        } catch{
            print("Fetach falied: \(error)")
            return false
        }
    }
    
    func fetchSpecific(name: String)-> MyExercise{
        let request: NSFetchRequest<MyExercise> = MyExercise.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "name == \(name)")
        
        do{
            return try container.viewContext.fetch(request)[0]
        }
        catch{
            print("Fetch failed: \(error)")
            return MyExercise()
        }
    }
    
    func deleteExercise(exercise: MyExercise){
        container.viewContext.delete(exercise)
        
        do{
            try container.viewContext.save()
        }catch{
            container.viewContext.rollback()
            print("Failed to delete exercise: \(error)")
        }
    }
}
