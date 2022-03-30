//
//  RelaxingM.swift
//  Komorebi
//
//  Created by riccardo ruocco on 15/11/21.
//

import Foundation
import CoreData
import SwiftUI



struct RelaxingModel{
    
    var DBManager:CoreDataManager = CoreDataManager.shared
    @AppStorage("KO") var firstOpen = true
    
    var meditations:[Meditation] = []
    var soundSessions:[SoundSession] = [SoundSession]()
    var musics:[Music] = []
    
    init(){
    
        if(firstOpen == true){
            setModel()
        }
        meditations = DBManager.readMeditation()
        musics = DBManager.readMusic()
        soundSessions = DBManager.readSoundSession()
        firstOpen = false
//        deleteModel()
        
        
    }
    func setModel(){
        var esercizio1 = Meditation(context: CoreDataManager.shared.persistentContainer.viewContext)
        esercizio1.setMeditation(name: "Sirius", duration: 780, imageName: "Sirius", isCoached: false, isFavorite: false, isSelected: false)
        DBManager.createMeditation(meditationToSave: esercizio1)
        var esercizio2 = Meditation(context: CoreDataManager.shared.persistentContainer.viewContext)
        esercizio2.setMeditation(name: "Canopus", duration: 360, imageName: "Canopus", isCoached: true, isFavorite: false, isSelected: false)
        DBManager.createMeditation(meditationToSave: esercizio2)
        var esercizio3 = Meditation(context: CoreDataManager.shared.persistentContainer.viewContext)
        esercizio3.setMeditation(name: "Arcturus", duration: 328, imageName: "Arcturus", isCoached: true, isFavorite: false, isSelected: false)
        DBManager.createMeditation(meditationToSave: esercizio3)
          var esercizio4 = Meditation(context: CoreDataManager.shared.persistentContainer.viewContext)
          esercizio4.setMeditation(name: "Vega", duration: 530, imageName: "Vega", isCoached: true, isFavorite: false, isSelected: false)
          DBManager.createMeditation(meditationToSave: esercizio4)
        var esercizio5 = Meditation(context: CoreDataManager.shared.persistentContainer.viewContext)
        esercizio5.setMeditation(name: "Rigel", duration: 750, imageName: "Rigel", isCoached: true, isFavorite: false, isSelected: false)
        DBManager.createMeditation(meditationToSave: esercizio5)
        var esercizio6 = Meditation(context: CoreDataManager.shared.persistentContainer.viewContext)
        esercizio6.setMeditation(name: "Altair", duration: 264, imageName: "Altair", isCoached: true, isFavorite: false, isSelected: false)
        DBManager.createMeditation(meditationToSave: esercizio6)
        var esercizio7 = Meditation(context: CoreDataManager.shared.persistentContainer.viewContext)
        esercizio7.setMeditation(name: "Spica", duration: 780, imageName: "Spica", isCoached: true, isFavorite: false, isSelected: false)
        DBManager.createMeditation(meditationToSave: esercizio7)
        var esercizio8 = Meditation(context: CoreDataManager.shared.persistentContainer.viewContext)
        esercizio8.setMeditation(name: "Sakura", duration: 654, imageName: "Sakura", isCoached: true, isFavorite: false, isSelected: false)
        DBManager.createMeditation(meditationToSave: esercizio8)
        var esercizio9 = Meditation(context: CoreDataManager.shared.persistentContainer.viewContext)
        esercizio9.setMeditation(name: "Deneb", duration: 366, imageName: "Deneb", isCoached: true, isFavorite: false, isSelected: false)
        DBManager.createMeditation(meditationToSave: esercizio9)
        var esercizio10 = Meditation(context: CoreDataManager.shared.persistentContainer.viewContext)
        esercizio10.setMeditation(name: "Achernar", duration: 611, imageName: "Achernar", isCoached: true, isFavorite: false, isSelected: false)
        DBManager.createMeditation(meditationToSave: esercizio10)
        
        var suono1 = Music(context: CoreDataManager.shared.persistentContainer.viewContext)
        suono1.setMusic(title: "Windy Field", imageName: "Windy Field", isSelected: false, volume: 0)
        DBManager.createMusic(musicToSave: suono1)
        var suono2 = Music(context: CoreDataManager.shared.persistentContainer.viewContext)
        suono2.setMusic(title: "Ocean", imageName: "Ocean", isSelected: false, volume: 0)
        DBManager.createMusic(musicToSave: suono2)
        var suono3 = Music(context: CoreDataManager.shared.persistentContainer.viewContext)
        suono3.setMusic(title: "Rain", imageName: "Rain", isSelected: false, volume: 0)
        DBManager.createMusic(musicToSave: suono3)
        var suono4 = Music(context: CoreDataManager.shared.persistentContainer.viewContext)
        suono4.setMusic(title: "Birds", imageName: "Birds", isSelected: false, volume: 0)
        DBManager.createMusic(musicToSave: suono4)
        var suono5 = Music(context: CoreDataManager.shared.persistentContainer.viewContext)
        suono5.setMusic(title: "Fire", imageName: "Fire", isSelected: false, volume: 0)
        DBManager.createMusic(musicToSave: suono5)
        var suono6 = Music(context: CoreDataManager.shared.persistentContainer.viewContext)
        suono6.setMusic(title: "Tibetan Bells", imageName: "Tibetan Bells", isSelected: false, volume: 0)
        DBManager.createMusic(musicToSave: suono6)
        var suono7 = Music(context: CoreDataManager.shared.persistentContainer.viewContext)
        suono7.setMusic(title: "Campanula", imageName: "Campanula", isSelected: false, volume: 0)
        DBManager.createMusic(musicToSave: suono7)
        
    }
    func deleteModel(){
        var prova = DBManager.readMeditation()
        var prova2 = DBManager.readSoundSession()
        var prova3 = DBManager.readMusic()
        for i in prova{
            DBManager.deleteMeditation(meditationToDelete: i)
        }
        for i in prova3{
            DBManager.deleteMusic(musicToDelete: i)
        }
        for i in prova2{
            DBManager.deleteSoundSession(soundSessionToDelete: i)

        }
    }
    
    
     func getMeditations()->[Meditation]{
        return meditations
    }
    func getMusics()->[Music]{
        return musics
    }
    
    
    
    mutating func chooseMusic(identifier:UUID){
//        musics = DBManager.readMusic()
        for i in 0..<musics.count{
            if(musics[i].id == identifier){
                musics[i].isSelected = true
            }
        }
        DBManager.updateMeditation()
    }
    mutating func removeFromChosen(identifier:UUID){
        musics = DBManager.readMusic()
        for i in 0..<musics.count{
            if(musics[i].id == identifier){
                musics[i].isSelected = false
            }
        }
        DBManager.updateMeditation()
    }
    mutating func addMeditationToFavorite(identifier:UUID){
        for i in 0..<meditations.count{
            if(meditations[i].id == identifier){
                meditations[i].isFavorite = true
            }
        }
        DBManager.updateMeditation()
    }
    mutating func removeMeditationToFavorite(identifier:UUID){
        for i in 0..<meditations.count{
            if(meditations[i].id == identifier){
                meditations[i].isFavorite = false
            }
        }
        DBManager.updateMeditation()
    }
    mutating func addSoundSessionToFavorite(identifier:UUID){
        for i in 0..<soundSessions.count{
            if(soundSessions[i].id == identifier){
                soundSessions[i].isFavorite = true
            }
        }
        DBManager.updateMusic()
        DBManager.updateSoundSession()
    }
    mutating func removeSoundSessionToFavorite(identifier:UUID){
        for i in 0..<soundSessions.count{
            if(soundSessions[i].id == identifier){
                soundSessions[i].isFavorite = false
            }
        }
        DBManager.updateMusic()
        DBManager.updateSoundSession()
    }
    mutating func chooseVolumes(identifier:UUID,newVolume:Double){
        var sounds = musics
        for i in 0..<sounds.count{
            if(sounds[i].id == identifier){
                sounds[i].volume = newVolume
                print(sounds[i].title)
                print(sounds[i].volume)
            }
        }
        DBManager.updateSoundSession()
        DBManager.updateMusic()
    }
    mutating func cleanVolumes(){
        var sounds = musics
        for i in 0..<sounds.count{
            sounds[i].volume = 0
        }
        DBManager.updateSoundSession()
        DBManager.updateMusic()
    }
    
    

}
extension Meditation{
    func setMeditation(name:String,duration:Int64,imageName:String,isCoached:Bool,isFavorite:Bool,isSelected:Bool){
        self.id = UUID()
        self.name = name
        self.duration = duration
        self.imageName = imageName
        self.isCoached = isCoached
        self.isFavorite = isFavorite
        self.isSelected = isSelected
    }
}
extension SoundSession{
    func setSoundSession(isFavorite:Bool){
        self.id = UUID()
        self.isFavorite = isFavorite
        self.title = title
    }
    
}
extension Music{
    func setMusic(title:String,imageName:String,isSelected:Bool,volume:Double){
        self.id = UUID()
        self.title = title
        self.imageName = imageName
        self.isSelected = isSelected
        self.volume = volume
    }
}
