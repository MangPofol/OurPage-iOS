//
//  Book.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/13.
//

import UIKit.UIImage

struct BookclubBook: Codable {
    var userId: Int
    var userNickname: String
    var bookId: Int
    var bookName: String
    var isbn: String
    var category: String
    var createdDate: Date
    var modifiedDate: Date
}

struct BookModel: Codable {
    var category: String
    var createdDate: String
    var id: Int
    var isbn: String
    var modifiedDate: String
    var name: String
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(category, forKey: .category)
        try container.encode(createdDate, forKey: .createdDate)
        try container.encode(id, forKey: .id)
        try container.encode(isbn, forKey: .isbn)
        try container.encode(modifiedDate, forKey: .modifiedDate)
        try container.encode(name, forKey: .name)
    }
}

struct Book {
    var bookModel: BookModel
    var searchedInfo: SearchedBook?
}

struct Liked: Codable {
    var userNickname: String
    var isLiked: Bool
}

struct BookToCreate: Codable {
    var name: String
    var isbn: String
    var category: String
}

struct SearchedResult: Codable {
    var documents: [SearchedBook]
    var meta: SearchedMeta
}

struct SearchedBook: Codable {
    var authors: [String]
    var contents: String
    var datetime: String
    var isbn: String
    var price: Int
    var publisher: String
    var sale_price: Int
    var status: String
    var thumbnail: String
    var title: String
    var translators: [String]
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case authors
        case contents
        case datetime
        case isbn
        case price
        case publisher
        case sale_price
        case status
        case thumbnail
        case title
        case translators
        case url
    }
}

struct SearchedMeta: Codable {
    var is_end: Bool
    var pageable_count: Int
    var total_count: Int
    
    enum CodingKeys: String, CodingKey {
        case is_end
        case pageable_count
        case total_count
    }
}

//"authors": [
//        "헤르만 헤세"
//      ],
//      "contents": "현실에 대결하는 영혼의 발전을 담은 헤르만 헤세의 걸작 『데미안』. 독일 문학의 거장이자 노벨문학상 수상작가 헤르만 헤세의 자전적 소설이다. 1차 세계대전 직후인 1919년 에밀 싱클레어라는 가명으로 발표했던 작품으로, 열 살 소년이 스무 살 청년이 되기까지 고독하고 힘든 성장의 과정을 그리고 있다. 불안과 좌절에 사로잡힌 청춘의 내면을 다룬 이 작품은 지금까지 수많은 청년세대의 마음에 깊은 울림을 전하고 있다.  목사인 부친과 선교사의 딸인 모친 사이",
//      "datetime": "2009-01-20T00:00:00.000+09:00",
//      "isbn": "8937460440 9788937460449",
//      "price": 8000,
//      "publisher": "민음사",
//      "sale_price": 7200,
//      "status": "정상판매",
//      "thumbnail": "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F540810%3Ftimestamp%3D20210915175303",
//      "title": "데미안(세계문학전집 44)",
//      "translators": [
//        "전영애"
//      ],
//      "url": "https://search.daum.net/search?w=bookpage&bookId=540810&q=%EB%8D%B0%EB%AF%B8%EC%95%88%28%EC%84%B8%EA%B3%84%EB%AC%B8%ED%95%99%EC%A0%84%EC%A7%91+44%29"
