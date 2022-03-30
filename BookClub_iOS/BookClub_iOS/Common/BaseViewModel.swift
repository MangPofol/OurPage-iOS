//
//  BaseViewModel.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/30.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input? { get set }
    var output: Output { get }
}
