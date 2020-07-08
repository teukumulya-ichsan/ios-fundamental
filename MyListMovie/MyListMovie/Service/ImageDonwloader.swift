//
//  ImageDonwloader.swift
//  MyListMovie
//
//  Created by Teuku Mulia Ichsan on 09/07/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation
import UIKit

// ImageDownloader abstract class as single task operation 
class ImageDonwloader: Operation{
    init(movie: Movie) {
        self._movie = movie
    }
    
    // private property
    private let _movie : Movie
    
    
    // Func thats override first when Operation ImageDownloader Execute
    override func main() {
        
        // 1 : check is task cancelled or not before start download image
        if isCancelled {
            return
        }
        
        // 2 : download image with passing poster variable to Data Buffer
        guard let imageData = try? Data(contentsOf: _movie.poster) else {
            return
        }
        
        // 3 : check is task cancelled before downloaded image is assignment to image & state variable
        if isCancelled {
            return
        }
        
        // 4 : assignment downloaded data, if imageData is nil, set state as failed. if not nil set state as downladed with image as imageData
        if imageData.isEmpty{
            _movie.image = nil
            _movie.state = .failed
        } else {
            _movie.image = UIImage(data: imageData)
            _movie.state = .downloaded
        }
        
        
    }
}
