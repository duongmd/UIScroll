//
//  ViewScroll.swift
//  UIScroll
//
//  Created by iOS Student on 9/26/16.
//  Copyright © 2016 iOS Student. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var ScrollView: UIScrollView!

    @IBOutlet weak var pagecontroller: UIPageControl!

    var photo: [UIImageView] = []
    var pageImages: [String] = []
    var frontScrollViews: [UIScrollView] = []
    var first = false
    var currentPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        pageImages = ["shop1-0","shop1-1","shop1-2"]
        pagecontroller.currentPage = currentPage
        pagecontroller.numberOfPages = pageImages.count
        ScrollView.maximumZoomScale = 2
        ScrollView.minimumZoomScale = 0.5
    }
    
    override func viewDidLayoutSubviews() {
        
        if (!first) {
            first = true
            let pageScrollViewSize = ScrollView.frame.size
            ScrollView.contentSize = CGSize(width: pageScrollViewSize.width * CGFloat(pageImages.count), height: pageScrollViewSize.height)
           ScrollView.contentOffset = CGPoint(x: CGFloat(currentPage) * ScrollView.frame.size.width, y: 0)
            for i in 0 ..< pageImages.count {
                
                let imgView = UIImageView(image: UIImage(named: pageImages[i]+".jpg"))
                
                imgView.frame = CGRect(x: 0, y: 0, width: ScrollView.frame.size.width, height: ScrollView.frame.size.height)
                
                imgView.contentMode = .scaleAspectFit
                imgView.isUserInteractionEnabled = true
                imgView.isMultipleTouchEnabled = true
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapImg(gesture:)))
                tap.numberOfTapsRequired = 1
                imgView.addGestureRecognizer(tap)
                
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapImg(gesture:)))
                doubleTap.numberOfTapsRequired = 2
                tap.require(toFail: doubleTap)
                imgView.addGestureRecognizer(doubleTap)

                photo.append(imgView)
               
                let frontScrollView = UIScrollView(frame: CGRect(x: CGFloat(i) * ScrollView.frame.size.width, y: 0, width: ScrollView.frame.size.width, height: ScrollView.frame.size.height))
                frontScrollView.minimumZoomScale = 0.5
                frontScrollView.maximumZoomScale = 2
                frontScrollView.delegate = self
                frontScrollView.addSubview(imgView)
                frontScrollViews.append(frontScrollView)
                self.ScrollView.addSubview(frontScrollView)
            }
            
        }
    }
    

    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photo[pagecontroller.currentPage]
    }

    
    func tapImg(gesture: UITapGestureRecognizer)  {
        let position = gesture.location(in: photo[pagecontroller.currentPage])
        zoomRectForScale(frontScrollViews[pagecontroller.currentPage].zoomScale * 1.5, center: position)
    }
    
    
    func doubleTapImg(gesture: UITapGestureRecognizer) {
        let position = gesture.location(in: photo[pagecontroller.currentPage])
        zoomRectForScale(frontScrollViews[pagecontroller.currentPage].zoomScale * 0.5, center: position)
    }
    
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint) {
        var zoomRect = CGRect()
        let scrollViewSize = ScrollView.bounds.size
        zoomRect.size.width = scrollViewSize.width/scale
        zoomRect.size.height = scrollViewSize.height/scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width/2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height/2.0)
        
        
        frontScrollViews[pagecontroller.currentPage].zoom(to: zoomRect, animated: true)
    }
    
    @IBAction func onChange(_ sender: AnyObject) {
        ScrollView.contentOffset = CGPoint(x: CGFloat(pagecontroller.currentPage)*ScrollView.frame.size.width, y: 0)
    }
   
    


}

