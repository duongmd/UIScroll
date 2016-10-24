//
//  ListImages.swift
//  UIScroll
//
//  Created by iOS Student on 9/28/16.
//  Copyright © 2016 iOS Student. All rights reserved.
//

import UIKit

class ListImages: UIViewController {

    @IBAction func onTouch(_ sender: AnyObject) {
        switch (sender.tag) {
        case 101: pushView(index: 0)
        case 102: pushView(index: 1)
        case 103: pushView(index: 2)
            
        default: break
        }
    }
    
    func pushView(index: Int) {
        let listView = self.storyboard?.instantiateViewController(withIdentifier: "ViewScroll") as? ViewScroll
        listView?.currentPage = index
        self.navigationController?.pushViewController(listView!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

   
    

}
