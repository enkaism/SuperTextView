//
//  SuperTextView.swift
//  SuperTextView
//
//  Created by 木村舞由 on 11/20/15.
//  Copyright © 2015 daisuke_kobayashi. All rights reserved.
//
import UIKit

@IBDesignable
class SuperTextView : UIView, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    @IBInspectable var placeholder: String = "" {
        didSet {
            placeHolderLabel.text = placeholder
        }
    }
    
    @IBInspectable var maxLength: Int = -1 {
        didSet {
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        print("init")
        
        let bundle = NSBundle(forClass: SuperTextView.self)
        let nib = UINib(nibName: "SuperTextView", bundle: NSBundle(URL: bundle.URLForResource("SuperTextView", withExtension: "bundle")!))
        let view = nib.instantiateWithOwner(self, options: nil).first as! UIView
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        
        textView.delegate = self
        placeHolderLabel.font = textView.font
        textViewHeightConstraint.constant = textView.sizeThatFits(CGSizeMake(textView.frame.width, CGFloat(MAXFLOAT))).height
        
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        var length = textView.text.characters.count
        placeHolderLabel.text = length > 0 ? "" : placeholder
        if maxLength == -1 {
            
        } else if length > maxLength {
            let _text: NSMutableString = NSMutableString(string: textView.text)
            _text.deleteCharactersInRange(NSRange(location: textView.text.characters.count - 1, length: 1))
            textView.text = _text as String
            length--
        }
        countLabel.text = "\(length)"
        textViewHeightConstraint.constant = textView.sizeThatFits(CGSizeMake(textView.frame.width, CGFloat(MAXFLOAT))).height
    }
    
}