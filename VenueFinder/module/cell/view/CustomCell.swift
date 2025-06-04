//
//  CustomCell.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 28/04/2025.
//

import Foundation
import UIKit


protocol CustomCellDelegate: AnyObject {
    func failedToFetchImage(error: CustomError)
}

final class CustomCell : UITableViewCell {
    
    private var customCellViewModel: CustomCellViewModelInterface!
    private var storageManager: StorageManagerInterface!
    private var localIndexPath: IndexPath!
    private var contentData : Venue?, customDataSource : [Venue] = []
    
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    weak var delegate : CustomCellDelegate?
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBAction func toggleFavouriteButton(_ sender: UIButton) {
        let indexPath = sender.tag
        guard let key = customDataSource[indexPath].id else {return}
        guard let updatedStatus = customCellViewModel?.getSavedStatus(key) else {return}
        customCellViewModel?.saveInDatabase(!updatedStatus, key)
        let imageName = !updatedStatus ? "heart.fill" : "heart"
        favouriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favouriteButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        favouriteButton.alpha = 0
        animateFavouriteButton(sender.tag)
    }
    
    
    private func animateFavouriteButton(_ tag: Int) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8, delay: 0.03 * Double(tag), options: [.curveEaseOut], animations: {
                self.favouriteButton.transform = .identity
                self.favouriteButton.alpha = 1
            }, completion: nil)
        }
    }
    private func setupViewModel() {
        storageManager = StorageManager.sharedStorageManagerInstance
        customCellViewModel = CustomCellViewModel(dataBaseManager: storageManager as! StorageManager)
    }
    
    func configureCell(with data: Venue, dataSource: [Venue], indexPath: IndexPath) {
        setupViewModel()
        localIndexPath = indexPath
        contentData = data
        customDataSource = dataSource
        
        titleLabel.text = data.name
        descriptionLabel.text = data.shortDescription
        guard let imageURL = data.imageURL else { return }
        updateThumbnailImage(withImageURL: imageURL)
        
        favouriteButton.tag  = indexPath.row
        let imageName = data.isFavourite ? "heart.fill" : "heart"
        favouriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favouriteButton.backgroundColor = .white
        favouriteButton.tintColor = .systemRed
        layoutButtonView()
    }
    
    
    private func layoutBaseView() {
        baseView.clipsToBounds = false
        baseView.backgroundColor = .white
        //Modifying properties of a view's layer off the main thread is not recommended
        DispatchQueue.main.async {
            self.baseView.layer.cornerRadius = 12
            self.baseView.layer.shadowColor = UIColor.black.cgColor
            self.baseView.layer.shadowOffset = CGSize(width: 0, height: 4)
            self.baseView.layer.shadowOpacity = 0.1
            self.baseView.layer.shadowRadius = 6
            self.baseView.layer.masksToBounds = false
        }
    }
    
    private func layoutThumbnailImageView() {
        //Modifying properties of a view's layer off the main thread is not recommended
        DispatchQueue.main.async {
            self.thumbnailImageView.layer.shadowOffset = CGSize(width: -1, height: -2)
            self.thumbnailImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.thumbnailImageView.layer.shadowColor = UIColor.black.cgColor
            self.thumbnailImageView.layer.shadowRadius = 12
            self.thumbnailImageView.layer.shadowOpacity = 0.3
            self.thumbnailImageView.layer.cornerRadius = 12
        }
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true        
    }
    
    
    private func layoutButtonView() {
        favouriteButton.backgroundColor = .white
        //Modifying properties of a view's layer off the main thread is not recommendedaile
        DispatchQueue.main.async {
            self.favouriteButton.layer.cornerRadius = self.favouriteButton.frame.height / 2
            self.favouriteButton.layer.masksToBounds = true
            self.favouriteButton.layer.shadowColor = UIColor.black.cgColor
            self.favouriteButton.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.favouriteButton.layer.shadowOpacity = 0.2
            self.favouriteButton.layer.shadowRadius = 4
            self.favouriteButton.layer.borderWidth = 0
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5))
        layoutBaseView()
        layoutThumbnailImageView()
        layoutButtonView()
    }
    
    private func updateThumbnailImage(withImageURL imageURL: String) {
        customCellViewModel?.loadImage(withImageURL: imageURL) { [weak self] data, error  in
            if(error == nil) {
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.thumbnailImageView.image = image
                }
            } else {
                self?.delegate?.failedToFetchImage(error: error ?? CustomError.unknownError)
            }
        }
    }
}
