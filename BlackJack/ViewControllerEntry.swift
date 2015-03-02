//
//  viewControllerEntry.swift
//  BlackJack
//
//  Created by 鸿烨 弓 on 15/2/22.
//  Copyright (c) 2015年 鸿烨 弓. All rights reserved.
//

import UIKit
import Foundation

class ViewControllerEntry: UIViewController {
    
    
    @IBOutlet var numPlayers: UITextField!
    
    @IBOutlet var numDecks: UITextField!
    var alert : UIAlertView!
    
    @IBAction func startGame(sender: UIButton) {
        if (numPlayers.text.toInt() > 2) {
            alert.message = "Number of Players exceeds 2 players"
            alert.show()
            return}
        else if (numDecks.text.toInt() > 8) {
            alert.message = "Number of decks exceeds 8 decks"
            alert.show()
            return}
        else {self.performSegueWithIdentifier("javlon", sender: self)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        alert = UIAlertView()
        alert.title = "Error"
        alert.addButtonWithTitle("OK")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "javlon") {
            let svc = segue.destinationViewController as ViewController
            svc.numDecks = numDecks.text.toInt()
            svc.numPlayers = numPlayers.text.toInt()
            if (numPlayers.text.toInt() > 2) {
                alert.message = "Number of Players exceeds 2 players"
                alert.show()
                svc.numPlayers = 2}
            else if (numDecks.text.toInt() > 8) {
                alert.message = "Number of decks exceeds 8 decks"
                alert.show()
                svc.numDecks = 8}
        }
        
        
    }
    
}