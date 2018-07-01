//
//  Constant.swift
//  Photo Viewer
//
//  Created by Ambuj Shukla on 29/06/18.
//  Copyright © 2018 cdn. All rights reserved.
//

import Foundation
import UIKit

struct INSTAGRAM_IDS {
    
    static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
    
    static let INSTAGRAM_APIURl  = "https://api.instagram.com/v1/users/"
    
    static let INSTAGRAM_CLIENT_ID  = "775e5a5be69d4b3cb782b0d871fd7228"
    
    static let INSTAGRAM_CLIENTSERCRET = "  8f4b87e3453047b1b81ffb1d181a2146"
    
    static let INSTAGRAM_REDIRECT_URI = "https://www.cdnsol.com/"
        
    static let INSTAGRAM_SCOPE = "basic"
    
    static let INSTAGRAM_GET_ACCESS_TOKEN = "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True"
    
    static let INSTAGRAM_GET_USER_MEDIA_ITEMS = "https://api.instagram.com/v1/users/self/media/recent/?access_token="
}

//MARK: Fonts
let FONT_SIZE_8  : CGFloat      = 8
let FONT_SIZE_9  : CGFloat      = 9
let FONT_SIZE_10 : CGFloat      = 10
let FONT_SIZE_11 : CGFloat      = 11
let FONT_SIZE_12 : CGFloat      = 12
let FONT_SIZE_13 : CGFloat      = 13
let FONT_SIZE_14 : CGFloat      = 14
let FONT_SIZE_15 : CGFloat      = 15
let FONT_SIZE_16 : CGFloat      = 16
let FONT_SIZE_17 : CGFloat      = 17
let FONT_SIZE_18 : CGFloat      = 18
let FONT_SIZE_19 : CGFloat      = 19
let FONT_SIZE_20 : CGFloat      = 20
let FONT_SIZE_21 : CGFloat      = 21
let FONT_SIZE_22 : CGFloat      = 22
let FONT_SIZE_23 : CGFloat      = 23
let FONT_SIZE_24 : CGFloat      = 24
let FONT_SIZE_25 : CGFloat      = 25
let FONT_SIZE_26 : CGFloat      = 26
let FONT_SIZE_27 : CGFloat      = 27
let FONT_SIZE_28 : CGFloat      = 28
let FONT_SIZE_29 : CGFloat      = 29
let FONT_SIZE_30 : CGFloat      = 30
let FONT_SIZE_31 : CGFloat      = 31
let FONT_SIZE_32 : CGFloat      = 32
let FONT_SIZE_33 : CGFloat      = 33
let FONT_SIZE_34 : CGFloat      = 34
let FONT_SIZE_35 : CGFloat      = 35

//UserDefaults
struct UserDefaultsKeys {
    static let AuthToken = "authtoken"
}

//MARK: Colors
func color(red : Float , green : Float , blue : Float) -> UIColor{
    return UIColor(red:CGFloat(red/255.0) , green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: 1.0)
}

func appColor() -> UIColor{
    return color(red: 161, green: 62, blue: 145)
}
