//
//  ContentView.swift
//  DinosPark
//
//  Created by Lucca Filizzola on 19/07/26.
//

import SwiftUI

struct ContentView: View {
    let predators = Predators()
    @State var searchTerm: String = ""
    @State var alphabetical = false
    @State var currentSelection = ApType.all
    
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
        return predators.search(for: searchTerm)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDinos) { predator in
                NavigationLink {
                    PredatorDetail(predator: predator)
                } label: {
                    HStack {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading) {
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.backgroundColor)
                                .clipShape(.capsule)
                        }
                    }
                    
                }
            }
            .navigationTitle("Dinos Park")
            .searchable(text: $searchTerm, placement: .navigationBarDrawer)
            .autocorrectionDisabled()
            .animation(.default, value: searchTerm)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation{
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentSelection.animation()) {
                            ForEach(ApType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}
/*
 Anotações interessantes
 
 1 - List
 Ela ja vem embutida como lazy, logo ela so vai redenrizar oque precisar mostrar pro usuário, deixando o app mais
 leve. Diferente do forEach, ela também já vem com o scrolling
 
 2 - Perguntar pro claude como a tela ouve essas mudanças, a list fica ouvindo as mudanças das propriedades state, toda vez que uma state muda a tela recarrega, era isso neh ?
 
 Cada @State é uma fonte de verdade que o SwiftUI observa. No teu caso são três:

 Quando qualquer uma delas muda (o usuário digita na busca, toca no botão de ordenar, ou escolhe um filtro), o SwiftUI faz o seguinte:

 Marca a View como "inválida" (precisa ser recalculada).
 Chama de novo o body — ou seja, o var body: some View roda inteiro outra vez.
 Como o body acessa filteredDinos, essa propriedade computada roda de novo, refiltra/reordena/busca, e devolve a lista atualizada.
 O SwiftUI compara o resultado novo com o antigo e atualiza só o que mudou na tela (diffing). Ele não redesenha tudo do zero.
 O ponto importante que costuma confundir
 Não é a List que "fica ouvindo". Quem observa é o @State. A List só é reconstruída porque ela faz parte do body, e o body inteiro é reexecutado quando um @State muda.

 E — detalhe crucial — o SwiftUI só reage a @State que o body realmente lê. Se você tivesse um @State que ninguém usa dentro do body, mudá-lo não redesenharia nada.

 No teu código especificamente
 O filteredDinos é uma propriedade computada, então ele roda toda vez que o body roda:

 Como ele lê as três @State, qualquer mudança em qualquer uma delas dispara o recálculo. É exatamente o fluxo reativo que você descreveu.

 Um resumo mental que ajuda: @State muda → body roda de novo → SwiftUI compara e atualiza só a diferença na tela.
 
 3 Diferença entre @State, @Binding e @Observable/@StateObject
 
 @State
 Fonte de verdade local de uma view. Guarda um valor simples (String, Bool, struct) que pertence àquela view. Muda → o body roda de novo.

 @Binding
 Uma referência a um @State que vive em outra view. Não guarda nada; só empresta acesso de leitura+escrita pro filho. Por isso o $:

 O $searchTerm que você já usa no .searchable é exatamente isso: você entrega o binding pro campo de busca escrever de volta no teu @State.

 @Observable / @StateObject
 Pra objetos de classe com estado compartilhado e lógica (models, serviços). Enquanto @State é pra valor simples de uma tela, aqui é um objeto que várias views podem observar.

 @Observable (macro nova, iOS 17+): você marca a classe e o SwiftUI passa a observar só as propriedades que cada view realmente lê.
 @StateObject: a view que cria e é dona do objeto (só instancia uma vez, sobrevive a re-renders).
 @ObservedObject: a view que recebe um objeto criado por outra (não é dona).
 */

#Preview {
    ContentView()
}
