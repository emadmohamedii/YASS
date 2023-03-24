////
////  GeneralResponse.swift
////  MovieApp
////
////  Created by Emad Habib on 06/12/2020.
////  Copyright © 2020 MAC240. All rights reserved.
////
//
//import Foundation
//
//class TokenResponse: Codable {
//
//    var success: Bool?
//    var requestToken: String?
//    var expires_at: String?
//
//    init(response: [String: Any]?) {
//        guard let response = response else {
//            return
//        }
//        if let moviesData = try? JSONSerialization.data(withJSONObject: response.keysToCamelCase, options: []) {
//            if let movieResponse = try? JSONDecoder().decode(TokenResponse.self, from: moviesData) {
//                self.success = movieResponse.success
//                self.requestToken = movieResponse.requestToken
//                self.expires_at = movieResponse.expires_at
//            }
//        }
//    }
//}
//
//class SessionResponse: Codable {
//
//    var success: Bool?
//    var session_id: String?
//
//    init(response: [String: Any]?) {
//        guard let response = response else {
//            return
//        }
//        if let moviesData = try? JSONSerialization.data(withJSONObject: response.keysToCamelCase, options: []) {
//            if let movieResponse = try? JSONDecoder().decode(SessionResponse.self, from: moviesData) {
//                self.success = movieResponse.success
//                self.session_id = movieResponse.session_id
//            }
//        }
//    }
//}
