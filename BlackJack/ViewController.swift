//
//  ViewController.swift
//  BlackJack
//
//  Created by Hongye Gong on 15/2/11.
//  Copyright (c) 2015 Hongye Gong. All rights reserved.
//

import UIKit
import Darwin
import Foundation

//fetch the last element of an array
extension Array {
    var last: T {
        return self[self.endIndex - 1]
    }
}

class ViewController: UIViewController {
    var numDecks:Int!
    var numPlayers:Int!
    var blackjack:Game!
    var gamecount : Int = 0
    var isstart:Bool = false
    var bet:Int = 0
    var firstin:Bool = true
    var timer = NSTimer()
    
    @IBOutlet weak var prompt: UILabel!
    //Misc UI elements
    var plOneImages:[UIImageView] = []
    var plTwoImages:[UIImageView] = []
    var plThreeImages:[UIImageView] = []
    var plFourImages:[UIImageView] = []
    var dealerImages:[UIImageView] = []
    var plImages:[[UIImageView]] = []
    var plScores:[UILabel] = []
    var plTurns:[UIImageView] = []
    var plBets:[UITextField] = []
    var plSums: [UILabel] = []
    
    @IBOutlet weak var dealButton: UIButton!
    
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var standButton: UIButton!
    
    @IBOutlet weak var plOneSum: UILabel!
    @IBOutlet weak var plOneBet: UITextField!
    @IBOutlet weak var plTwoSum: UILabel!
    @IBOutlet weak var plTwoBet: UITextField!
    @IBOutlet weak var plThreeSum: UILabel!
    @IBOutlet weak var plThreeBet: UITextField!
    @IBOutlet weak var plFourSum: UILabel!
    @IBOutlet weak var plFourBet: UITextField!
    
    
    @IBOutlet weak var plOneTurn: UIImageView!
    @IBOutlet weak var plTwoTurn: UIImageView!
    @IBOutlet weak var plThreeTurn: UIImageView!
    @IBOutlet weak var plFourTurn: UIImageView!
    
    
    //player1 cards UIImages
    @IBOutlet weak var plOneImageOne: UIImageView!
    @IBOutlet weak var plOneImageTwo: UIImageView!
    @IBOutlet weak var plOneImageThree: UIImageView!
    @IBOutlet weak var plOneImageFour: UIImageView!
    @IBOutlet weak var plOneImageFive: UIImageView!
    @IBOutlet weak var plOneImageSix: UIImageView!
    @IBOutlet weak var plOneScore: UILabel!
    
    
    //player2 cards UIImages
    @IBOutlet weak var plTwoImageOne: UIImageView!
    @IBOutlet weak var plTwoImageTwo: UIImageView!
    @IBOutlet weak var plTwoImageThree: UIImageView!
    @IBOutlet weak var plTwoImageFour: UIImageView!
    @IBOutlet weak var plTwoImageFive: UIImageView!
    @IBOutlet weak var plTwoScore: UILabel!
    @IBOutlet weak var plTwoImageSix: UIImageView!
    
    //player3 cards UIImages
    @IBOutlet weak var plThreeImageOne: UIImageView!
    @IBOutlet weak var plThreeImageTwo: UIImageView!
    @IBOutlet weak var plThreeImageThree: UIImageView!
    @IBOutlet weak var plThreeImageFour: UIImageView!
    @IBOutlet weak var plThreeImageFive: UIImageView!
    @IBOutlet weak var plThreeImageSix: UIImageView!
    @IBOutlet weak var plThreeScore: UILabel!
    
    
    //player4 cards UIImages
    @IBOutlet weak var plFourImageOne: UIImageView!
    @IBOutlet weak var plFourImageTwo: UIImageView!
    @IBOutlet weak var plFourImageThree: UIImageView!
    @IBOutlet weak var plFourImageFour: UIImageView!
    @IBOutlet weak var plFourImageFive: UIImageView!
    @IBOutlet weak var plFourImageSix: UIImageView!
    @IBOutlet weak var plFourScore: UILabel!
    
    
    //dealer cards UIImages
    @IBOutlet weak var dealerImageOne: UIImageView!
    @IBOutlet weak var dealerImageTwo: UIImageView!
    @IBOutlet weak var dealerImageThree: UIImageView!
    @IBOutlet weak var dealerImageFour: UIImageView!
    @IBOutlet weak var dealerImageFive: UIImageView!
    @IBOutlet weak var dealerScore: UILabel!
    

    @IBAction func back(sender: UIButton) {
        //view.removeFromSuperview()
    }
    
    //hit function that calls players hit functions
    @IBAction func hit(sender: UIButton) {
        //if !isBet() {return}
        blackjack.hit(blackjack.currentPlayer)
        plImages[blackjack.currentPlayer][blackjack.players[blackjack.currentPlayer].cards.count - 1].alpha = 1
        //println(blackjack.players[blackjack.currentPlayer].checkScore().intScore)
        var temp:Int = blackjack.players[blackjack.currentPlayer].checkScore().intScore
        if ( temp > 21) {
            for x in 0..<blackjack.players[blackjack.currentPlayer].cards.count {plImages[blackjack.currentPlayer][x].alpha = 0.1}
            plTurns[blackjack.currentPlayer].hidden = true
            blackjack.stand(blackjack.currentPlayer)
        };getPlayerStats()
    }
    
    func hitAI() {
        blackjack.hit(blackjack.currentPlayer)
        plImages[blackjack.currentPlayer][blackjack.players[blackjack.currentPlayer].cards.count - 1].alpha = 1
        //println(blackjack.players[blackjack.currentPlayer].checkScore().intScore)
//        if blackjack.players[blackjack.currentPlayer].checkScore().intScore >= 17 {
//            self.timer.fire()
//        }
        
        
        var temp:Int = blackjack.players[blackjack.currentPlayer].checkScore().intScore
        if ( temp > 21) {
            for x in 0..<blackjack.players[blackjack.currentPlayer].cards.count {plImages[blackjack.currentPlayer][x].alpha = 0.1}
            plTurns[blackjack.currentPlayer].hidden = true
            blackjack.stand(blackjack.currentPlayer)
        };getPlayerStats()
    }
    
    //stand function that calls players stand function
    @IBAction func stand(sender: UIButton) {
        plTurns[blackjack.currentPlayer].hidden = true
        blackjack.stand(blackjack.currentPlayer)
        getPlayerStats()
        
    }
    
    func standAI() {
        plTurns[blackjack.currentPlayer].hidden = true
        blackjack.stand(blackjack.currentPlayer)
        getPlayerStats()
    }
    
    func refresh() {
        
        for i in 0..<blackjack.players.count {
            if !blackjack.players[i].isOut {
                for x in 0..<blackjack.players[i].cards.count {
                    plImages[i][x].image = blackjack.players[i].cards[x].image
                    plScores[i].text = blackjack.players[i].checkScore().strScore
                }
            }
        }
        for k in 0..<blackjack.dealer.cards.count {dealerImages[k].image = blackjack.dealer.cards[k].image}
    }
    
    func toDouble(str: String) -> Double? {
        var formatter = NSNumberFormatter()
        if let number = formatter.numberFromString(str) {
            return number.doubleValue
        }
        return nil
    }
    
    func isBet() -> Bool{
        for i in 0..<blackjack.players.count {if(!blackjack.players[i].isOut && i != 1){
            
            if(toDouble(plBets[i].text) == nil || plBets[i].text.toInt() < 0 || plBets[i].text.toInt() > blackjack.players[i].amount){
                let alertController = UIAlertController(title: "BlackJack", message:
                    "Please bet a proper number!", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                return false
            }else if(plBets[i].text.toInt() == 0 && isstart == true){
                let alertController = UIAlertController(title: "BlackJack", message:
                    "Please Bet!", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                return false
                
            }}}
        return true
    }
    
    //function will be called to get cards of each player and display them in each players UIImageView
    func getPlayerStats() {
        
        var stand:Int = 0
        refresh()
        dealerScore.text = blackjack.dealer.checkScore("hidden").strScore
        if !blackjack.players[blackjack.currentPlayer].isOut {
            plTurns[blackjack.currentPlayer].hidden = false
        }
        //if number of stands matches number players, that means dealer can go
        for i in 0..<blackjack.players.count {
            if (blackjack.players[i].stand == true || blackjack.players[i].isOut) {
                stand = stand + 1
            }
        }
        
        if(blackjack.currentPlayer == 1 && firstin) {
            firstin = false
            plBets[blackjack.currentPlayer].text = "20"
            
            blackjack.players[blackjack.currentPlayer].amount -= plBets[blackjack.currentPlayer].text.toInt()!
            //println(blackjack.players[blackjack.currentPlayer].amount)
            while (blackjack.players[blackjack.currentPlayer].checkScore().intScore < 17 && blackjack.currentPlayer == 1) {
                
                hitAI()
            }
            if blackjack.currentPlayer == 1 {standAI()}
            
        }
        
        //if all plays stood, code below gets executed
        println(stand)
        if (stand == blackjack.players.count) {
            dealerImages[0].image = blackjack.dealer.unhide()?.image
            plTurns[blackjack.currentPlayer].hidden = true
            hitButton.hidden = true;standButton.hidden = true
            while (blackjack.dealer.checkScore("s").intScore < 16) {blackjack.dealer.addCard(blackjack.getCard(blackjack.currentDeck)!)}
            dealerScore.text = blackjack.dealer.checkScore("a").strScore
            for i in 0..<plImages.count {for x in 0..<plImages[i].count {plImages[i][x].alpha = 0.1} }
            for i in 0..<dealerImages.count {dealerImages[i].alpha = 0.1}
            for i in 0..<blackjack.players.count { if !blackjack.players[i].isOut{
                    plScores[i].text = checkScore(blackjack.players[i].checkScore().intScore, dealerScore: blackjack.dealer.checkScore("a").intScore).str
                }
            }
            for i in 0..<blackjack.players.count {
                if !blackjack.players[i].isOut{
                    var result = checkScore(blackjack.players[i].checkScore().intScore, dealerScore: blackjack.dealer.checkScore("a").intScore).ret
                    if result == 1 {
                        blackjack.players[i].amount += plBets[i].text.toInt()! * 2
                    }else if result == 0{
                        blackjack.players[i].amount += plBets[i].text.toInt()!
                    }
                    plSums[i].text = "\(blackjack.players[i].amount)"
                }
            }
            for i in 0..<blackjack.players.count {
                if(blackjack.players[i].amount < 1){
                    plTurns[i].hidden = true
                    blackjack.players[i].isOut = true
                    plSums[i].text = "OUT"
                    for j in 0..<blackjack.players.count {
                        if(!blackjack.players[j].isOut ){
                            break
                        }
                        if(j == blackjack.players.count - 1) {
                            blackjack.allOut = true
                        }
                    }
                    if blackjack.allOut{
                        let alertController = UIAlertController(title: "BlackJack", message:
                            "GAME OVER!", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Restart", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                        for k in 0..<blackjack.players.count {for x in 0..<blackjack.players[i].cards.count {plImages[k][x].image = nil}}
                        for k in 0..<blackjack.dealer.cards.count {dealerImages[k].image = nil}
                        
                        for k in 0..<blackjack.players.count {plSums[k].text = "$"}
                        for k in 0..<blackjack.players.count {plScores[k].text = nil}
                        //revised
                        plScores.removeAll(keepCapacity: false)
                        plTurns.removeAll(keepCapacity: false)
                        plSums.removeAll(keepCapacity: false)
                        for k in 0..<plBets.count {plBets[k].text = "0"}
                        for x in blackjack.players {x.cards.removeAll(keepCapacity: false)}
                        blackjack.players.removeAll(keepCapacity: false)
                        blackjack.dealer.cards.removeAll(keepCapacity: false)
                        blackjack.allOut = false
                        newGame.hidden = true
                        hitButton.hidden = false
                        standButton.hidden = false
                        viewDidLoad()
                        return
                    }
                }
                
                
                
            }
            newGame.hidden = false
        }
        if !blackjack.players[blackjack.currentPlayer].isOut {
            plSums[blackjack.currentPlayer].text = "\(blackjack.players[blackjack.currentPlayer].amount)"
        }
//        var temp:Int = blackjack.players[blackjack.currentPlayer].amount - plBets[blackjack.currentPlayer].text.toInt()!
//        plSums[blackjack.currentPlayer].text = "\(temp)"
    }
    
    //to start a new game, all arrays gets emptied out and will be reinitialized
    
 
    @IBAction func Deal(sender: UIButton) {
        if !isBet(){return}
        
        prompt.hidden = true
        hitButton.hidden = false
        standButton.hidden = false
        dealButton.hidden = true
        blackjack.deal();
        
        for i in 0..<blackjack.players.count {
            if !blackjack.players[i].isOut && i != 1 {
                blackjack.players[i].amount -= plBets[i].text.toInt()!
                plSums[i].text = "\(blackjack.players[i].amount)"
            }
        }
        
        for i in 0..<blackjack.players.count {for x in 0..<blackjack.players[i].cards.count {plImages[i][x].alpha = 1}}
        for i in 0..<blackjack.dealer.cards.count {dealerImages[i].alpha = 1}
        
        for i in 0..<blackjack.players.count {plScores[i].text = "\(blackjack.players[i].checkScore().intScore)"}
        getPlayerStats()
    }
    
    @IBOutlet weak var newGame: UIButton!
    @IBAction func newGame(sender: UIButton) {
        gamecount = gamecount + 1
        //make shuffle after five games
        if(gamecount == 5){
            blackjack.shoe.decks[blackjack.currentDeck].shuffle()
            blackjack.shoe = Shoe(number: numDecks)
            gamecount = 0;
            
        }
        for x in blackjack.players {x.stand = false}  //new added
        for i in 0..<blackjack.players.count {for x in 0..<blackjack.players[i].cards.count {plImages[i][x].image = nil}}
        for i in 0..<blackjack.dealer.cards.count {dealerImages[i].image = nil}
        for k in 0..<blackjack.players.count {plScores[k].text = "0"}
        //dealerImages.removeAll(keepCapacity: false)
        //plScores.removeAll(keepCapacity: false)
        //plTurns.removeAll(keepCapacity: false)
        for x in blackjack.players {x.cards.removeAll(keepCapacity: false)}
        //blackjack.players.removeAll(keepCapacity: false)
        blackjack.dealer.cards.removeAll(keepCapacity: false)
        //viewDidLoad()
        //for i in 0..<blackjack.players.count {for x in 0..<blackjack.players[i].cards.count {plImages[i][x].alpha = 1}}
        //for i in 0..<blackjack.dealer.cards.count {dealerImages[i].alpha = 1}
        newGame.hidden = true
        hitButton.hidden = true
        standButton.hidden = true
        dealButton.hidden = false
        prompt.hidden = false
        firstin = true
        
        //new added
        blackjack.currentPlayer = 0;
        while blackjack.players[blackjack.currentPlayer].isOut {
            blackjack.currentPlayer++
        }
        
    }
    
    
    //by passing in dealers score and players score, comparison will be done and output will be returned. returned value will be used to displays plays status
    func checkScore(playerScore:Int, dealerScore:Int) -> (str:String, ret:Int) {
        if playerScore > 21 {
            return ("Over 21, you lost!", -1)
        }
        if dealerScore > 21  {
            return ("Dealer sucks, you won!", 1)
        }
        if dealerScore == 21 && playerScore != 21 {
            return ("Dealer has BlackJack, you lost!", -1)
        }
        if (playerScore == 21 && dealerScore != 21) {
            return ("BlackJack, you won!", 1)
        }
        if (playerScore > dealerScore) {
            return ("You Won", 1)
        }
        if dealerScore > playerScore {
            return ("House Won", -1)
        }
        return ("Tie", 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        plOneImages += [plOneImageOne, plOneImageTwo, plOneImageThree, plOneImageFour, plOneImageFive, plOneImageSix]
        plTwoImages += [plTwoImageOne, plTwoImageTwo,plTwoImageThree, plTwoImageFour, plTwoImageFive, plTwoImageSix]
        plThreeImages += [plThreeImageOne, plThreeImageTwo, plThreeImageThree, plThreeImageFour, plThreeImageFive, plThreeImageSix]
        plFourImages += [plFourImageOne, plFourImageTwo, plFourImageThree, plFourImageFour, plFourImageFive, plFourImageSix ]
        plImages += [plOneImages, plTwoImages, plThreeImages, plFourImages]
        dealerImages += [dealerImageOne, dealerImageTwo, dealerImageThree, dealerImageFour, dealerImageFive]
        plScores += [plOneScore, plTwoScore, plThreeScore, plFourScore]
        plTurns += [plOneTurn, plTwoTurn, plThreeTurn, plFourTurn]
        plBets += [plOneBet, plTwoBet, plThreeBet, plFourBet]
        plSums += [plOneSum, plTwoSum, plThreeSum, plFourSum]
        blackjack = Game(deckSize: numDecks,playerNumber: numPlayers)
        //getPlayerStats()
        isstart = true
        dealButton.hidden = false
        hitButton.hidden = true
        standButton.hidden = true
        //restartButtor.hidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

