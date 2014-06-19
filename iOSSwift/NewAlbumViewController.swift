//
//  DetailViewController.swift
//  iOSSwift
//
//  Created by Igor Ferreira on 6/15/14.
//  Copyright (c) 2014 Igor Ferreira. All rights reserved.
//

import UIKit

protocol EditAlbumProtocol {
    func editedAlbumConfig(name: String, artistName: String, imageUrl:String, index:Int) -> Bool
}

class NewAlbumViewController: UIViewController {
    
    @IBOutlet var albumName : UITextField
    @IBOutlet var artistName : UITextField
    @IBOutlet var imageUrl : UITextField
    
    var sender: EditAlbumProtocol?
    var detail: Dictionary<String, String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .Bottom
        
        if let initialInformation = self.detail {
            self.albumName.text = initialInformation["albumName"]
            self.artistName.text = initialInformation["artistName"]
            self.imageUrl.text = initialInformation["pictureUrl"]
        }
        
    }
    
    @IBAction func saveButtonAction(button: AnyObject!) {
        if let controller = self.sender {
            if controller.editedAlbumConfig(self.albumName.text, artistName: self.artistName.text, imageUrl: self.imageUrl.text, index: -1) {
                self.navigationController.popViewControllerAnimated(true)
                return
            }
        }
        
        let alert = UIAlertController(title: "Error", message: "Error on saving the album", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .Default, handler: {action in
            self.saveButtonAction(button)
            return
            }))
        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
