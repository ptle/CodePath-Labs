//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Jacob Smith on 1/5/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    
    @IBOutlet weak var table: UITableView!
    var posts: [NSDictionary] = []
    var total = 5
    
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    
    func loadMoreData() {
        total += 5
        // ... Create the URLRequest `myRequest` ...
        let url = NSURL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV&limit=\(total)")
        let request = NSURLRequest(url: url! as URL)
        
        // Configure session so that completion handler is executed on main UI thread
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                                                                        
                // Update flag
                self.isMoreDataLoading = false
                
                // Stop the loading indicator
                self.loadingMoreView!.stopAnimating()
                                                                        
                // ... Use the new data to update the data source ...
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        //print("responseDictionary: \(responseDictionary)")
                        
                        // Recall there are two fields in the response dictionary, 'meta' and 'response'.
                        // This is how we get the 'response' field
                        let responseFieldDictionary = responseDictionary["response"] as! NSDictionary
                        
                        // This is where you will store the returned array of posts in your posts property
                        self.posts = responseFieldDictionary["posts"] as! [NSDictionary]
                        self.table.reloadData()
                    }
                }
                // Reload the tableView now that there is new data
                self.table.reloadData()
        });
        task.resume()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            
            
            
            //Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = table.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - table.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && table.isDragging) {
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRect(x: 0, y: table.contentSize.height, width: table.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                // ... Code to load more results ...
                loadMoreData()
            }
            
        }
    }
    
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // ... Create the URLRequest `myRequest` ...
        let url = NSURL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV&limit=\(total)")
        let request = NSURLRequest(url: url! as URL)
        
        // Configure session so that completion handler is executed on main UI thread
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        //print("responseDictionary: \(responseDictionary)")
                        
                        // Recall there are two fields in the response dictionary, 'meta' and 'response'.
                        // This is how we get the 'response' field
                        let responseFieldDictionary = responseDictionary["response"] as! NSDictionary
                        
                        // This is where you will store the returned array of posts in your posts property
                        self.posts = responseFieldDictionary["posts"] as! [NSDictionary]
                        self.table.reloadData()
                    }
                }
        });
        task.resume()
            
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotosViewController.refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        table.insertSubview(refreshControl, at: 0)
        
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 240;
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: table.contentSize.height, width: table.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        table.addSubview(loadingMoreView!)
        
        var insets = table.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        table.contentInset = insets
        
        let url = NSURL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV&limit=\(total)")
        let request = NSURLRequest(url: url! as URL)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        //print("responseDictionary: \(responseDictionary)")
                        
                        // Recall there are two fields in the response dictionary, 'meta' and 'response'.
                        // This is how we get the 'response' field
                        let responseFieldDictionary = responseDictionary["response"] as! NSDictionary
                        
                        // This is where you will store the returned array of posts in your posts property
                        self.posts = responseFieldDictionary["posts"] as! [NSDictionary]
                        self.table.reloadData()
                    }
                }
        });
        task.resume()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        cell.label.text = "This is row:\(indexPath.row)"        // Configure YourCustomCell using the outlets that you've defined.
        let post = posts[indexPath.row]
        let photos = post.value(forKeyPath: "photos") as? [NSDictionary]
        if (post.value(forKeyPath: "photos") as? [NSDictionary]) != nil {
            // photos is NOT nil, go ahead and access element 0 and run the code in the curly braces
            let imageUrlString = photos![0].value(forKeyPath: "original_size.url") as? String
            let imageUrl = NSURL(string: imageUrlString!)!
            if let imageUrl = NSURL(string: imageUrlString!) {
                // NSURL(string: imageUrlString!) is NOT nil, go ahead and unwrap it and assign it to imageUrl and run the code in the curly braces
                  cell.photoImageView.setImageWith(imageUrl as URL)
            } else {
                // NSURL(string: imageUrlString!) is nil. Good thing we didn't try to unwrap it!
            }
        } else {
            // photos is nil. Good thing we didn't try to unwrap it!
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the index path from the cell that was tapped
        let indexPath = table.indexPathForSelectedRow
        // Get the Row of the Index Path and set as index
        let index = indexPath?.row
        // Get in touch with the DetailViewController
        let detailViewController = segue.destination as! DetailViewController
        // Pass on the data to the Detail ViewController by setting it's indexPathRow value
        detailViewController.index = index
        let cell = self.table.cellForRow(at: indexPath!) as! PhotoCell
        detailViewController.passedimage = cell.photoImageView.image
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
