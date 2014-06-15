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
        
        if let initialInformation = detail {
            albumName.text = initialInformation["albumName"]
            artistName.text = initialInformation["artistName"]
            imageUrl.text = initialInformation["pictureUrl"]
        }
        
    }
    
    @IBAction func saveButtonAction(button: AnyObject!) {
        if let controller = sender {
            if controller.editedAlbumConfig(albumName.text, artistName: artistName.text, imageUrl: imageUrl.text, index: -1) {
                self.navigationController.popViewControllerAnimated(true)
                return
            }
        }
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = "Error on saving the album. Please, retry"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
}
