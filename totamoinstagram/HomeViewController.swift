//
//  HomeViewController.swift
//  totamoinstagram
//
//  Created by Steve Buza on 2/27/16.
//  Copyright © 2016 Steve Buza. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var i = 0
    var image: AnyObject?
    var caption: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as! PhotoCell
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("_created_at")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                cell.photoImageView.contentMode = .ScaleAspectFill
                cell.captionLabel.text = media[self.i]["caption"] as? String
                self.image = media[self.i]["media"]
                self.image?.getDataInBackgroundWithBlock({ (picData: NSData?, error: NSError?) -> Void in
                    if error == nil{
                        cell.photoImageView.image = UIImage(data: picData!)
                    }
                })
                self.i++
                // do something with the data fetched
            }
        }
        
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
