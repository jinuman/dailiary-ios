//
//  Diary.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 27/03/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import Foundation

class Diary {
    let id: UUID
    let createdAt: Date
    var text: String
    
    init(id: UUID = UUID(), createdAt: Date = Date(), text: String) {
        self.id = id
        self.createdAt = createdAt
        self.text = text
    }
}
