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
    
    var album:Dictionary<String, String> = [:]
    var albumIndex:Int = -1
    var sender:EditAlbumProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .Bottom
        
        albumImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: album["pictureUrl"])))
        albumName.text = album["albumName"]
        artistName.text = album["artistName"]
        
    }
    
    func editedAlbumConfig(name: String, artistName: String, imageUrl: String, index:Int) -> Bool {
        
        if let controller = sender {
            
            let changed = controller.editedAlbumConfig(name, artistName: artistName, imageUrl: imageUrl, index: albumIndex)
            
            album["albumName"] = name
            album["artistName"] = artistName
            album["pictureUrl"] = imageUrl
            
            albumImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: imageUrl)))
            albumName.text = name
            self.artistName.text = artistName
            
            return changed
        } else {
            return false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)  {
        if(segue.identifier == "detailViewController_show_newAlbumViewController") {
            if let edit = segue.destinationViewController as? NewAlbumViewController {
                edit.detail = album
                edit.sender = self
            }
        }
    }
    
}
