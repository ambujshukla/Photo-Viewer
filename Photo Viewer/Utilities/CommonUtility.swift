//
//  CommonUtility.swift
//  Photo Viewer
//
//  Created by cdn68 on 29/06/18.
//  Copyright © 2018 cdn. All rights reserved.
//

import Foundation
import CRNotifications
import NVActivityIndicatorView

private let kActivityIndicatorWidth: CGFloat = 100.0
private let kActivityIndicatorHeight: CGFloat = 100.0

class CommonUtility: NSObject, NVActivityIndicatorViewable {
    
    class func createCustomRightButton(_ target:AnyObject,navBarItem:UINavigationItem,strImage:NSString,select:Selector){
        let buttonEdit: UIButton = UIButton(type: .custom)
        buttonEdit.contentHorizontalAlignment = .right
        buttonEdit.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        buttonEdit.setImage(UIImage(named:strImage as String), for: UIControlState())
        buttonEdit.addTarget(target, action: select, for: UIControlEvents.touchUpInside)
        let rightBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonEdit)
        navBarItem.setRightBarButton(rightBarButtonItemEdit, animated: false)
    }
    
    class func createCustomLeftButton(_ target:AnyObject,navBarItem:UINavigationItem,strImage:NSString,select:Selector){
        let buttonEdit: UIButton = UIButton(type: .custom)
        buttonEdit.contentHorizontalAlignment = .left
        buttonEdit.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        buttonEdit.setImage(UIImage(named:strImage as String), for: UIControlState())
        buttonEdit.addTarget(target, action: select, for: UIControlEvents.touchUpInside)
        let rightBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonEdit)
        navBarItem.setLeftBarButton(rightBarButtonItemEdit, animated: false)
    }
    
    class func showErrorCRNotifications(title : String , message : String) {
        CRNotifications.showNotification(type: CRNotifications.error, title: title, message: message, dismissDelay: 5)
    }
    
    class func showSuccessCRNotifications(title : String , message : String) {
        CRNotifications.showNotification(type: CRNotifications.success, title: title, message: message, dismissDelay: 5)
    }
    
    /**
     *  It will show loading mask.
     */
    
    class func startLoader() {
        let activityData = ActivityData(size: CGSize(width: kActivityIndicatorWidth, height: kActivityIndicatorHeight), message: "", messageFont: UIFont.systemFont(ofSize: FONT_SIZE_16), messageSpacing: 0, type: .ballRotateChase, color: appColor(), padding: 0, displayTimeThreshold: 3, minimumDisplayTime: 1, backgroundColor:  UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), textColor: UIColor.gray)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    /**
     *  It will hide loading mask.
     */
    class func stopLoader() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    class func dzEmptySetTitle(title: String) -> NSAttributedString {
        let string = title
        let myAttribute = [NSAttributedStringKey.foregroundColor: UIColor.black]
        return NSAttributedString(string: string, attributes: myAttribute)
    }
}
