//
//  RelaxingM.swift
//  Komorebi
//
//  Created by riccardo ruocco on 15/11/21.
//

import Foundation
import CoreData

struct RelaxingModel{
    
    var meditations:[Meditation] = [Meditation]()
    var meditationSessions:[MeditationSession] = [MeditationSession]()
    var calmingVisuals:[CalmingVisual] = [CalmingVisual]()
    var calmingVisualSessions:[CalmingVisualSession] = [CalmingVisualSession]()
    var soundSessions:[SoundSession] = [SoundSession]()
    var musics:[Music] = [Music]()
    var favoriteList = FavoriteList()

}
