//
//  AddTeachingGroupViewController.swift
//  CustomPickerView
//
//  Created by Tatiana Looby on 23/01/2017.
//  Copyright © 2017 Tatiana Looby. All rights reserved.
//

import UIKit

class AddTeachingGroupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var teachingGroupTextField: UITextField!
    
    @IBOutlet weak var roomNumberTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        teachingGroupTextField.delegate = self
        roomNumberTextField.delegate = self
        
        if (teachingGroupTextField.text?.isEmpty)! && (roomNumberTextField.text?.isEmpty)! {
            
            addButton.isUserInteractionEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addButton.isUserInteractionEnabled = true
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let teachingGroup = TeachingGroup(context: context)

        teachingGroup.name = teachingGroupTextField.text
        teachingGroup.room = roomNumberTextField.text
        
        //Save the core data
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //Go back to the tableview
        navigationController?.popViewController(animated: true)
        
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
