//
//  ViewController.swift
//  ShoppingScrollView
//
//  Created by Mac on 10/15/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var skyImageView: UIImageView!
    @IBOutlet var lawnsImageView: UIImageView!
    
    
    
    var images = [UIImageView]()
    var scrollViewXValue  :CGFloat?
    var contentXValue  :CGFloat = 0.0
    var selectedImageViewIndex  = 0
    var currentScrollContentOffset  = CGPointMake(0.0, 0.0)
    var inDraggingProcess = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        scrollView.delegate = self
        
        
        let directions: [UISwipeGestureRecognizerDirection] = [.Right, .Left, .Up, .Down]
        for direction in directions {
            
            
            let imageGesture = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipe(_:)))
            imageGesture.direction = direction
            
            
            let secondImageGesture = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipe(_:)))
            secondImageGesture.direction = direction
            
            let scrollGesture = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipe(_:)))
            scrollGesture.direction = direction
            
            skyImageView.userInteractionEnabled = true
            skyImageView.addGestureRecognizer(scrollGesture)
            
            lawnsImageView.userInteractionEnabled = true
            lawnsImageView.addGestureRecognizer(secondImageGesture)
            
            
            scrollView.userInteractionEnabled = true
            scrollView.addGestureRecognizer(imageGesture)
            
            
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:)))
            scrollView.addGestureRecognizer(tap)
            

        
        }

        
 
    
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        
        
        for i in 1...5{
            
            let image = UIImage(named: "animation\(i%5 != 0 ? i%5 : 1)")
            let imageView = UIImageView.init(image: image)
            
            images.append(imageView)
            
            scrollViewXValue = scrollView.frame.width/2.0  + scrollView.frame.width * CGFloat (i - 1)
            contentXValue += scrollViewXValue!
            imageView.frame = CGRectMake(scrollViewXValue! - 50 , scrollView.frame.height/2.0 - 100 , 100, 200)
            


            
            scrollView.addSubview(imageView)
            
        }
        
        scrollView.contentSize = CGSizeMake(contentXValue, scrollView.frame.height)
        
        scrollView.setContentOffset(CGPointMake( scrollView.contentOffset.x + scrollView.frame.width * CGFloat(self.images.count/2), self.scrollView.frame.origin.y), animated: false)
        scrollView.clipsToBounds = false
        self.selectedImageViewIndex = images.count/2
        let midImageView = images[selectedImageViewIndex]
        
        midImageView.frame = CGRectMake(midImageView.frame.origin.x, midImageView.frame.origin.y, midImageView.frame.size.width + 30.0 , midImageView.frame.size.height + 30.0)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    
    func handleSwipe(sender: UISwipeGestureRecognizer) {
        
    
        if (sender.direction.rawValue == 2 ){
        
            if selectedImageViewIndex != images.count - 1  {
                
                scrollView.setContentOffset(CGPointMake( scrollView.contentOffset.x + scrollView.frame.width , self.scrollView.frame.origin.y), animated: true)
                selectedImageViewIndex += 1
                
                print(selectedImageViewIndex)
                let nextImageView = images[selectedImageViewIndex]
                nextImageView.frame = CGRectMake(nextImageView.frame.origin.x, nextImageView.frame.origin.y, nextImageView.frame.size.width + 30.0 , nextImageView.frame.size.height + 30.0)
                let previousImageView = images[selectedImageViewIndex-1]
                
                previousImageView.frame = CGRectMake(previousImageView.frame.origin.x, previousImageView.frame.origin.y, previousImageView.frame.size.width - 30.0 , previousImageView.frame.size.height - 30.0)
            }
            

        }else{
            
            if  selectedImageViewIndex != 0 {
            scrollView.setContentOffset(CGPointMake( scrollView.contentOffset.x - scrollView.frame.width , self.scrollView.frame.origin.y), animated: true)
            selectedImageViewIndex -= 1
            
                print(selectedImageViewIndex)
                
                let nextImageView = images[selectedImageViewIndex]
                nextImageView.frame = CGRectMake(nextImageView.frame.origin.x, nextImageView.frame.origin.y, nextImageView.frame.size.width + 30.0 , nextImageView.frame.size.height + 30.0)
                let previousImageView = images[selectedImageViewIndex+1]
                
                previousImageView.frame = CGRectMake(previousImageView.frame.origin.x, previousImageView.frame.origin.y, previousImageView.frame.size.width - 30.0 , previousImageView.frame.size.height - 30.0)

            }
        }
        
        
    }
    
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        self.scrollView.scrollEnabled = false

        
    }
        
  
  
    
    
   
    
 
    func handleTap(sender: UITapGestureRecognizer) {
    
        let selectedImage = images[selectedImageViewIndex]
        
        if (sender.locationInView(self.scrollView).x >= selectedImage.frame.origin.x && sender.locationInView(self.scrollView).x <= selectedImage.frame.origin.x + selectedImage.frame.width && sender.locationInView(self.scrollView).y >= selectedImage.frame.origin.y && sender.locationInView(self.scrollView).y <= selectedImage.frame.origin.y + selectedImage.frame.height){
            
            
            
            let alert = UIAlertController(title: "Success", message: "Choose Animation # \(selectedImageViewIndex + 1)", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion:nil)

            
        }

    
    
    }
    
 
    
}

