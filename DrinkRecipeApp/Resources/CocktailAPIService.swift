//
//  CocktailAPIService.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 5/29/21.
//

import Foundation

class CocktailAPIService {
    
    enum Endpoints {
        static let base = "https://www.thecocktaildb.com/api/json/v1/1/"
        
        case search(String, String)
        case lookup(String, String)
        case filter(String, String)
        case list(String, String)
        case random
        case photo(String)
        case ingredientImage(String)
        
        var stringValue: String {
            switch self {
            case .search(let type, let value) :
                return Endpoints.base + "search.php?\(type)=\(value)"
            case .lookup(let type, let value) :
                return Endpoints.base + "lookup.php?\(type)=\(value)"
            case .filter(let type, let value) :
                return Endpoints.base + "filter.php?\(type)=\(value)"
            case .list(let type, let value) :
                return Endpoints.base + "list.php?\(type)=\(value)"
            case .random :
                return Endpoints.base + "random.php?"
            case .photo(let id) :
                return Endpoints.base + "/images/media/drink/\(id).jpg/preview"
            case .ingredientImage(let ingredient) :
                return "https://www.thecocktaildb.com/images/ingredients/\(ingredient).png"
            }
        }
        
        var url: URL {
            print(stringValue)
            return URL(string: stringValue)!
        }
    }
    
    class func search(type: String, query: String, completion: @escaping ([Drink], Error?) -> Void) -> URLSessionTask {
        let task = taskForGETRequest(url: Endpoints.search(type, query).url, responseType: CocktailDBResponse.self) { (response, error)
            in
            if let response = response {
                completion(response.drinks, nil)
            } else {
                completion([], error)
            }
        }
        return task
    }
    
    class func list(type: String, query: String, completion: @escaping ([Drink], Error?) -> Void) -> Void {
        taskForGETRequest(url: Endpoints.list(type, query).url, responseType: CocktailDBResponse.self) { (response, error)
            in
            if let response = response {
                completion(response.drinks, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func filter(type: String, query: String, completion: @escaping ([Drink], Error?) -> Void) -> Void {
        taskForGETRequest(url: Endpoints.filter(type, query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!).url, responseType: CocktailDBResponse.self) { (response, error)
            in
            if let response = response {
                completion(response.drinks, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func lookup(type: String, query: String, completion: @escaping ([Drink], Error?) -> Void) -> Void {
        taskForGETRequest(url: Endpoints.lookup(type, query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!).url, responseType: CocktailDBResponse.self) { (response, error)
            in
            if let response = response {
                completion(response.drinks, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func getRandomDrink(completion: @escaping ([Drink], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.random.url, responseType: CocktailDBResponse.self) { response, error in
            if let response = response {
                completion(response.drinks, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func downloadDrinkImage(imagePath: String, completion: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: imagePath + "/preview")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error)
            in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }
    
    class func downloadIngredientImage(ingredient: String, completion: @escaping (Data?, Error?) -> Void) {
        let url = Endpoints.ingredientImage(ingredient.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!).url
        print(url)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error)
            in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }
    
    /*
     Utility method to manage GET requests
     */
    private class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?)->Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
        return task
    }
}
