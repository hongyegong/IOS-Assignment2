//
//  Game.swift
//  BlackJack
//
//  Created by Hongye Gong on 15/2/11.
//  Copyright (c) 2015 Hongye Gong. All rights reserved.
//

import Foundation
import UIKit

class Game {
    var shoe:Shoe
    var players:[Player] = []
    var dealer: Dealer = Dealer()
    var currentPlayer:Int = 0
    var currentDeck:Int = 0
    var allOut:Bool = false
    
    //constructor
    init (deckSize:Int, playerNumber:Int) {
        //shoe reference
        shoe = Shoe(number: deckSize)
        //depending on users input, appropiate number of players is created.
        for i in 0..<playerNumber { addPlayer() }
        //initially each player is given 2 cards.
//        for stud in players {for i in 0..<2{stud.addCard(getCard(currentDeck)!)}}
//        dealer.addCard(getCard(currentDeck)!)
//        dealer.addCard(getCard(currentDeck)!)
//        
//        
//        
//        //dealer's hidden card will be stored in a temporary variable, cardBack picture will replace it.
//        dealer.hiddenCard = dealer.cards[0]
//        dealer.cards[0].image = UIImage(named: "hiddencard.jpg")
    }
    
    //adding new player to the game
    func addPlayer() {
        var newPlayer:Player = Player();
        players.append(newPlayer)
    }
    
    //gets a card from the Shoe and current deck
    func getCard(deckNdx:Int) -> Card? {
        if (shoe.decks[currentDeck].cards.count <= 10 ) {
            shoe.decks[currentDeck].shuffle()
            currentDeck = currentDeck + 1
            if currentDeck > shoe.decks.count {
                currentDeck = 0
            }
        }
        return shoe.decks[deckNdx].drawCard()!
    }
    
    func deal() {
        for stud in players {
            if !stud.isOut {
                for i in 0..<2{stud.addCard(getCard(currentDeck)!)}
                }
            }
        dealer.addCard(getCard(currentDeck)!)
        dealer.addCard(getCard(currentDeck)!)
        
        
        
        //dealer's hidden card will be stored in a temporary variable, cardBack picture will replace it.
        dealer.hiddenCard = dealer.cards[0]
        dealer.cards[0].image = UIImage(named: "hiddencard.jpg")
    }
    //calls the hit function for player at playerNdx index
    func hit (playerNdx:Int) {
        var card = getCard(currentDeck)
        players[playerNdx].addCard(card!)
    }
    
    //calls the stand function for player at playerNdx index
    func stand (playerNdx:Int) {
        if (players[playerNdx].stand == false ) {
            players[playerNdx].setStand = true
            currentPlayer = currentPlayer + 1
            if (currentPlayer > players.count - 1) {currentPlayer = 0}
        }
        else {
            currentPlayer = currentPlayer + 1
            if (currentPlayer > players.count - 1) {currentPlayer = 0}
        }
    }
    
    
}
