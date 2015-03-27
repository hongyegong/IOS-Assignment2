//
//  ViewControllerEntry.swift
//  BlackJack
//
//  Created by Hongye Gong on 15/2/11.
//  Copyright (c) 2015 Hongye Gong. All rights reserved.
//

import UIKit
import Foundation

class ViewControllerEntry: UIViewController {
    @IBOutlet var numDecks: UITextField!
    @IBOutlet var numPlayers: UITextField!
    var alert : UIAlertView!
    
    
    @IBAction func startGame(sender: UIButton) {
        if (numPlayers.text.toInt() > 4 || numPlayers.text == nil || numPlayers.text.toInt() <= 0) {
            alert.message = "Number of Players exceeds 4 players"
            alert.show()}
        else if (numDecks.text.toInt() > 8 || numDecks.text == nil || numDecks.text.toInt() <= 0) {
            alert.message = "Number of decks exceeds 8 decks"
            alert.show()}
        else {self.performSegueWithIdentifier("javlon", sender: self)}
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        alert = UIAlertView()
        alert.title = "Error"
        alert.addButtonWithTitle("OK")
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
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
        }
    }
    
}
