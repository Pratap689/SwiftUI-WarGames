//
//  ContentView.swift
//  SwiftUIWarGames
//
//  Created by netset on 15/02/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var playerCard: String = "card2"
    @State var cpuCard: String = "card3"
    @State var playerScore: Int = 0
    @State var cpuScore: Int = 0
    @State var declareWin: Int = 0
    @State var winText: String = "It's a Tie"
    @State var isPresented: Bool = false
    @State var showSheet: Bool = false
    var body: some View {
//        ScrollView {
            ZStack {
                Image("background")
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("logo")
                    Spacer()
                    HStack {
                        Spacer()
                        Image(playerCard)
                        Spacer()
                        Image(cpuCard)
                        Spacer()
                    }
                    Spacer()
                    showAlert()//For now i am using sheet to present view we will remove it when push issue will be resolved sir
                        .sheet(isPresented: $showSheet) {
                        reset()
                    } content: {
                        SlotChallengeView()
                    }
                    Spacer()
                    HStack {
                        VStack {
                            Text("Player")
                                .font(.title)
                                .padding()
                                .foregroundColor(.white)
                            Text(String(playerScore))
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        VStack {
                            Text("CPU")
                                .font(.title)
                                .padding()
                                .foregroundColor(.white)
                            Text(String(cpuScore))
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
            }
//        }.ignoresSafeArea()
    }
    
    
    func performLogic() {
        let cpuscore = Int.random(in: 2...14)
        let playerscore = Int.random(in: 2...14)
        playerCard = "card" + String(playerscore)
        declareWin += 1
        if declareWin == 21 {
            isPresented = true
            winText = cpuScore == playerScore ? "It's a Tie": cpuScore > playerScore ? "CPU Wins": "Player Wins"
            return
        }
        print("yeah it is executing")
        cpuCard = "card" + String(cpuscore)
        if playerscore > cpuscore {
            playerScore += 1
        } else if cpuscore > playerscore {
            cpuScore += 1
        }
    }
    
    func showAlert() -> some View {
        Button {
            performLogic()
        } label: {
            Image("dealbutton")
        }.alert(Text(winText), isPresented: $isPresented) {
            
            ////
            ///EK aur issue bhai idhar alert mai maine do buttons lie to show two buttons but i don't want to use like that.
            /// I Just want to use AlertView Like UIKit jisme ok cancel ka button le skte hai hum
            /// uska code ye hai below but ye b error de rha hai ki kyuki Alert Struct View Protocol ko conform NI krta. Comment Kia hai abhi
            ///
            
//            Alert(
//                title: Text("Are you sure you want to delete this?"),
//                message: Text("There is no undo"),
//                primaryButton: .destructive(Text("Delete")) {
//                    print("Deleting...")
//                },
//                secondaryButton: .cancel()
//            )
            
            VStack {
                Button("Goto Next Task", role: .cancel, action: {
                    showSheet = true
                  //  reset()
                    /// This is the issue. I need to navigate on this button click
                    //NavigationLink("", destination: SlotChallengeView())
                })
                Button("Cancel") {}
            }
        }
    }
    
    func reset() {
        isPresented = false
        declareWin = 0
        cpuScore = 0
        playerScore = 0
        cpuCard = "card3"
        playerCard = "card2"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
