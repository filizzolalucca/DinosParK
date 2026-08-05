//
//  PredatorDetail.swift
//  DinosPark
//
//  Created by Lucca Filizzola on 22/07/26.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredator
    
    @State var position: MapCameraPosition
    
    @Namespace var namespace
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                
                ZStack(alignment: .bottomTrailing) {
                    //Background image
                    Image(predator.type.backgroundImage)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(
                                stops: [
                                    .init(color: .clear, location: 0.8),
                                    .init(color: .black, location: 1),
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        }
                    
                    //Dino Image
                    
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width/1.5, height: geometry.size.height/3.7)
                        .scaleEffect(x: -1) //inverte o lado
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20) // isso tamambem nao muda o espaco que a view ocupa, somente visualmente sua posicao
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    //Dino Name
                    Text(predator.name)
                        .font(.largeTitle)
                        .bold()
                    
                    NavigationLink {
                        PredatorMap(position: .camera(MapCamera(
                            centerCoordinate: predator.location,
                            distance: 1000,
                            heading: 250,
                            pitch: 80
                        )))
                        .navigationTransition(.zoom(sourceID: 1, in: namespace))

                       
                    } label: {
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 200)
                        .clipShape(.rect(cornerRadius: 15))
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                        //Appear in
                    }
                    .matchedTransitionSource(id: 1, in: namespace)
                    //Current Location
                   
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Appears in:")
                            .font(.headline)
                        ForEach(predator.movies) { movie in
                            Text(". \(movie.rawValue)")
                                .font(.subheadline)
                            //o cara do curso usou um padding(top,15)
                        }
                    }
                    
                    
                    //Movies moments
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Movie Moments")
                            .font(.largeTitle)
                        
                        ForEach(predator.movieScenes) { movieScene in
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(movieScene.movie.rawValue)
                                    .font(.title2)
                                Text(movieScene.sceneDescription)
                                    .font(.subheadline)
                            }
                            
                        }
                    }
                    
                    Text("Read More:")
                        .font(.caption)
                    // Link
                    if let urlLink = URL(string: predator.link) {
                        Link(predator.link, destination: urlLink)
                        .font(.caption)
                        .foregroundStyle(.blue)
                    }
                }
                .padding()
                .padding(.bottom)
                .frame(width: geometry.size.width, alignment: .leading)  // estica o VStack
                
            }
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
        .background(.black)
        .foregroundStyle(.white)
    }
}

//Parei 5.45

/*
 Anotações da tela:
 
 1 - A VStack por padrão centraliza o conteudo e vai aumentando a partir do centro, a scroll view começa do topo
 
 2 - Ele usa esse geometryReader para pegar as dimensoes reais da tela e fazer a imagem do dinassourao proporcionalmente igual em diferentes devices
 
 3 - scaleEffect(x: -1) //inverte o lado, deixa de cabeca para baixo, pode deixar a imagem visualmente maior. apesar de que na organizacao das views o tamanho que ela ocupa permanece o mesmo
 
 4 - mesmo com uma stack com alinhamento para leading o conteudo nao ficaria alinhado, e necessario adicionar no final da stack a largura como largura da tela, para que a stack ocupe tudo e o alinhamento da stack como leading
 
 5 - Ponto mais simples, mas basicamente a Preview naturalmente tem com problemas com pilhas de navegação. Para funcionar o clique no mapa ele pos o predator Detail dentro de uma NavigationStack. Duvida, eu preciso de outro NavigationStack , acho que nao pelo oque me parece
 */

#Preview {
    let predator = Predators().apexPredators[7]
    NavigationStack {
        PredatorDetail(
            predator: predator,
            position: .camera(
                MapCamera(
                    centerCoordinate: predator.location,
                    distance: 30000
                )
            )
        )
    }
}
