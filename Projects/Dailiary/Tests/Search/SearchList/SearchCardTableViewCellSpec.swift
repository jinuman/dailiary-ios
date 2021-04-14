//
//  SearchCardTableViewCellSpec.swift
//  DailiaryTests
//
//  Created by Jinwoo Kim on 2021/03/17.
//

import DailiaryTest
import DailiaryUI
@testable import Dailiary

final class SearchCardTableViewCellSpec: QuickSpec {
    override func spec() {

        var reactor: SearchCardTableViewCellReactor!
        var cell: SearchCardTableViewCell!

        beforeEach {
            reactor = SearchCardTableViewCellReactor(
                document: DocumentFixture.blogNormal,
                isVisited: false
            )
            reactor.isStubEnabled = true
            cell = SearchCardTableViewCell()
            cell.reactor = reactor
        }

        describe("thumbnailImageView") {
            it("superview 는 contentView 입니다.") {
                let thumbnailImageView = cell.testables[\.thumbnailImageView]
                expect(thumbnailImageView.superview) == cell.contentView
            }
        }

        describe("typeLabel") {
            it("superview 는 contentView 입니다.") {
                let typeLabel = cell.testables[\.typeLabel]
                expect(typeLabel.superview) == cell.contentView
            }
        }

        describe("nameLabel") {
            it("superview 는 contentView 입니다.") {
                let nameLabel = cell.testables[\.nameLabel]
                expect(nameLabel.superview) == cell.contentView
            }
        }

        describe("titleLabel") {
            it("superview 는 contentView 입니다.") {
                let titleLabel = cell.testables[\.titleLabel]
                expect(titleLabel.superview) == cell.contentView
            }
        }

        describe("dateLabel") {
            it("superview 는 contentView 입니다.") {
                let dateLabel = cell.testables[\.dateLabel]
                expect(dateLabel.superview) == cell.contentView
            }
        }
    }
}
