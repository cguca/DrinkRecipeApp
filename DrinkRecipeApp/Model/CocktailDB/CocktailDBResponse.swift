//
//  CocktailDBResponse.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 5/29/21.
//

import Foundation

struct CocktailDBResponse: Codable {
    let drinks: [Drink]
    
    enum CodingKeys: String, CodingKey {
        case drinks
    }
}
