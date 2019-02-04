//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by micasasucasa on 2/4/19.
//  Copyright © 2019 Jacob Rosevear. All rights reserved.
//

import Foundation

class CardController {
    
    //CRUD
    //MARK: Create
    // Base URL
    private static let baseURL  = URL(string:"https://deckofcardsapi.com/api/deck/new/draw/")
    
    static func drawCard(numberOfCards: Int, completion: @escaping ((_ cards: [Card]) -> Void)) {
        //build my url
        guard let url = baseURL else { fatalError("URL optional is having issues")}
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let countQueryItem = URLQueryItem(name: "count", value: "\(numberOfCards)")
        components?.queryItems = [countQueryItem]
        //build my request
        guard let requestURL = components?.url  else { return }
        print(requestURL)
        
        //Get my data
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        //data task
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            do {
                if let downloadError = error { throw downloadError }
                guard let data = data else { throw NSError()}
                
                //Decode
                let jsonDecoder = JSONDecoder()
                let deck = try! jsonDecoder.decode(TopLevelDictionary.self, from: data)
                completion(deck.cards)
            } catch {
                print("Error retreiving cards from \(requestURL)")
                completion ([])
                return
            }
            //Handle my data and errors accoringly
            // complete with my cards
        })
        dataTask.resume()
}
}
