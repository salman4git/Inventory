//
//  HomeViewController.swift
//  Inventory
//
//  Created by Apple on 7/6/17.
//  Copyright © 2017 Salman. All rights reserved.
//

import UIKit
import ObjectMapper
import Kingfisher
import CoreData

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    private let kThumnailCellID: String = "ThumbnailCellID"
    private var productList = Singleton.sharedInstance.responseData
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var collection_View: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv: UICollectionView = self.collectionView!
        var width = UIScreen.main.bounds.width
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        cv.collectionViewLayout = layout
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collection_View.backgroundColor = UIColor.clear
        self.setNavigationBar()
        self.getRequest()
    }
    
    
    // MARK: - CustomNavigationBarMethods
    func setNavigationBar() {
       
        self.navigationItem.setTitle(title: "KOOK N KEECH", subtitle: "\(self.productList.count) Items")
         
    }
    
    // MARK: - UICollectionViewDataSource/UICollectionViewDelegate Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell:ThumbnailCell = collectionView.dequeueReusableCell(withReuseIdentifier: kThumnailCellID, for: indexPath) as! ThumbnailCell
         cell.productNameLabel.text = productList[indexPath.item].title
         let rupee = "\u{20B9}"
         cell.priceLabel.text = rupee + (productList[indexPath.item].price?.description)!
         let img_url = URL(string: productList[indexPath.item].image_url!)
         cell.thumbnailImageView.kf.setImage(with: img_url)
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoardIDStrings.kDetialViewControllerID) as! DetailViewController
        next.productDetails = productList[indexPath.item]
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(2 - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(2))
        return CGSize(width: size, height: 231)
        
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    // MARK: - WebServiceMethods
    
    func getRequest() {
        AFWrapper.startNetworkReachabilityObserver { (isRechable) -> (Void) in
            
            guard isRechable else {
                Utility.infoAlertWithMessage(Constants.ErrorStrings.nNetworkError, message: Constants.ErrorStrings.nNotReachable, viewController: self)
                self.getData()
                return
            }
            
            let requestUrl = Constants.URLs.kBaseUrl
            AFWrapper.requestGETURL(requestUrl, params: nil, headers: nil, success: { (JSON, data) in
                
                print(JSON.rawValue)
    
               self.productList = Mapper<Response>().mapArray(JSONArray: (JSON.rawValue  as! [[String : Any]]))
                
                //Save data to cre data
                let product = Product(context: self.context)
                let saveData = Singleton.sharedInstance.archivedProducts(product: self.productList)
                product.productList = saveData as NSData
                // Save the data to coredata
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                self.setNavigationBar()
                self.collectionView.reloadData()
                
            }) { (NSError) in
                
                Utility.infoAlertWithMessage(Constants.GeneralStrings.kSorry, message: Constants.ErrorStrings.nWrong, viewController: self)
            }
        }
    }
    
    // MARK: - CoreData Fetch data
    func getData() {
        //Fetches data when newtowrk not available
        do {
            let products = try context.fetch(Product.fetchRequest()) as! [Product]
            let data = products[0].productList
            let details = Singleton.sharedInstance.unArchivedProducts(data: data!)
            self.productList = details 
            print(self.productList[0].brand!)
            self.setNavigationBar()
            self.collectionView.reloadData()
        } catch {
            print("Fetching Failed")
        }
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
