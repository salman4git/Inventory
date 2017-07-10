//
//  DetailViewController.swift
//  Inventory
//
//  Created by Apple on 7/9/17.
//  Copyright © 2017 Salman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pagingView: UIView!
   // @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var scrollView: UIScrollView = UIScrollView()
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height:0)
    public var productDetails: Response?
    let photos = ["pic1.jpg", "pic2.jpg", "pic3.jpg", "pic4.jpg", "pic5.jpg"]
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
         pageControl.frame.origin = CGPoint(x:  UIScreen.main.bounds.size.width * 0.5, y: self.view.frame.height-250)
         pageControl.backgroundColor = UIColor.red
        // The total number of pages that are available is based on how many available frames we have.
         pageControl.numberOfPages = 5
         pageControl.currentPage = 0
         pageControl.tintColor = UIColor.red
         pageControl.pageIndicatorTintColor = UIColor.black
         pageControl.currentPageIndicatorTintColor = UIColor.green
         return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let barAppearace = UIBarButtonItem.appearance()
        barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
        self.setUpScrollView()

        self.showContent()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    func showContent() {
        let rupee = "\u{20B9}"
        self.detailLabel.text = self.productDetails?.title
        self.priceLabel.text = rupee + (self.productDetails?.price?.description)!
    }
    
    // MARK : SetupScrollViewMethod
    
    func setUpScrollView() {
        
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-270))
        
        self.pagingView.addSubview(self.pageControl)
        self.scrollView.delegate = self
        self.pagingView.addSubview(self.scrollView)
        
        for  i in stride(from: 0, to: photos.count, by: 1) {
            var frame = CGRect.zero
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(i)
            frame.origin.y = 0
            frame.size = self.scrollView.frame.size
            self.scrollView.isPagingEnabled = true
            
            let myImage:UIImage = UIImage(named: photos[i])!
            let myImageView:UIImageView = UIImageView()
            myImageView.image = myImage
            myImageView.contentMode = UIViewContentMode.scaleAspectFit
            myImageView.frame = frame
            
            scrollView.addSubview(myImageView)
        }
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(5), height: self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    
    // MARK : ScrollView Delegate / Datasource Methods
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
