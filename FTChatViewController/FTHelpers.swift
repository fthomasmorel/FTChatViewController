//
//  FTHelpers.swift
//  FTChatViewController
//
//  Created by Florent TM on 26/07/2015.
//  Copyright © 2015 Florent THOMAS-MOREL. All rights reserved.
//

import Foundation
import UIKit


let kMarginLeft:CGFloat = 10
let kMarginRight:CGFloat = 10
let kMarginTopFirst:CGFloat = 15
let kMarginTopNext:CGFloat = 2
let kMaxWidth:CGFloat = 240
let kCorderRadius:CGFloat = 10


extension UITextView {
    func sizeForMaxWidth(maxWidth:CGFloat) -> CGSize{
        let fixedWidth = maxWidth
        self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        return CGSize(width: min(newSize.width, fixedWidth), height: newSize.height)
    }
}


func heightForContent(content:String, andType type:FTMessageType) -> CGFloat{
    let textView = UITextView()
    textView.text = content
    textView.sizeToFit()
    var height = textView.sizeForMaxWidth(kMaxWidth).height
    switch(type){
    case .FirstReceived, .FirstSent:
        height += kMarginTopFirst*3
        break;
    case .NextReceived, .NextSent:
        height += kMarginTopNext*3
        break;
    }
    return height
}
