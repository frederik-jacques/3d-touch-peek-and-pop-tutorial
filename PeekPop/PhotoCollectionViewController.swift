//
//  PhotoCollectionViewController.swift
//  PeekPop
//
//  Created by Frederik Jacques on 06/10/15.
//  Copyright © 2015 Frederik Jacques. All rights reserved.
//

import UIKit

private let reuseIdentifier = "photoCell"

class PhotoCollectionViewController: UICollectionViewController, UIViewControllerPreviewingDelegate {
    
    // Properties
    lazy var photos:[Photo] = {
        
        return [
            Photo(caption: "Lovely piece of art in Bordeaux", imageName: "bordeaux", city: "Bordeaux"),
            Photo(caption: "Cosy lake beach in France", imageName: "lake", city: "Bordeaux"),
            Photo(caption: "Harbour in France", imageName: "harbour", city: "Rouffiac"),
            Photo(caption: "Buda beach in Kortrijk", imageName: "buda", city: "Kortrijk")
        ]
        
    }()
    
    // Lifecycle methods    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if( traitCollection.forceTouchCapability == .Available){
            
            registerForPreviewingWithDelegate(self, sourceView: view)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if( segue.identifier == "sgPhotoDetail" ){
            
            let photo = photos[(collectionView?.indexPathsForSelectedItems()![0].row)!]
            
            let vc = segue.destinationViewController as! DetailViewController
            vc.photo = photo
            
        }
        
    }

    // MARK: UICollectionViewDataSource methods
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {

        return 1
        
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCollectionViewCell
    
        // Configure the cell
        let photo = photos[indexPath.row]
        
        if let image = UIImage(named: photo.imageName) {
            
            cell.imageView.image = image
            
        }else {
            
            cell.imageView.image = UIImage(named: "image-not-found")
            
        }

        return cell
    }
    
    // MARK: Trait collection delegate methods
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        
    }
    
    // MARK: UIViewControllerPreviewingDelegate methods
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionView?.indexPathForItemAtPoint(location) else { return nil }
        
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) else { return nil }
        
        guard let detailVC = storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as? DetailViewController else { return nil }
        
        let photo = photos[indexPath.row]
        detailVC.photo = photo
        
        detailVC.preferredContentSize = CGSize(width: 0.0, height: 300)
        
        previewingContext.sourceRect = cell.frame
        
        return detailVC
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        
        showViewController(viewControllerToCommit, sender: self)
        
    }
    
}
