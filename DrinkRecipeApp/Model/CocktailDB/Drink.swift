//
//  Drink.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 5/29/21.
//

import Foundation

struct Drink : Codable {
    let idDrink : String?
    let strDrink : String?
    let strDrinkAlternate : String?
    let strTags : String?
    let strVideo : String?
    let strCategory : String?
    let strIBA : String?
    let strAlcoholic : String?
    let strGlass : String?
    let strInstructions : String?
    let strInstructionsES : String?
    let strInstructionsDE : String?
    let strInstructionsFR : String?
    let strInstructionsIT : String?
    let strInstructionsZHHANS : String?
    let strInstructionsZHHANT : String?
    let strDrinkThumb : String?
    let strIngredient1 : String?
    let strIngredient2 : String?
    let strIngredient3 : String?
    let strIngredient4 : String?
    let strIngredient5 : String?
    let strIngredient6 : String?
    let strIngredient7 : String?
    let strIngredient8 : String?
    let strIngredient9 : String?
    let strIngredient10 : String?
    let strIngredient11 : String?
    let strIngredient12 : String?
    let strIngredient13 : String?
    let strIngredient14 : String?
    let strIngredient15 : String?
    let strMeasure1 : String?
    let strMeasure2 : String?
    let strMeasure3 : String?
    let strMeasure4 : String?
    let strMeasure5 : String?
    let strMeasure6 : String?
    let strMeasure7 : String?
    let strMeasure8 : String?
    let strMeasure9 : String?
    let strMeasure10 : String?
    let strMeasure11 : String?
    let strMeasure12 : String?
    let strMeasure13 : String?
    let strMeasure14 : String?
    let strMeasure15 : String?
    let strImageSource : String?
    let strImageAttribution : String?
    let strCreativeCommonsConfirmed : String?
    let dateModified : String?

    enum CodingKeys: String, CodingKey {

        case idDrink = "idDrink"
        case strDrink = "strDrink"
        case strDrinkAlternate = "strDrinkAlternate"
        case strTags = "strTags"
        case strVideo = "strVideo"
        case strCategory = "strCategory"
        case strIBA = "strIBA"
        case strAlcoholic = "strAlcoholic"
        case strGlass = "strGlass"
        case strInstructions = "strInstructions"
        case strInstructionsES = "strInstructionsES"
        case strInstructionsDE = "strInstructionsDE"
        case strInstructionsFR = "strInstructionsFR"
        case strInstructionsIT = "strInstructionsIT"
        case strInstructionsZHHANS = "strInstructionsZH-HANS"
        case strInstructionsZHHANT = "strInstructionsZH-HANT"
        case strDrinkThumb = "strDrinkThumb"
        case strIngredient1 = "strIngredient1"
        case strIngredient2 = "strIngredient2"
        case strIngredient3 = "strIngredient3"
        case strIngredient4 = "strIngredient4"
        case strIngredient5 = "strIngredient5"
        case strIngredient6 = "strIngredient6"
        case strIngredient7 = "strIngredient7"
        case strIngredient8 = "strIngredient8"
        case strIngredient9 = "strIngredient9"
        case strIngredient10 = "strIngredient10"
        case strIngredient11 = "strIngredient11"
        case strIngredient12 = "strIngredient12"
        case strIngredient13 = "strIngredient13"
        case strIngredient14 = "strIngredient14"
        case strIngredient15 = "strIngredient15"
        case strMeasure1 = "strMeasure1"
        case strMeasure2 = "strMeasure2"
        case strMeasure3 = "strMeasure3"
        case strMeasure4 = "strMeasure4"
        case strMeasure5 = "strMeasure5"
        case strMeasure6 = "strMeasure6"
        case strMeasure7 = "strMeasure7"
        case strMeasure8 = "strMeasure8"
        case strMeasure9 = "strMeasure9"
        case strMeasure10 = "strMeasure10"
        case strMeasure11 = "strMeasure11"
        case strMeasure12 = "strMeasure12"
        case strMeasure13 = "strMeasure13"
        case strMeasure14 = "strMeasure14"
        case strMeasure15 = "strMeasure15"
        case strImageSource = "strImageSource"
        case strImageAttribution = "strImageAttribution"
        case strCreativeCommonsConfirmed = "strCreativeCommonsConfirmed"
        case dateModified = "dateModified"
    }
}
