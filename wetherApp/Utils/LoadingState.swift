//
//  LoadingState.swift
//  wetherApp
//
//  Created by Aisha Suanbekova Bakytjankyzy on 11.04.2025.
//

import Foundation

enum LoadingState<T> {
    case idle
    case loading
    case success(T)
    case failure(Error)
}
