//
//  KidsChannelException.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import Foundation

/**
 KidsChannel 에서 발생될 수 있는 Error 들
 */
public enum KidsChannelException: Error {
    /// 내부에서 사용되는 DB Error
    case DatabaseProcessError(String)
    /// 내부에서 예상치 못할때 발생되는 Error
    case InternalException(String)
    /// 서버 접속실패시 발생되는 Error
    case ServerConnectionFail()
    /// 서버와 시도시 발생되는 네트워크 Error
    case NetworkError(Error)
    case ErrorFromServer(String)
}
