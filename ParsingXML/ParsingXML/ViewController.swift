//
//  ViewController.swift
//  ParsingXML
//
//  Created by Teuku Mulia Ichsan on 18/07/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

struct Movie {
    let id: Int
    let title: String
    let overview:String
    let poster: String
}

class ViewController: UIViewController {
    var movieTitle = String()
    var overview = String()
    var poster = String()
    var elementName = String()
    var id = 0
    var movies = [Movie]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let path = Bundle.main.url(forResource: "movies", withExtension: "xml"){
            if let parser = XMLParser(contentsOf: path){
                parser.delegate = self
                parser.parse()
            }
        }
    }

}

extension ViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "movie" {
            let movie = Movie(id: id, title: movieTitle, overview: overview, poster: poster)
            
            movies.append(movie)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty{
             switch elementName {
                           case "title": movieTitle = data
                           case "overview": overview = data
                           case "poster": poster = data
                           default: break
                       }
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
         movies.forEach { movie in
                   print("ID: \(movie.id)")
                   print("TITLE: \(movie.title)")
                   print("OVERVIEW: \(movie.overview)")
                   print("POSTER: \(movie.poster)")
               }
    }
}

