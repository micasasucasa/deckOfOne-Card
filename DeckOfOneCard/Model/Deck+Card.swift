//
//  Deck+Card.swift
//  DeckOfOneCard
//
//  Created by micasasucasa on 2/4/19.
//  Copyright © 2019 Jacob Rosevear. All rights reserved.
//

import Foundation

struct TopLevelDictionary : Codable {
    let cards: [Card]
    
}

struct Card: Codable {
    let value: String
    let suit: String
    let image: String
}
