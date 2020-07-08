//
//  Movie.swift
//  MyListMovie
//
//  Created by Teuku Mulia Ichsan on 09/07/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation
import UIKit

/// Movie model with Property : title, poster and state with default .new
class Movie {
    init(title: String, poster: URL) {
        self.title = title
        self.poster = poster
    }
    
    let title: String
    let poster: URL
    
    var image: UIImage?
    var state: DownloadState = .new
}
