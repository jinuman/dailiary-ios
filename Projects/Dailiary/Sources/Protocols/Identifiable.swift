//
//  Identifiable.swift
//  Dailiary
//
//  Created by Jinwoo Kim on 07/09/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import Foundation

protocol Identifiable {
    var id: UUID { get }
}

extension Identifiable {
    func isIdentical(to other: Identifiable) -> Bool {
        return id == other.id
    }
}
