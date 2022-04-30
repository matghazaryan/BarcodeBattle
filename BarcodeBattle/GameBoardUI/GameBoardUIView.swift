//
//  GameBoardUIView.swift
//  BarcodeBattle
//
//  Created by Matevos Ghazaryan on 4/30/22.
//

import SwiftUI
import LoadingButton
import CarBode
import CodeScanner

struct GameBoardUIView: View {
    var name: String
    var gameBoardViewModel: GameBoardViewModel
    
    @State private var isLoading: Bool = false
    @State private var isLinkActive = false
    @State private var isTextHidden = true
    
    @State private var isPresentingScanner = false
    @State private var isWarriorScanned = false
    @State private var isMonsterScanned = false
    @State private var isAttackButtonHidden = true
    @State private var isWarriorHeartGained = false
    @State private var isMonsterHeartGained = false
    @State private var isScanBarcodeHidden = false
    @State private var notAllowedToGainLife = false
    @State private var nextTurn = true
    
    init(name: String, gameBoardViewModel: GameBoardViewModel){
        self.name = name
        self.gameBoardViewModel = gameBoardViewModel
    }
    
    var body: some View {
        VStack {
            HStack{
                Text("warrior").padding(.leading,10)
                Spacer()
                Text("monster").padding(.trailing,10)
            }
            HStack{
                Image("warrior").resizable().frame(width: 48, height: 48).padding(.leading,10).blur(radius: nextTurn ? 0: 3)
                Spacer()
                Image("monster").resizable().frame(width: 48, height: 48).padding(.trailing,10).blur(radius: !nextTurn ? 0: 3)
            }
            
            HStack{
                Image("heart").resizable().frame(width: 16, height: 16).padding(.leading,10)
                Text(isWarriorHeartGained ? "\(gameBoardViewModel.getCurrentWarriorLife()) (+1)"
                     : "\(gameBoardViewModel.getCurrentWarriorLife())").padding(.leading,3)
                
                Spacer()
                
                Image("heart").resizable().frame(width: 16, height: 16)
                Text(isMonsterHeartGained ? "\(gameBoardViewModel.getCurrenMonsterLife()) (+1)"
                     : "\(gameBoardViewModel.getCurrenMonsterLife())").padding(.trailing,10)
            }
            Divider()
            
            HStack {//handle energy part
                Text(isWarriorScanned ? gameBoardViewModel.generateMonsterEnergyValue() : "-").padding(.leading,10)
                Spacer()
                Text("Energy").foregroundColor(Color.white).padding(5)
                    .background(Rectangle().stroke().background(Color.green))
                Spacer()
                Text(isMonsterScanned ? gameBoardViewModel.generateMonsterEnergyValue() : "-").padding(.trailing,10)
            }.padding(.bottom,10)
            
            HStack {//handle attack part
                Text(isWarriorScanned ? gameBoardViewModel.generateWarriorAttackValue() : "-").padding(.leading,10)
                Spacer()
                Text("Attack").foregroundColor(Color.white).padding(5)
                    .background(Rectangle().stroke().background(Color.red))
                Spacer()
                Text(isMonsterScanned ? gameBoardViewModel.generateWarriorAttackValue() : "-").padding(.trailing,10)
            }.padding(.bottom,10)
            
            HStack {//handle deffance part
                Text(isWarriorScanned ? gameBoardViewModel.generateMonsterDeffenceValue() : "-").padding(.leading,10)
                Spacer()
                Text("Deffance").foregroundColor(Color.white).padding(5)
                    .background(Rectangle().stroke().background(Color.blue))
                Spacer()
                Text(isMonsterScanned ? gameBoardViewModel.generateMonsterDeffenceValue() : "-").padding(.trailing,10)
                
            }.padding(.bottom,10)
            Divider()
            
            VStack {
                
                Button("Scan QR code", action: {
                    applyLogicAfterPressingScanBarcode()
                }).buttonStyle(BaseButtonStyle()).opacity(isScanBarcodeHidden ? 0.0: 1.0)
                
                let style = LoadingButtonStyle(
                    cornerRadius: 27,
                    backgroundColor: .orange,
                    loadingColor: Color.orange.opacity(0.5),
                    strokeWidth: 5,
                    strokeColor: .gray)
                LoadingButton(action: {
                    //Fake loading
                    applyLogicAfterPressingAttack()
                }, isLoading: $isLoading,style: style) {
                    Text("Attack!!!").foregroundColor(Color.white)
                }.opacity(isAttackButtonHidden ? 0.0: 1.0)
                
                if(gameBoardViewModel.isWarriorWon()){
                    if (gameBoardViewModel.getCurrenMonsterLife() == 0){
                        Text("\(name) You won final round :) GAME IS OVER. Press Scan barcode to start game again").opacity(isTextHidden ? 0: 1).padding(.top,20).font(.title).foregroundColor(Color.green)
                    } else {
                        Text("\(name) You won \(gameBoardViewModel.round) round :)").opacity(isTextHidden ? 0: 1).padding(.top,20).font(.title).foregroundColor(Color.green)
                    }
                    
                } else {
                    if (gameBoardViewModel.getCurrentWarriorLife() == 0){
                        Text("\(name) You lost final :( GAME IS OVER. Press Scan barcode to start game again").opacity(isTextHidden ? 0: 1).padding(.top,20).font(.title).foregroundColor(Color.red)
                    } else {
                        Text("\(name) You lost \(gameBoardViewModel.round) :(").opacity(isTextHidden ? 0: 1).padding(.top,20).font(.title).foregroundColor(Color.red)
                    }
                    
                }
                
                Text(notAllowedToGainLife ? "Gain life possible if you have only 1 life" : "").foregroundColor(Color.red)
                
            }.sheet(isPresented: $isPresentingScanner) {
                CodeScannerView(codeTypes: [.qr]) { response in
                    if case let .success(result) = response {
                        isPresentingScanner = false//hide scannerview
                        
                        let dataFromScanner = result.string//get scanned data
                        if(dataFromScanner == CardType.WARIOR.rawValue){
                            applyWarriorScannedLogic()
                        } else if(dataFromScanner == CardType.MONSTER.rawValue){
                           applyMonsterScannedLogic()
                        } else if(dataFromScanner == CardType.POWER_UP.rawValue){
                            applyPowerUpScannedLogic()
                        }
                        
                        applyAttackButtonAppearsLogic()
                    }
                }
            }
            Spacer()
        }
    }
    
    private func applyWarriorScannedLogic(){
        isWarriorScanned = true
        notAllowedToGainLife = false
        isWarriorHeartGained = false
        nextTurn = !nextTurn
    }
    
    private func applyMonsterScannedLogic(){
        isMonsterScanned = true
        notAllowedToGainLife = false
        isMonsterHeartGained = false
        nextTurn = !nextTurn
    }
    
    private func applyPowerUpScannedLogic(){
        if(gameBoardViewModel.isWarriorCanGainLife()){
            isWarriorHeartGained = true
            isMonsterHeartGained = false
            nextTurn = !nextTurn
            gameBoardViewModel.increaseWarrerLifeByOne()
        } else {
            notAllowedToGainLife = (gameBoardViewModel.getCurrentWarriorLife() > 1)
        }
        
        if(gameBoardViewModel.isMonsterCanGainLife()){
            isWarriorHeartGained = false
            isMonsterHeartGained = true
            nextTurn = !nextTurn
            gameBoardViewModel.increaseMonsterLifeByOne()
        } else {
            notAllowedToGainLife = (gameBoardViewModel.getCurrenMonsterLife() > 1)
            
        }
    }
    
    private func applyAttackButtonAppearsLogic(){
        if(isWarriorScanned && isMonsterScanned){
            isAttackButtonHidden = false
            isScanBarcodeHidden = true
        }
    }
    
    private func applyLogicAfterPressingAttack(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if (gameBoardViewModel.isWarriorWon()){
                gameBoardViewModel.decreaseMonsterLifeByOne()
            } else {
                gameBoardViewModel.decreaseWarrerLifeByOne()
            }
            gameBoardViewModel.nextRound()
            isTextHidden = false
            isLoading = false
            isScanBarcodeHidden = false
            isAttackButtonHidden = true
            isWarriorScanned = false
            isMonsterScanned = false
        }
    }
    
    private func applyLogicAfterPressingScanBarcode(){
        self.isLinkActive = true
        self.isTextHidden = true
        isPresentingScanner = true
        gameBoardViewModel.resetLifesIfNeeded()
    }
}

