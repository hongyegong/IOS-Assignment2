//
//  Card.swift
//  BlackJack
//
//  Created by Hongye Gong on 15/2/11.
//  Copyright (c) 2015 Hongye Gong. All rights reserved.
//

import Foundation
import UIKit
enum Suit: Character{
    case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
}

enum Rank: Int {
    case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King, Ace
    func simpleDescription() -> String {
        switch self {
        case .King:
            return "king"
        case .Queen:
            return "queen"
        case .Jack:
            return "jack"
        case .Ace:
            return "ace"
        default:
            return "\(self.rawValue)"
        }
    }
    struct Values {
        let first: Int, second: Int?
    }
    var values: Values {
        switch self {
        case .Ace:
            return Values(first: 1, second: 11)
        case .Jack, .Queen, .King:
            return Values(first: 10, second: nil)
        default:
            return Values(first: self.rawValue, second: nil)
            }
    }
}
struct Card {
    var currentCard:Int = 0
    var image:UIImage?
    var suit: Suit
    var rank: Rank
    var hidden:Bool = false
    init(rank: Rank, suit: Suit, imageFile: UIImage) {
        self.suit = suit
        self.rank = rank
        self.image = imageFile
    }
    var description: String {
        var output = "\(suit.rawValue),"
            output += "\(rank.values.first)"
            if let second = rank.values.second {
                output += " or \(second)"
            }
            return output
    }
}