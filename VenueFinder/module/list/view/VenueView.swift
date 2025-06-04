//
//  ViewController.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 24/04/2025.
//

import UIKit
import Combine


protocol ViewModelDelegate: AnyObject {
    func didUpdateData()
    func didFailedToUpdateData(_ error: CustomError)
    func showLoader()
    func hideLoader()
}


class VenueView: UIViewController {
    
    private var viewModel: VenueViewModel?
    @IBOutlet weak var tableView: UITableView!
    private var activityIndicator : UIActivityIndicatorView!
    private var invokingServiceLayerInstance : ServiceInterface?
    private var locationService : LocationManagerInterface?

    private var alert : UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        configureView()
        configureLoader()
    }
    
    // setting up view model with prerequisite via service factory
    private func setupViewModel() {
        invokingServiceLayerInstance = ServiceFactory().createService(for: .network)
        locationService = ServiceFactory().createLocationService(for: .inMemoryLocation)
        viewModel = VenueViewModel(serviceManager: invokingServiceLayerInstance, locationManagerService: locationService)
        viewModel?.delegate = self
        viewModel?.fetchNearByRestaurants()
        
    }
    
    // registering nib for custom cell and no data cell
    private func configureView() {
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        tableView.register(UINib(nibName: "NoDataCell", bundle: nil), forCellReuseIdentifier: "NoDataCell")
        tableView.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.x, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    // configuring loader
    private func configureLoader(){
         activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.isHidden = false
        activityIndicator.color = .systemRed
/*
        if(UITraitCollection.current.userInterfaceStyle == .dark) {
 activityIndicator.color = .white

        } else {
            activityIndicator.color = .black
        }
  */
        view.addSubview(activityIndicator)
        showLoader()
        view.bringSubviewToFront(activityIndicator)
    }
    
    // configuring user friendly aler message
    func configureAlert(alertMessage : String) {
        alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
        alert?.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let alert = alert {
            DispatchQueue.main.async {
                self.present(alert , animated: true, completion: nil)
            }
        }
    }
}


// Hanlding Table View datasource method
extension VenueView : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (viewModel?.venues?.count == 0 || viewModel?.venues == nil) {
            return 0
        }
        return Constants.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (viewModel?.venues?.isEmpty == true) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataCell", for: indexPath)
            return cell
        } else {
            let  cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell
            guard let cell = cell else {
                return UITableViewCell()
            }
            if let item = viewModel?.venues?[indexPath.row], let datasource = viewModel?.venues,  let count = viewModel?.venues?.count, count > 0  {
                cell.configureCell(with: item, dataSource: datasource, indexPath: indexPath)
                cell.delegate = self
            }
            cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            cell.alpha = 0
            
            UIView.animate(withDuration: 0.8, delay: 0.03 * Double(indexPath.row), options: [.curveEaseOut], animations: {
                cell.transform = .identity
                cell.alpha = 1
            }, completion: nil)
            return cell
        }
        
    }
}


// CustomCell Delegate methods
extension VenueView: CustomCellDelegate {
    func failedToFetchImage(error: CustomError) {
        configureAlert(alertMessage: error.userFriendlyMessage())
    }

    
    // reloading table view on main thread
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
   
}

// delegates method to update itself based on the 
extension VenueView: ViewModelDelegate {
    
    // once successful update of data refresh table view
    func didUpdateData() {
        self.hideLoader()
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            UIView.transition(with: self.tableView, duration: 0.8, options: .curveEaseIn, animations: {
                self.tableView.reloadData()
            }, completion: nil)
        }
    }
    
    // hides loader and updates user with error message
    func didFailedToUpdateData(_ error: CustomError) {
        self.hideLoader()
        configureAlert(alertMessage: error.userFriendlyMessage())
    }
        
    
    // showing loader during network fetch
    func showLoader() {
        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
            self.tableView.isUserInteractionEnabled = false
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            self.activityIndicator?.hidesWhenStopped = true
            self.tableView.isUserInteractionEnabled = true
            self.view.isUserInteractionEnabled = true
        }
    }
}

