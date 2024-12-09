//
//  AddEditEmojiViewController.swift
//  emojiDictionary
//
//  Created by Batch - 2 on 09/12/24.
//

import UIKit

class AddEditEmojiViewController: UITableViewController {

    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var symbolTextField: UITextField!
    @IBOutlet var nameTextFiield: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var usageTextField: UITextField!
    
    
    var emoji: Emoji?
    init?(coder : NSCoder, emoji : Emoji?){
        self.emoji = emoji
        super.init(coder : coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let emoji = emoji{
            title = "Edit Emoji"
            symbolTextField.text = emoji.symbol
            nameTextFiield.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
        }else{
            title = "Add Emoji"
        }
    }
    func updateSaveButtonState(){
        //let symbolText = symbolTextField.text ?? ""
        let nameText = nameTextFiield.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        saveButton.isEnabled = containsSingleEmoji(symbolTextField) && !nameText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
    }
    
    @IBAction func textEditingChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    func containsSingleEmoji(_ textField: UITextField)->Bool{
        guard let text = textField.text, text.count == 1 else{
            return false
        }
        let isCombinedIntoEmoji = text.unicodeScalars.count > 1 && text.unicodeScalars.first?.properties.isEmoji ?? false
        
        let isPresented = text.unicodeScalars.first?.properties.isEmojiPresentation ?? false
        return isCombinedIntoEmoji || isPresented
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind"  else{
            return
        }
        
        let symbolText = symbolTextField.text ?? ""
        let nameText = nameTextFiield.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        
        emoji = Emoji(symbol: symbolText, name: nameText, description: descriptionText, usage: usageText)
        
        
    }
    
}
