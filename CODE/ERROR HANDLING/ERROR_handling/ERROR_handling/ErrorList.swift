//
//  ErrorList.swift
//  ERROR_handling
//
//  Created by LeeJaehoon on 2023/07/04.
//

import Foundation

enum TestError: Error {
    case invalidSelection
//    case insufficientFunds(coinsNeeded: Int)
    case outOfStock

    case notActive

}
