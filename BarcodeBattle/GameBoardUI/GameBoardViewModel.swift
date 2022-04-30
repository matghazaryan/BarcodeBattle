//
//  GameBoardManager.swift
//  BarcodeBattle
//
//  Created by Matevos Ghazaryan on 4/30/22.
//

import Foundation
import SwiftUI

class GameBoardViewModel {
    var warriorEnergy = 0
    var warriorAttack = 0
    var warriorDefence = 0
    
    var monsterEnergy = 0
    var monsterAttack = 0
    var monsterDefence = 0
    
    private var warriorLife = 3
    private var monsterLife = 3
    
    var round = 0    
    
    init(){}
    
    private func generateRandomNumber() -> Int{
        let randomInt = Int.random(in: 1..<9)
        return randomInt * 1000
    }
    
    func generateWarriorEnergyValue() -> String{
        warriorEnergy = generateRandomNumber()
        return String(warriorEnergy)
    }
    
    func generateWarriorAttackValue() -> String{
        warriorAttack = generateRandomNumber()
        return String(warriorAttack)
    }
    
    func generateWarriorDeffenceValue() -> String{
        warriorDefence = generateRandomNumber()
        return String(warriorDefence)
    }
    
    func generateMonsterEnergyValue() -> String{
        monsterEnergy = generateRandomNumber()
        return String(monsterEnergy)
    }
    
    func generateMonsterAttackValue() -> String{
        monsterAttack = generateRandomNumber()
        return String(monsterAttack)
    }
    
    func generateMonsterDeffenceValue() -> String{
        monsterDefence = generateRandomNumber()
        return String(monsterDefence)
    }
    
    func increaseWarrerLifeByOne(){
        self.warriorLife+=1
    }
    
    func decreaseWarrerLifeByOne(){
        self.warriorLife-=1
    }
    
    func increaseMonsterLifeByOne(){
        self.monsterLife+=1
    }
    
    func decreaseMonsterLifeByOne(){
        self.monsterLife-=1
    }
    
    func getCurrentWarriorLife() -> Int {
        return self.warriorLife
    }
    
    func getCurrenMonsterLife() -> Int {
        return self.monsterLife
    }
    
    func isWarriorCanGainLife() -> Bool{
        return getCurrentWarriorLife() == 1
    }
    
    func isMonsterCanGainLife() -> Bool{
        return getCurrenMonsterLife() == 1
    }
    
    func getScannedCardType(data: String)-> CardType {
        if(data == CardType.WARIOR.rawValue){
            return CardType.WARIOR
        } else if (data == CardType.MONSTER.rawValue){
            return CardType.MONSTER
        } else if (data  == CardType.POWER_UP.rawValue){
            return CardType.POWER_UP
        }
        return CardType.NONE
    }
    
    func isWarriorWon() -> Bool{
        let w = warriorEnergy + warriorAttack - warriorDefence
        let m = monsterEnergy + monsterAttack - monsterDefence
        return w >= m
    }
    
    func isGameOver() -> Bool {
        return (warriorLife == 0 || monsterLife == 0) 
    }
    
    func nextRound(){
        round += 1
    }
    
    func resetLifesIfNeeded(){
        if(getCurrenMonsterLife() == 0 || getCurrenMonsterLife() == 0){
            warriorLife = 3
            monsterLife = 3
            round = 0
        }
    }
}

enum CardType : String {
    case NONE = "0",
         WARIOR = "1",
         MONSTER = "2",
         POWER_UP = "3"
}

