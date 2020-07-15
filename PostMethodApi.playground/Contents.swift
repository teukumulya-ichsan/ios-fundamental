import UIKit

    let apiKey = "d871aeab21ffbf67444fdc12355bd08f"

struct Guest: Codable{
    let success: Bool
    let guestSessionID : String
    
    enum CodingKeys: String, CodingKey {
        case success
        case guestSessionID = "guest_session_id"
    }
}

struct ReviewRequest: Codable{
    let value: Double
}

func getGuestSessionId(completion: ((Guest) -> ())?){
     var components = URLComponents(string: "https://api.themoviedb.org/3/authentication/guest_session/new")!
    
    components.queryItems = [
        URLQueryItem(name: "api_key", value: apiKey)
    ]
    
    let request = URLRequest(url: components.url!)
    
    let task = URLSession.shared.dataTask(with: request){data, response, error in
        guard let response = response as? HTTPURLResponse, let data = data else{return}
        
        if response.statusCode == 200 {
            let decoder = JSONDecoder()
            let response = try! decoder.decode(Guest.self, from: data)
            
            completion?(response)
        } else{
              print("ERROR: \(data), HTTP Status: \(response.statusCode)")
        }
    }
    
    task.resume()
}

getGuestSessionId { guest in
    var components = URLComponents(string: "https://api.themoviedb.org/3/movie/339095/rating")!
    
    components.queryItems = [
        URLQueryItem(name: "api_key", value: apiKey),
        URLQueryItem(name: "guest_session_id", value: guest.guestSessionID)
    ]
    
    var request = URLRequest(url: components.url!)
    
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
//    let jsonRequest = [
//        "value": 8.5
//    ]
    
    let reviewRequest = ReviewRequest(value: 8.5)
    
//    let jsonData = try! JSONSerialization.data(withJSONObject: jsonRequest, options: [])
    let jsonData = try! JSONEncoder().encode(reviewRequest)
    
    let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
        guard let response = response as? HTTPURLResponse, let data = data else { return }
        
        if response.statusCode == 201 {
            print("DATA: \(data)")
        }
    }
    
    task.resume()
}


