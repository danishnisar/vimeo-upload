//
//  ViewController.swift
//  vimeo upload
//
//  Created by MacBook Prp on 21/07/2018.
//  Copyright © 2018 Native Brains. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON


class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    let url = "https://1512435600.cloud.vimeo.com/upload?ticket_id=163118080&video_file_id=1054534523&signature=04c42e9b6fa8875f7f4183088848b727&v6=1&redirect_url=https%3A%2F%2Fvimeo.com%2Fupload%2Fapi%3Fvideo_file_id%3D1054534523%26app_id%3D130346%26ticket_id%3D163118080%26signature%3D9b6f595da047093d1bf9f2a5ac525032b7a64500%26redirect%3Dhttps%253A%252F%252Fwww.telemart.pk%252F";
    let vc = UIImagePickerController()
    
    let header : HTTPHeaders = [
        "Content-Type":"multipart/form-data"
    ]
   // var parameter : Parameters
    override func viewDidLoad() {
        super.viewDidLoad()
        vc.delegate = self
        vc.sourceType = .photoLibrary
        vc.mediaTypes = [kUTTypeMovie as String ,kUTTypeVideo as String]
        present(vc, animated: true, completion: nil)
        
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let videoURL = info[UIImagePickerControllerMediaURL] as? NSURL {
            print(videoURL)
            let data = NSData(contentsOf: videoURL as URL)!
            print("File Size before Compressing\(Double(data.length / 1048576 )) mb")
            uploadVideo(data: videoURL as URL)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func uploadVideo(data:URL){
        let fileurl = data
        Alamofire.upload(multipartFormData: { (multipart) in
            multipart.append(fileurl, withName: "file_data")
        }, usingThreshold: UInt64.init(), to: url, method: HTTPMethod.post, headers: header) { (result) in
            print(result)
        }
    }


}

