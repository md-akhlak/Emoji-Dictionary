//
//  EmojiTableViewController.swift
//  emojiDictionary
//
//  Created by kiran singh on 29/11/24.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    
    var  emojis:[Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face",description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face",description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes",description: "A smiley face with hearts for eyes.",usage: "love of something; attractive"),
        Emoji(symbol: "🧑‍💻", name: "Developer",description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software,programming"),
        Emoji(symbol: "🐢", name: "Turtle", description:"A cute turtle.", usage: "something slow"),
        Emoji(symbol: "🐘", name: "Elephant", description:"A gray elephant.", usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti",description: "A plate of spaghetti.", usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent", description: "A mall tent.", usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books",description: "Three colored books stacked on each other.",usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart",description: "A red, broken heart.", usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore",description:"Three blue \'z\'s.", usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag",description: "A black-and-white checkered flag.", usage:"completion")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.leftBarButtonItem = editButtonItem
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        
        
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return emojis.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell

        // Configure the cell...
        let emoji = emojis[indexPath.row]
        
//        var content = cell.defaultContentConfiguration()
//        content.text = "\(emoji.symbol)- \(emoji.name)"
//        content.secondaryText = emoji.description
//        cell.contentConfiguration = content
        cell.update(with: emoji)
        cell.showsReorderControl = true
//cell.accessoryType = .detailDisclosure
        

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let emoji = emojis[indexPath.row]
        print("\(emoji.symbol)\(indexPath)")
        
        
    }
    
   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
    


    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(movedEmoji, at: to.row)

    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBSegueAction func addEditEmoji(_ coder: NSCoder, sender: Any?) -> AddEditEmojiViewController? {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            let emojiToEdit = emojis[indexPath.row]
            return AddEditEmojiViewController(coder: coder, emoji: emojiToEdit)
        } else{
            return AddEditEmojiViewController(coder: coder, emoji: nil)
        }
    }
    
    
    
    @IBAction func unwindToEmojiTableView(segue : UIStoryboardSegue) {
        
        guard segue.identifier == "saveUnwind",
        let sourceViewController = segue.source as? AddEditEmojiViewController,
        let emoji = sourceViewController.emoji else {
            return
        }
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else{
            let newIndexPath = IndexPath(row: emojis.count, section: 0)
            emojis.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    
}
