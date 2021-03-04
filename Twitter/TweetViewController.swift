//
//  TweetViewController.swift
//  Twitter
//
//  Created by Joey Steigelman on 2/28/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
    }
    
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var charLabel: UILabel!
    
    
    //stylize tweet text view
    func configureTweetTextView() {
        //add rounded corners
        tweetTextView.layer.cornerRadius = 20
        
        //add border
        tweetTextView.layer.borderWidth = 1
        tweetTextView.layer.borderColor = UIColor.red.cgColor
    }
    
    func textView(_ tweetTextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 280

        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)

        //update character count label
        //let charCount = "\(String(newText.count))/280"
        let charCount = String(280 - (newText.count))
        charLabel.text = charCount

        // The new text should be allowed? True/False
        return newText.count < characterLimit
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Eror posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
