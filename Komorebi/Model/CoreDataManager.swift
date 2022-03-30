//
//  CoreDataManager.swift
//  Komorebi
//
//  Created by riccardo ruocco on 17/11/21.
//

import Foundation
import CoreData

class CoreDataManager{
    static let shared = CoreDataManager()
    let persistentContainer:NSPersistentContainer
    
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "CoreDataModel")
        persistentContainer.loadPersistentStores{ (description,error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                
            }
        }
    }
    func save(){
        do{
            try persistentContainer.viewContext.save()
        } catch{
            persistentContainer.viewContext.rollback()
        }
    }
    
    // MARK: - CRUD(Meditation)
    func createMeditation(meditationToSave:Meditation){
        save()
    }
    func readMeditation() -> [Meditation]{
        let fetchRequest: NSFetchRequest<Meditation> = Meditation.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }

    }
    func updateMeditation(){
        save()
    }
    func deleteMeditation(meditationToDelete: Meditation){
        persistentContainer.viewContext.delete(meditationToDelete)
        save()
    }
    // MARK: - CRUD(MeditationSession)
    func createMeditationSession(meditationSessionToSave:MeditationSession){
        save()
    } 
    func readMeditationSession()->[MeditationSession]{
        let fetchRequest: NSFetchRequest<MeditationSession> = MeditationSession.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    func updateMeditationSession(){
        save()
    }
    func deleteMeditationSession(meditationSessionToDelete: MeditationSession){
        persistentContainer.viewContext.delete(meditationSessionToDelete)
        save()
    }
    // MARK: - CRUD(CalmingVisualSession)
    func createCalmingVisualSession(calmingVisualSessionToSave:CalmingVisualSession){
        save()
    }
    func readCalmingVisualSession()->[CalmingVisualSession]{
        let fetchRequest: NSFetchRequest<CalmingVisualSession> = CalmingVisualSession.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    func updateCalmingVisualSession(){
        save()
    }
    func deleteCalmingVisualSession(calmingVisualSessionToDelete:CalmingVisualSession){
        persistentContainer.viewContext.delete(calmingVisualSessionToDelete)
        save()
    }
    // MARK: - CRUD(CalmingVisual)
    func createCalmingVisual(calmingVisualToSave:CalmingVisual){
        save()
    }
    func readCalmingVisual()->[CalmingVisual]{
        let fetchRequest: NSFetchRequest<CalmingVisual> = CalmingVisual.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    func updateCalmingVisual(){
        save()
    }
    func deleteCalmingVisual(calmingVisualToDelete:CalmingVisual){
        persistentContainer.viewContext.delete(calmingVisualToDelete)
        save()
    }
    // MARK: - CRUD(SoundSession)
    func createSoundSession(soundSessionToSave:SoundSession){
        save()
    }
    func readSoundSession()->[SoundSession]{
        let fetchRequest: NSFetchRequest<SoundSession> = SoundSession.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    func updateSoundSession(){
        save()
    }
    func deleteSoundSession(soundSessionToDelete:SoundSession){
        persistentContainer.viewContext.delete(soundSessionToDelete)
        save()
    }
    // MARK: - CRUD(Music)
    func createMusic(musicToSave:Music){
        save()
    }
    func readMusic()->[Music]{
        let fetchRequest: NSFetchRequest<Music> = Music.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    func updateMusic(){
        save()
    }
    func deleteMusic(musicToDelete:Music){
        persistentContainer.viewContext.delete(musicToDelete)
        save()
    }
}
