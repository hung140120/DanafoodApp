//
//  APIManager.swift
//  XoSo
//
//  Created by Dinh Hung on 4/21/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import Alamofire

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]
typealias AttributeObject = [NSAttributedString.Key: Any]
typealias ServiceCompletion = (Result<Any>) -> Void

let api = ApiManager()

final class ApiManager {
    let session = Sesstion()
    var defaultHTTPHeader: [String: String] {
        var headers: [String: String] = [:]
        let token = UDKey.User.token.value ?? ""
        if session.credential.isValid {
            headers["Content-Type"] = "application/json"
            headers["Authorization"] = "bearer X8FLRZA00N_ZNFYG1VhzI81iypt7BhUk8ax3sPwJUieP5wr5vmXVHqocn2iLr3_kGpCS__h8dd38e7YAm47qpncyXq4MDEBDtt_m1CzrEfEFVLK8pcZq7SGmBYWnst3Xzbhk65oCumq-kKBrFnonktoCEiMU0yvflfHg9AQDyL6oPHdoGuXYgPaFSIKlz-_bXjjqLSwHuV4PoBQGn_xqaw3049vSQ63HqZgJKLl9DeIrVhZWYoDaMCZdeYoCq71ByBXDHlCvxEiEURy1DB1lX6NzHvX11yI9yxmcY_g1l-ik4gR_rrSUVYO_nQnXYtBynv_txp2MgEJnUktl7BsuhrpGjNy4Mx--hqZlLFoGaY8rdUIkgGjEzHkxYNbipgrIenV8GH9bFAlvTarYwcIjfJVPF3XXndjyraEBm8r4AFY8LNDh9Km7qtThIkrVAfgkn2eRkyUEz8cTywtzDKEhdt3FrkdlSlimX7lv_jCXLkgCQo3o26DNMGjYzVHn3JKk90JiOh9ePIlFwb_0F6zAV38fWrVmUozkYzZSR5Qsaw_Ayt_wbh1z7GLT99g5jZK6o3iZZCmO7DKo1sq0pw8pxA"
            headers["access-token"] = api.session.credential.token
            headers["client"] = api.session.credential.client
        }
        return headers
    }
}
