//
//  PredatorDetail.swift
//  DinosPark
//
//  Created by Lucca Filizzola on 22/07/26.
//

import SwiftUI

struct PredatorDetail: View {
    let predator: ApexPredator
    var body: some View {
        ScrollView {
            
            ZStack {
                //Background image
                Image(predator.type.backgroundImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                //Dino Image
                
                Image(predator.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                //Dino Name
                Text(predator.name)
                    .font(.largeTitle)
                    .bold()
                    
                
                //Current Location
                
                //Appear in
               
                VStack(alignment: .leading, spacing: 4) {
                    Text("Appears in:")
                        .font(.headline)
                    ForEach(predator.movies) { movie in
                        Text(". \(movie.rawValue)")
                            .font(.subheadline)
                    }
                }
                
                
                //Movies moments
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Movie Moments")
                        .font(.largeTitle)
                    
                    ForEach(predator.movieScenes) { movieScene in
                       
                        VStack(alignment: .leading, spacing: 4) {
                            Text(movieScene.movie.rawValue)
                                .font(.subheadline)
                            Text(movieScene.sceneDescription)
                                .font(.subheadline)
                        }
                            
                    }
                }
                
                // Link
                if let urlLink = URL(string: predator.link) {
                    Link(destination: urlLink, label: {
                        Text("Link irado")
                    })
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)  // estica o VStack
                .padding(.horizontal)
           
        }
        .background(.black)
        .foregroundStyle(.white)
    }
}

//Parei 5.45

/*
 Anotações da tela:
 
 A VStack po padrão centraliza o conteudo e vai aumentando a partir do centro, a scroll view começa do topo
 */

#Preview {
    PredatorDetail(predator: .init(
        id: 1,
        name: "Velociraptor",
        type: .land,
        latitude: 0,
        longitude: 0,
        movies: [
            .jurassicPark,
            .jurassicParkIII,
            .jurassicWorldFallenKingdom,
            .theLostWorldJurassicPark
        ],
        movieScenes: [
            .init(id: 1, movie: .jurassicPark, sceneDescription: "A velociraptor appears in the very first scene in Jurassic Park when Muldoon and his team try to bring a female into the park. It attacks one of the team members and they are forced to shoot it. They don’t appear then until far later in the film when Ellie and Muldoon have to restore the park’s power systems. Muldoon realises they’re being hunted by them and tells Ellie to run to the power shed as he tracks a Velociraptor with his gun. She restores the power and finds what’s left of Ray and she narrowly escapes from a Velociraptor. Muldoon is still tracking a raptor when the female ambushes him, killing him. The raptors appear again in the visitor center when Lex and Tim are eating. They hide in the kitchen and avoid being detected. They managed to trap one of them and escape. The raptors catch up with the group in the control room so Ellie, Dr. Grant, Tim and Lex escape through the vents and into the main lobby area of the visitor center. They fall to the ground and are about to be attacked by two Velociraptors when the Tyrannosaur appears, killing both of them. The survivors use this opportunity to escape the island.")
        ],
        link: "https://jurassicpark.fandom.com/wiki/Velociraptor"
    ))
}
