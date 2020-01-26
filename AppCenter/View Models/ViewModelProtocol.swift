//
//  ViewModelProtocol.swift
//  AppCenter
//
//  Created by Dmitriy Medyannik on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
