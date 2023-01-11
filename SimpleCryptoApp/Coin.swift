//
//  Coin.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 10.01.2023.
//  Crypto API CoinGecko:

/*
 API URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 JSON data:
 {"id":"bitcoin","symbol":"btc","name":"Bitcoin","image":"https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579","current_price":17336.97,"market_cap":333740944716,"market_cap_rank":1,"fully_diluted_valuation":363925535144,"total_volume":21784475193,"high_24h":17388.39,"low_24h":17166.32,"price_change_24h":-51.07283315281529,"price_change_percentage_24h":-0.29372,"market_cap_change_24h":-508995594.3944092,"market_cap_change_percentage_24h":-0.15228,"circulating_supply":19258225.0,"total_supply":21000000.0,"max_supply":21000000.0,"ath":69045,"ath_change_percentage":-74.90176,"ath_date":"2021-11-10T14:24:11.849Z","atl":67.81,"atl_change_percentage":25455.63873,"atl_date":"2013-07-06T00:00:00.000Z","roi":null,"last_updated":"2023-01-10T18:12:50.683Z","sparkline_in_7d":{"price":[16625.15316314591,16644.549377896135,16637.275962026877,16664.743079900876,16667.878267521923,16677.78938943784,16676.360309578547,16659.853022187872,16711.20715592948,16743.058685564134,16823.860040950694,16823.860040950694,16859.64110312,16847.414958668527,16870.3299147353,16868.97971869581,16873.663531434013,16839.31631698298,16840.379694210023,16836.715819170204,16812.569889413244,16828.855757828445,16844.44495295743,16849.2538753479,16861.65882922434,16925.521898016355,16972.97281021798,16833.71355871587,16811.06387455646,16824.22707232957,16826.44858550658,]},"price_change_percentage_24h_in_currency":-0.293723801205252}
 */

import Foundation

// MARK: - Coin
/// Model for coins
struct Coin: Codable, Identifiable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
    let high24H, low24H, priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    var currentHoldings: Double?
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]?
}

extension Coin {
    /// Instance of coin for preview
    static let example = CoinDataService().allCoins[0]
}
