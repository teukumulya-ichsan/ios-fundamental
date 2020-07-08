//
//  ViewController.swift
//  MyListMovie
//
//  Created by Teuku Mulia Ichsan on 09/07/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

/// enum state of donwload
enum DownloadState{
    case new, downloaded, failed
}

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let v = UITableView()
        v.delegate = self
        v.dataSource = self
        v.rowHeight = 180
        v.translatesAutoresizingMaskIntoConstraints = false
        v.register(UITableViewCell.self, forCellReuseIdentifier: "movie-cell")
        return v
    }()
    
    
    // create instance class of PendingOperations
    private let _pendingOperation = PendingOperations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup view
        view.addSubview(tableView)
        
        // constraint layout
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // TODO 1 :
    fileprivate func startOperation(movie: Movie, indexPath: IndexPath){
        if movie.state == .new {
            startDownload(movie:movie, indexPath: indexPath)
        }
    }
    
    // TODO 2 :
    fileprivate func startDownload(movie: Movie, indexPath: IndexPath){
        
        // TODO 3 :
        guard _pendingOperation.downloadInProgress[indexPath] == nil else{return}
        
        // TODO 4 :
        let downloader = ImageDonwloader(movie: movie)
        
        // TODO 5 :
        downloader.completionBlock = {
            // TODO 8 :
            if downloader.isCancelled{
                return
            }
            
            // TODO 5 :
            DispatchQueue.main.async {
                // TODO 6 :
                self._pendingOperation.downloadInProgress.removeValue(forKey: indexPath)
                // TODO 7 :
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        // TODO 9 :
        _pendingOperation.downloadInProgress[indexPath]  = downloader
        // TODO 10 :
        _pendingOperation.downloadQueue.addOperation(downloader)
    }
    
    fileprivate func toggleSuspendOperations(isSuspended: Bool){
        _pendingOperation.downloadQueue.isSuspended = isSuspended
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        toggleSuspendOperations(isSuspended: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let movie = movies[indexPath.row]
        
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie-cell", for: indexPath)
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = movie.title
        cell.imageView?.image = movie.image
        
        // if
        if cell.accessoryView == nil{
            cell.accessoryView = UIActivityIndicatorView(style: .medium)
        }
        
        //
        guard let indicator = cell.accessoryView as? UIActivityIndicatorView else {fatalError()}
        
        //
        if movie.state == .new {
            indicator.startAnimating()
            
            if !tableView.isDragging && !tableView.isDecelerating {
                startOperation(movie: movie, indexPath: indexPath)
            }
        } else {
            indicator.stopAnimating()
        }
        
        return cell
    }
    
           
}
