//
//  VistaProva.swift
//  Komorebi
//
//  Created by riccardo ruocco on 18/11/21.
//

import SwiftUI

struct VistaProva: View {
    var id = UUID()
    var content:String = "Uno"
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
            Text(content)
        }
    }
}

struct VistaProva_Previews: PreviewProvider {
    static var previews: some View {
        VistaProva()
    }
}
