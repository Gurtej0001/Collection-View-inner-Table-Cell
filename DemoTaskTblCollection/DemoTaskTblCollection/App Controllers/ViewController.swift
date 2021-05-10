//
//  ViewController.swift
//  DemoTaskTblCollection
//
//  Created by Rakesh Gupta on 5/8/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate{
    

    @IBOutlet weak var tblView: UITableView!
    
    var arrCount = ["1"]
    var arrImages = [ImageModelData]()
    var imagePicker = UIImagePickerController();
    var tagBtnImage = 0
    var tagCollection = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dict = ["tagNum" : 0, "arrImage" : [], "textValue":""] as [String : Any]
        let data = ImageModelData.init(data: dict)
        self.arrImages.append(data)
       
    }

    //MARK:- UITextFields Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method

    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
        arrImages[textField.tag].textValue = textField.text!
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        arrImages[textField.tag].textValue = textField.text!
      textField.resignFirstResponder()

        return true
    }

    //MARK:- UITableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCount.count
    }
    
    private func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? TableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        tagCollection = indexPath.row
        
        if arrImages[tagCollection].arrImage.count > 0 {
            cell.layoutImageViewHeight.constant = 100
        }else{
            cell.layoutImageViewHeight.constant = 0
        }
        
        cell.collecViewPics.reloadData()
        cell.txtField.tag = indexPath.row
        cell.txtField.text = arrImages[indexPath.row].textValue
        cell.txtField.delegate = self
        cell.btnUploadImage.tag = indexPath.row
        cell.btnUploadImage.addTarget(self, action: #selector(btnUploadPicAction(_:)), for: .touchUpInside)
        cell.btnAddPanel.tag = indexPath.row
        cell.btnAddPanel.addTarget(self, action: #selector(btnAddPanelAction(_:)), for: .touchUpInside)
        if arrCount.count - 1 == indexPath.row{
            cell.btnAddPanel.isHidden = false
        }else{
            cell.btnAddPanel.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK:- UICollectionView Delegets
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrImages[tagCollection].arrImage.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollecPictureViewCell", for: indexPath) as! CollecPictureViewCell
        let data = arrImages[tagCollection]
        cell.imgView.image = data.arrImage[indexPath.row] as? UIImage
        let strTag = "\(tagCollection)" + "\(indexPath.row)"
        print(strTag)
        cell.btnCross.tag = Int(strTag)!
        cell.btnCross.addTarget(self, action: #selector(btnRemoveImageAction(_:)), for: .touchUpInside)
        return cell
    }
    
    //MARK:- image Picker functions
    
      func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
              self.present(imagePicker, animated: true, completion: nil)
          }else{
            
          }
      }

      func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
          self.present(imagePicker, animated: true, completion: nil)
      }

    //MARK:- UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        arrImages[tagBtnImage].arrImage.append(tempImage)
        print(arrImages[tagBtnImage].arrImage.count)
        self.tblView.reloadData()
       // self.tblView.reloadRows(at: [tagBtnImage, with: .fade)
       self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        print("picker cancel.")
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- UIButtons Action
    @IBAction func btnAddPanelAction(_ sender: UIButton){
        arrCount.append("\(sender.tag)")
        let dict: [String : Any] = ["tagNum" : sender.tag, "arrImage" : [], "textValue":""]
        let data = ImageModelData.init(data: dict)
        self.arrImages.append(data)
      
        self.tblView.reloadData()
    }
    
    @IBAction func btnRemoveImageAction(_ sender: UIButton){
        let strTag = "\(sender.tag)"
        let strTagFirst = strTag.first
        let strTagLast = strTag.last
        print(strTagFirst ?? "")
        print(strTagLast ?? "")
        let intTagFirst: Int = Int(String(strTagFirst!))!
        let intTagLast: Int = Int(String(strTagLast!))!
        arrImages[intTagFirst].arrImage.remove(at: intTagLast)
        self.tblView.reloadData()
    }
    
    @IBAction func btnUploadPicAction(_ sender: UIButton){
        tagBtnImage = sender.tag
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
