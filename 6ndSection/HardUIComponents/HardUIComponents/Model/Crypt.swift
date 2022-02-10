//
//  Crypt.swift
//  HardUIComponents
//
//  Created by Sabir Myrzaev on 09.02.2022.
//

import Foundation

struct Crypt {
    var image: String
    var name: String
    var percent: Float
    var priceOnDollar: String
    var priceOnCrypt: String
}

struct CryptValues {
    static let values = [
        Crypt(image: "bitcoin", name: "Bitcoin", percent: 1.6, priceOnDollar: "29,850.15", priceOnCrypt: "2.73 BTC"),
        Crypt(image: "ethereum", name: "Ethereum", percent: -0.82, priceOnDollar: "10,561.24", priceOnCrypt: "47.61 ETH"),
        Crypt(image: "litecoin", name: "Litecoin", percent: -2.10, priceOnDollar: "3,676.24", priceOnCrypt: "39.27 LTC"),
        Crypt(image: "uniswap", name: "Uniswap", percent: 0.32, priceOnDollar: "5,241.62", priceOnCrypt: "16447.65 UNS"),
        Crypt(image: "shiba", name: "Shiba", percent: 0.27, priceOnDollar: "7,643.12", priceOnCrypt: "107.5 SHB"),
        Crypt(image: "meta", name: "Meta", percent: 6.66, priceOnDollar: "9,999.99", priceOnCrypt: "999.9 MET"),
        Crypt(image: "bitcoin", name: "Bitcoin", percent: 1.6, priceOnDollar: "29,850.15", priceOnCrypt: "2.73 BTC"),
        Crypt(image: "ethereum", name: "Ethereum", percent: -0.82, priceOnDollar: "10,561.24", priceOnCrypt: "47.61 ETH"),
        Crypt(image: "uniswap", name: "Uniswap", percent: 0.32, priceOnDollar: "5,241.62", priceOnCrypt: "16447.65 UNS"),
        Crypt(image: "shiba", name: "Shiba", percent: 0.27, priceOnDollar: "7,643.12", priceOnCrypt: "107.5 SHB")
    ]
}
