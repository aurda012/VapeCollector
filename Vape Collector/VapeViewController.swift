//
//  VapeViewController.swift
//  Vape Collector
//
//  Created by Alfredo Urdaneta on 7/7/17.
//  Copyright © 2017 AlfredosApps. All rights reserved.
//

import UIKit

class VapeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var vapeImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var addUpateVape: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var vape : Vape? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if vape != nil {
            vapeImageView.image = UIImage(data: vape!.image! as Data)
            titleTextField.text = vape?.title
            
            addUpateVape.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }
    
    @IBAction func addVapeTapped(_ sender: Any) {
        if vape != nil {
            vape!.title = titleTextField.text
            vape!.image = UIImagePNGRepresentation(vapeImageView.image!)! as NSData
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let vape = Vape(context: context)
            vape.title = titleTextField.text
            vape.image = UIImagePNGRepresentation(vapeImageView.image!)! as NSData
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        vapeImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(vape!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}
