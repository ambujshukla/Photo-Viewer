//
//  APIManager.swift
//  PPL
//
//  Created by cdn68 on 31/05/18.
//  Copyright © 2018 cdn. All rights reserved.
//

import Foundation
import Alamofire

private let InvalidAccessToken: Int = 2

class APIManager {
        
    func getMediaItems(url:String, parameters: [String : Any], completion: @escaping ((DataResponse<Any>) -> Void),failure: @escaping ((NSError?)) -> Void) {
        self.callService(url: url, parameters: parameters, completion: { (responseData) in
            completion(responseData)
        }) { (error) in
            failure(error as NSError?)
        }
    }
    
    func callService(url: String, parameters: [String : Any], completion: @escaping ((DataResponse<Any>) -> Void), failure: @escaping ((NSError?) -> Void))
    {
        NetworkManager.isUnreachable { _ in
            CommonUtility.showErrorCRNotifications(title: NSLocalizedString("app.title", comment: "Title in the banner"), message: NSLocalizedString("title.no.internet", comment: "When there is no internet connection."))
            return
        }
        CommonUtility.startLoader()

        Alamofire.request(url, method: .get , parameters: [:], encoding: URLEncoding.default , headers: nil).responseJSON {response in
            print(response)
            CommonUtility.stopLoader()
            if response.result.error == nil {

                completion(response)
            }else {
                CommonUtility.stopLoader()
                failure(response.result.error as NSError?)
            }
        }
    }
}
