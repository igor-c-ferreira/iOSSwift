//
//  ViewController.swift
//  iOSSwift
//
//  Created by Igor Ferreira on 6/6/14.
//  Copyright (c) 2014 Igor Ferreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EditAlbumProtocol {
    
    @IBOutlet var tableView : UITableView
    var dataSource: Dictionary<String, String>[] = []
    let kCellIdentifier = "iOSSwift_ViewController_kCellIdentifier"
    
    func initDataSource() {
        dataSource.append(["pictureUrl":"http://4.bp.blogspot.com/-8NpUFElov7Y/UUm6wEg2LoI/AAAAAAAABho/Dk2qSofWZkk/s640/Dark-Side-sleeve.jpg", "albumName":"Dark Side of the Moon", "artistName":"Pink Floyd"])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .Bottom
        initDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as? UITableViewCell
        if(cell == nil) {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: kCellIdentifier)
        }
        
        var album = dataSource[indexPath.row]
        
        if let currentCell:UITableViewCell = cell {
            currentCell.image = UIImage(data: NSData(contentsOfURL: NSURL(string: album["pictureUrl"])))
            currentCell.textLabel.text = album["albumName"]
            currentCell.detailTextLabel.text = album["artistName"]
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func editedAlbumConfig(name: String, artistName: String, imageUrl: String, index:Int) -> Bool {
        
        let dict = ["albumName":name,"artistName":artistName,"pictureUrl":imageUrl]
        
        if(index < 0) {
            dataSource.append(dict)
        } else {
            dataSource[index] = dict
        }
        
        self.tableView.reloadData()
        
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)  {
        
        if(segue.identifier == "mainViewController_show_detailViewController") {
            if let cell = sender as? UITableViewCell {
                let position = self.tableView.indexPathForCell(cell)
                let album = dataSource[position.row]
                
                if let detail = segue.destinationViewController as? DetailViewController {
                    detail.albumIndex = position.row
                    detail.album = album
                    detail.sender = self
                }
            }
        } else if(segue.identifier == "mainViewController_show_newAlbumViewController") {
            if let edit = segue.destinationViewController as? NewAlbumViewController {
                edit.sender = self
            }
        }
        
    }
}