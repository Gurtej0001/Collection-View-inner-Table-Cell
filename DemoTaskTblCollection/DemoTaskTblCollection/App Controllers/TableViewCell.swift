//
//  TableViewCell.swift
//  DemoTaskTblCollection
//
//  Created by Rakesh Gupta on 5/8/21.
//

import UIKit

class TableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var lblTitleField: UILabel!
    @IBOutlet weak var btnUploadImage: UIButton!
    @IBOutlet weak var btnAddPanel: UIButton!
    
    @IBOutlet weak var collecViewPics: UICollectionView!
    @IBOutlet weak var layoutImageViewHeight: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func prepareForReuse() {
        // invoke superclass implementation
        super.prepareForReuse()
        
        
        

    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        collecViewPics.delegate = dataSourceDelegate
        collecViewPics.dataSource = dataSourceDelegate
        collecViewPics.tag = row
        collecViewPics.reloadData()
    }


}
