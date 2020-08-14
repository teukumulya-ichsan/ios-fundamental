import UIKit

let page = "1"

struct Platform: Codable{
    let id: Int
    let name: String
    let slug: String
}

struct Genre: Codable{
    let id: Int
    let name: String
    let slug: String
}

struct Game: Codable {
    let slug: String
    let name: String
    let released: String
    let backgroudImage: String
    let rating: Double
    
//    let platform: [Platform]
    let genre: [Genre]
    
     enum CodingKeys: String, CodingKey {
        case slug
        case name
        case released
        case backgroudImage = "background_image"
        case rating
        
//        case platform = "platforms"
        case genre = "genres"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        slug = try container.decode(String.self, forKey: .slug)
        name = try container.decode(String.self, forKey: .name)
        released = try container.decode(String.self, forKey: .released)
        backgroudImage = try container.decode(String.self, forKey: .backgroudImage)
        rating = try container.decode(Double.self, forKey: .rating)
//         platform = try container.decode([Platform].self, forKey: .platform)
         genre = try container.decode([Genre].self, forKey: .genre)
        
    }
}

struct Games: Codable {
    let totalResults: Int
    let next: String
//    let prev: String
    
    let result: [Game]
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "count"
        case next
//        case prev = "previous"
        case result = "results"
    }
    
}

var popular2020Components = URLComponents(string: "https://api.rawg.io/api/games?dates=2020-01-01,2020-12-31&ordering=-added")!

//popular2020Components.queryItems = [
//     URLQueryItem(name: "page", value: page)
//]

let request = URLRequest(url: popular2020Components.url!)

let task = URLSession.shared.dataTask(with: request) { data, response, error in
    guard let response = response as? HTTPURLResponse, let data = data else {return}
    
    if response.statusCode == 200 {
        decodeJSON(data: data)
    } else {
        print("ERROR: \(data), HTTP Status: \(response.statusCode)")
    }
}

private func decodeJSON(data: Data) {
    let decoder = JSONDecoder()
    
    let games = try! decoder.decode(Games.self, from: data)
    
    
    print("Total Result: \(games.totalResults)")
    games.result.forEach{ game in
        print("Name: \(game.name)")
        print("Slug: \(game.slug)")
        print("Rating: \(game.rating)")
        print("Image: \(game.backgroudImage)")
    }
}

task.resume()
