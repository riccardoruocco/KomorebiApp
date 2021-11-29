//
//  KomorebiVM.swift
//  Komorebi
//
//  Created by riccardo ruocco on 15/11/21.
//

import Foundation
import SwiftUI

class KomorebiVM: ObservableObject{
    @Published var model:RelaxingModel
    var DBManager:CoreDataManager = CoreDataManager.shared
    
    init(){
        model = RelaxingModel()
    }
    // MARK: - get/set(s)

    
    // MARK: - Intent(s)
    func chooseMeditation(){
        
    }
    func showFavoriteMeditation(){
        
    }
    func addMeditationToFavorite(){
        
    }
    func startMeditation(){
        
    }
    func stopMeditation(){
        
    }
    func chooseMusics(){
        
    }
    func startSoundSession(){
        
    }
    func stopSoundSession(){
        
    }
    func addSoundSessionToFavorite(){
        
    }
    func chooseVolumes(){
        
    }
    func showFavoriteSoundSession(){
        
    }
    func chooseCalmingVisual(){
        
    }
    func startCalmingVisual(){
        
    }
    func stopCalmingVisual(){
        
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
    
    // MARK: - CRUD(FavoriteList) Da terminare

    func addFavoriteList(){
        
    }
    func readFavoriteList(){
        
    }
    func removeFromFavoriteList(){
        
    }
    
}
