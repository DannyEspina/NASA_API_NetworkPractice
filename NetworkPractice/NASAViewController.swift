//
//  ViewController.swift
//  NetworkPractice
//
//  Created by Danny Espina on 8/21/18.
//  Copyright © 2018 Danny Espina. All rights reserved.
//

import UIKit

class NASAViewController: UIViewController {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var NASAImageView: UIImageView!
    @IBOutlet var APODTitle: UILabel!
    @IBOutlet var APODDate: UILabel!
    @IBOutlet var APODExplanation: UILabel!
    var store: photoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        store.fetchPictureOfTheDay { (imageResult) in
            switch imageResult {
            case let .success(photo):
                DispatchQueue.main.async {
                self.APODTitle.text = photo.title
                self.APODDate.text = photo.date
                self.APODExplanation.text = photo.explanation
                }
                NASAAPI.downloadImage(at: photo.hdurl, completion: {
                    (downloadResult) -> Void in
                    switch downloadResult {
                    case let .success(image):
                        DispatchQueue.main.async {
                        self.NASAImageView.image = image
                        self.activityIndicator.stopAnimating()
                        }
                    case let .failure(error):
                        print(error)
                    }
                })
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        
    }


}

