//
//  ViewController.swift
//  GCDAsyncImage
//
//  Created by Chase Wang on 2/23/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let numberOfCells = 20_000
    
    let imageURLArray = Unsplash.defaultImageURLs
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageTableViewCell
        
        var data: Data?
        var image: UIImage?
        
        let downloadQueue = OperationQueue()
        let downloadOperation = BlockOperation {
            let url = self.imageURLArray[indexPath.row % self.imageURLArray.count]
            data = try? Data(contentsOf: url)
            print("downloading")
        }
        
        let updateDBOperation = BlockOperation {
            image = UIImage(data: data!)
            let inputImage = CIImage(data: UIImagePNGRepresentation(image!)!)
            let filter = CIFilter(name: "CISepiaTone")!
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            filter.setValue(0.8, forKey: kCIInputIntensityKey)
            let outputCIImage = filter.outputImage
            let imageWithFilter = UIImage(ciImage: outputCIImage!)
            DispatchQueue.main.async {
                cell.pictureImageView.image = imageWithFilter
            }
            print("set image")
        }
        
//        let addFilterOperation = BlockOperation {
//
//        }
//
        updateDBOperation.addDependency(downloadOperation)
        downloadQueue.addOperations([downloadOperation, updateDBOperation], waitUntilFinished: false)
        
        // TODO: add sepia filter to image
//        let inputImage = CIImage(data: UIImagePNGRepresentation(image!)!)
//        let filter = CIFilter(name: "CISepiaTone")!
//        filter.setValue(inputImage, forKey: kCIInputImageKey)
//        filter.setValue(0.8, forKey: kCIInputIntensityKey)
//        let outputCIImage = filter.outputImage
//        let imageWithFilter = UIImage(ciImage: outputCIImage!)
//
        
        
        return cell
    }
}
