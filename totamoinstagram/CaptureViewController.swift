//
//  CaptureViewController.swift
//  totamoinstagram
//
//  Created by Steve Buza on 2/27/16.
//  Copyright © 2016 Steve Buza. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var captionField: UITextView!
    @IBOutlet weak var capturePicture: UIImageView!
    
    let imagePicker = UIImagePickerController()

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func onImageButton(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func onSubmit(sender: AnyObject) {
        let resizedPic = resize(capturePicture.image!, newSize: CGSize(width: 320, height: 320))
        UserMedia.postUserImage(resizedPic, withCaption: captionField.text) { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Posted successfully!")
                self.performSegueWithIdentifier("captureToHomeSegue", sender: nil)
            }
            else{
                print("Yikes, didn't work!")
            }
        }
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            capturePicture.contentMode = .ScaleAspectFill
            
            
            
            capturePicture.image = originalImage
            dismissViewControllerAnimated(true, completion: nil)
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
