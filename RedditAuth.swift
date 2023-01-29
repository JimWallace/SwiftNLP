//
//  RedditAuth.swift
//  Basic use of Alamofire to authenticate an app through Reddit's API
//
//  Created by Jim Wallace on 2023-01-25.
//

import Foundation
import Alamofire

// Application ID/Token
let client_id = "XXXXX"
let client_secret = "YYYYY"


var headers: HTTPHeaders = [
    "User-Agent" : "SwiftNLP",
]

let parameters: [String: String] = [
    "grant_type": "client_credentials"
]

struct RedditAuthResponse: Decodable
{
    let access_token: String
    let token_type: String
    let expires_in: Int
    let scope: String
}

AF.request("https://www.reddit.com/api/v1/access_token", method: .post, parameters: parameters, headers: headers)
    .authenticate(username: client_id, password: client_secret)
    .responseDecodable(of: RedditAuthResponse.self) { response in
        switch response.result {
            case .success( let data ):
                headers.add(name: "Authorization", value: "bearer \(data.access_token)")
                debugPrint("access_token = \(data.access_token)")
            case .failure(let error):
                debugPrint("Failure to Authenticate: \(error)")
        }
    }
