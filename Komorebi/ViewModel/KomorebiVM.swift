//
//  KomorebiVM.swift
//  Komorebi
//
//  Created by riccardo ruocco on 15/11/21.
//

import Foundation
import SwiftUI
import AVFoundation

class KomorebiVM: ObservableObject{
    @Published var model:RelaxingModel
    
    var prova:Double = 0.0
    var meditations:[Meditation] = []
    var DBManager:CoreDataManager = CoreDataManager.shared
    var audioPlayer: AVAudioPlayer!
    var soundPlayer: [AVAudioPlayer] = []
    var gsAudio = GSAudio.sharedInstance

    static let shared = KomorebiVM()

    private init(){
        model = RelaxingModel()
    }
    
    // MARK: - get/set(s)
    func getMeditations()->[Meditation]{
        return model.getMeditations()
    }
    func getMusics()->[Music]{
        return model.getMusics()
    }
    

    // MARK: - Intent(s)
    func chooseMeditation(identifier: UUID){
        var meditations:[Meditation] = [Meditation]()
        meditations = DBManager.readMeditation()
        for i in 0..<meditations.count{
            if(meditations[i].id == identifier){
                meditations[i].isSelected = true
            }
        }
        DBManager.updateMeditation()
    }
    func getChoosen()->Meditation?{
        var meditations = readMeditation()
        var selectedMeditation:Meditation? = nil
        for i in 0..<meditations.count{
            if(meditations[i].isSelected == true){
               selectedMeditation = meditations[i]
            }
        }
        return selectedMeditation
    }
    func cleanChosen(){
        var meditations = readMeditation()
        for i in 0..<meditations.count{
            meditations[i].isSelected = false
        }
        updateMeditation()
    }
    func getFavoriteMeditation()->[Meditation]{
        var favoriteMeditation:[Meditation] = []
        var meditations = readMeditation()
        for i in 0..<meditations.count{
            if(meditations[i].isFavorite == true){
                favoriteMeditation.append(meditations[i])
            }
        }
        return favoriteMeditation
    }
    func addMeditationToFavorite(identifier:UUID){
        model.addMeditationToFavorite(identifier: identifier)

    }
    func removeMeditationToFavorite(identifier:UUID){
        model.removeMeditationToFavorite(identifier: identifier)

    }
    func startMeditation(_ fileName : String){
        guard let soundURL = Bundle.main.url(forResource: fileName, withExtension: nil ) else {
                fatalError("Unable to find \(fileName) in bundle")
            }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print("hello")
                print(error.localizedDescription)
            }
       
    }
    func stopMeditation(){
        if let audioPlayer = audioPlayer {
            audioPlayer.stop()
        }
    }
    func chooseMusic(identifier:UUID){
//        var musics:[Music] = [Music]()
////        musics = DBManager.readMusic()
//        musics = model.musics
//        for i in 0..<musics.count{
//            if(musics[i].id == identifier){
//                musics[i].isSelected = true
//            }
//        }
//        DBManager.updateMeditation()
        model.chooseMusic(identifier: identifier)
    }
    func getChosenMusics()->[Music]{
        var chosenMusics: [Music] = []
//        var musics = readMusic()
        var musics = model.musics
        for i in 0..<musics.count{
            if(musics[i].isSelected == true){
                chosenMusics.append(musics[i])
            }
        }
        return chosenMusics
    }
     func removeFromChosen(identifier:UUID){
         model.removeFromChosen(identifier: identifier)
    }
    func cleanChosenMusics(){
        var musics = readMusic()
        for i in 0..<musics.count{
            musics[i].isSelected = false
        }
        updateMeditation()
    }
    func startSoundSession(tracce:[Music]?){
        var nuovaSessione = SoundSession(context: CoreDataManager.shared.persistentContainer.viewContext)
        var nomeTracce:[String] = [String]()
        var volumes:[Double] = []
        nuovaSessione.setSoundSession(isFavorite: false)
        do{
            for suono in tracce!{
                nuovaSessione.addToChoosenMusic(suono)
            }
        }catch{
            print("Errore Sound Session")
        }
        for i in 0..<tracce!.count{
            nomeTracce.append(tracce![i].title! + ".mp3")
            print(tracce![i].title! + ".mp3")
            volumes.append(tracce![i].volume)
            print(tracce![i].volume)
        }
//        Riproduci suoni
        riproduciSuoni(nomeTracce: nomeTracce, volumes: volumes)
    }
    
    func riproduciSuoni(nomeTracce:[String],volumes:[Double]){
        
        for i in 0..<nomeTracce.count{
            var nuovoAudioPlayer:AVAudioPlayer = AVAudioPlayer()
            soundPlayer.append(nuovoAudioPlayer)
        }
        for i in 0..<nomeTracce.count{
            guard let soundURL = Bundle.main.url(forResource: nomeTracce[i], withExtension: nil ) else {
                    fatalError("Unable to find \(nomeTracce[i]) in bundle")
                }
                do {
                    soundPlayer[i] = try AVAudioPlayer(contentsOf: soundURL)
                    soundPlayer[i].numberOfLoops = -1
                    soundPlayer[i].prepareToPlay()
                    soundPlayer[i].volume = Float(volumes[i])
                    soundPlayer[i].play()
                } catch {
                    print(error.localizedDescription)
                }
        }
        
        
    }
    func stopSoundSession(){
//        ferma i suoni
        for i in soundPlayer{
            i.stop()
        }
    }
    func addSoundSessionToFavorite(identifier:UUID){
        model.addMeditationToFavorite(identifier: identifier)
    }
    func removeSessionToFavorite(identifier:UUID){
        model.removeSoundSessionToFavorite(identifier: identifier)
    }
    func chooseVolumes(identifier:UUID,newVolume:Double){
        model.chooseVolumes(identifier: identifier, newVolume: newVolume)
    }
    func cleanVolumes(){
        model.cleanVolumes()
    }
    func getFavoriteSoundSession()->[SoundSession]{
        var soundSessionFavorite = readSoundSession()
        var favoriteSoundSession:[SoundSession] = []
        
        for i in 0..<soundSessionFavorite.count{
            if(soundSessionFavorite[i].isFavorite == true){
                favoriteSoundSession.append(soundSessionFavorite[i])
            }
        }
        return favoriteSoundSession

    }

    // MARK: - CRUD(Meditation)
    func createMeditation(meditationToSave:Meditation){
        DBManager.createMeditation(meditationToSave: meditationToSave)
    }
    func readMeditation()->[Meditation]{
        return DBManager.readMeditation()
    }
    func updateMeditation(){
        DBManager.updateMeditation()
    }
    func deleteMeditation(meditationToDelete:Meditation){
        DBManager.deleteMeditation(meditationToDelete: meditationToDelete)
    }
    // MARK: - CRUD(MeditationSession)
    func createMeditationSession(meditationSessionToSave:MeditationSession){
        DBManager.createMeditationSession(meditationSessionToSave: meditationSessionToSave)

    }
    func readMeditationSession()->[MeditationSession]{
        return DBManager.readMeditationSession()
    }
    func updateMeditationSession(){
        DBManager.updateMeditationSession()
    }
    func deleteMeditationSession(meditationSessionToDelete:MeditationSession){
        DBManager.deleteMeditationSession(meditationSessionToDelete:meditationSessionToDelete)
    }
    // MARK: - CRUD(CalmingVisualSession)
    func createCalmingVisualSession(calmingVisualSessionToSave:CalmingVisualSession){
        DBManager.createCalmingVisualSession(calmingVisualSessionToSave:calmingVisualSessionToSave)
    }
    func readCalmingVisualSession()->[CalmingVisualSession]{
        return DBManager.readCalmingVisualSession()
    }
    func updateCalmingVisualSession(){
        DBManager.updateCalmingVisualSession()
    }
    func deleteCalmingVisualSession(calmingVisualSessionToDelete:CalmingVisualSession){
        DBManager.deleteCalmingVisualSession(calmingVisualSessionToDelete: calmingVisualSessionToDelete)
    }
    // MARK: - CRUD(CalmingVisual)
    func createCalmingVisual(calmingVisualToSave:CalmingVisual){
        DBManager.createCalmingVisual(calmingVisualToSave: calmingVisualToSave)
    }
    func readCalmingVisual()->[CalmingVisual]{
        return DBManager.readCalmingVisual()
    }
    func updateCalmingVisual(){
        DBManager.updateCalmingVisual()
    }
    func deleteCalmingVisual(calmingVisualToDelete:CalmingVisual){
        DBManager.deleteCalmingVisual(calmingVisualToDelete: calmingVisualToDelete)
    }
    
    // MARK: - CRUD(SoundSession)
    func createSoundSession(soundSessionToSave:SoundSession){
        DBManager.createSoundSession(soundSessionToSave: soundSessionToSave)
    }
    func readSoundSession()->[SoundSession]{
        return DBManager.readSoundSession()
    }
    func updateSoundSession(){
        DBManager.updateSoundSession()
    }
    func deleteSoundSession(soundSessionToDelete:SoundSession){
        DBManager.deleteSoundSession(soundSessionToDelete: soundSessionToDelete)
    }
    // MARK: - CRUD(Music)
    func createMusic(musicToSave:Music){
        DBManager.createMusic(musicToSave: musicToSave)
    }
    func readMusic()->[Music]{
        return DBManager.readMusic()
    }
    func updateMusic(){
        DBManager.updateMusic()
    }
    func deleteMusic(musicToDelete:Music){
        DBManager.deleteMusic(musicToDelete: musicToDelete)
    }
}

