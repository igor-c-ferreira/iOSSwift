//
//  DetailViewController.swift
//  iOSSwift
//
//  Created by Igor Ferreira on 6/15/14.
//  Copyright (c) 2014 Igor Ferreira. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, EditAlbumProtocol {

    @IBOutlet var albumImage : UIImageView
    @IBOutlet var albumName : UILabel
    @IBOutlet var artistName : UILabel
    
    var album:Dictionary<String, String>?
    var albumIndex:Int = -1
    var sender:EditAlbumProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .Bottom
        
        
        if let currentAlbum = self.album {
            self.albumImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: currentAlbum["pictureUrl"])))
            self.albumName.text = currentAlbum["albumName"]
            self.artistName.text = currentAlbum["artistName"]
        }
        
    }
    
    func editedAlbumConfig(name: String, artistName: String, imageUrl: String, index:Int) -> Bool {
        
        if let controller = self.sender {
            
            let changed = controller.editedAlbumConfig(name, artistName: artistName, imageUrl: imageUrl, index: self.albumIndex)
            
            self.album = ["pictureUrl":imageUrl, "albumName":name, "artistName":artistName]
            
            self.albumImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: imageUrl)))
            self.albumName.text = name
            self.artistName.text = artistName
            
            return changed
        } else {
            return false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)  {
        if(segue.identifier == "detailViewController_show_newAlbumViewController") {
            if let edit = segue.destinationViewController as? NewAlbumViewController {
                edit.detail = self.album
                edit.sender = self
            }
        }
    }
    
}
