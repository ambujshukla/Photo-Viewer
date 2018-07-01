//
//  PhotoGalleryViewModel.swift
//  Photo Viewer
//
//  Created by cdn68 on 29/06/18.
//  Copyright © 2018 cdn. All rights reserved.
//

import Foundation
import UIKit

struct PhotoGalleryViewModel {
    var access_token: String = ""
    var userMediaItemList: InstagramModel?
}

extension PhotoGalleryViewModel
{
    func getInstagramMediaList(completion: @escaping ((InstagramModel) -> Void)) {
        let apiManager = APIManager()
        apiManager.getMediaItems(url: "\(INSTAGRAM_IDS.INSTAGRAM_GET_USER_MEDIA_ITEMS)\(self.access_token)", parameters: [:], completion: { (responseData) in
            do {
                if let data = responseData.data {
                    let decoder = JSONDecoder()
                    let mediaList = try decoder.decode(InstagramModel.self, from: data)
                    print(mediaList)
                    completion(mediaList)
                }
            } catch  {
                 CommonUtility.showErrorCRNotifications(title: NSLocalizedString("app.title", comment: "Title of the app") , message: NSLocalizedString("title.error.occur", comment: "Error occured due to some problem in server."))
            }
        }) { (error) in
            CommonUtility.showErrorCRNotifications(title: NSLocalizedString("app.title", comment: "Title of the app") , message: (error?.localizedDescription)!)
        }
    }
    
    func logout(navC: UINavigationController) {
        let cookieJar : HTTPCookieStorage = HTTPCookieStorage.shared
        for cookie in cookieJar.cookies! as [HTTPCookie]{
            if cookie.domain == "www.instagram.com" ||
                cookie.domain == "api.instagram.com" || cookie.domain == ".instagram.com" {
                cookieJar.deleteCookie(cookie)
                UserDefaults.standard.set(nil, forKey: UserDefaultsKeys.AuthToken)
                navC.popViewController(animated: true)
            }
        }
    }
}
