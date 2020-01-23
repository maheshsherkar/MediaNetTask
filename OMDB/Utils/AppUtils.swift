//
//  AppUtils.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 19/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//
import Foundation
import UIKit

public class AppUtils{
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static private var activityindicater:UIActivityIndicatorView!
    static private var activityindicaterView:UIView! = nil
    static private var indicator:Bool = false
    
    
    
    // MARK: - Activity indicator
    static private func initializeIndicator(){
        self.activityindicaterView = UIView.init(frame: CGRect(x: 0, y: 0, width: (appDelegate.window?.frame.size.width)!, height: (appDelegate.window?.frame.size.height)!))
        self.activityindicaterView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.activityindicater = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        self.activityindicater.center = ((appDelegate.window?.center)!)
        self.activityindicaterView.addSubview(self.activityindicater)
    }
    
    //: Add Activity indicator in view controller
    static func addActivitiIndicaterView() {
        print("add indicator")
        DispatchQueue.main.async {
            if !indicator {
                if (self.activityindicater == nil)
                {
                    initializeIndicator()
                }
                self.activityindicaterView.addSubview(self.activityindicater)
                self.activityindicaterView.isHidden = false
                appDelegate.window?.addSubview(self.activityindicaterView)
                self.activityindicater.startAnimating()
                self.indicator = true
            }
        }
        
    }
    
    // : - Add Activity indicator in view controller
    static func hideActivitiIndicaterView()  {
        print("hide indicator")
        DispatchQueue.main.async {
            if (self.activityindicater != nil){
                self.activityindicater.stopAnimating()
                self.activityindicaterView.removeFromSuperview()
                self.activityindicaterView.isHidden = true
                self.indicator = false
            }
        }
    }
    
    
    //Mark: - Show Alert
    
    static func showAlert(message:String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        appDelegate.window?.rootViewController!.present(alert, animated: true)
    }
    
}
