//
//  HoldingsModel.swift
//  UpstoxCoding
//
//  Created by Lokesh Vyas on 03/03/22.
//

import Foundation

// MARK: - ListOfHoldings
struct ListOfHoldings: Codable {
    let clientID: String
    let data: [Datum]
    let error: String?
    let responseType: String
    let timestamp: Int

    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case data, error
        case responseType = "response_type"
        case timestamp
    }
}

extension ListOfHoldings {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ListOfHoldings.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        clientID: String? = nil,
        data: [Datum]? = nil,
        error: String? = nil,
        responseType: String? = nil,
        timestamp: Int? = nil
    ) -> ListOfHoldings {
        return ListOfHoldings(
            clientID: clientID ?? self.clientID,
            data: data ?? self.data,
            error: error ?? self.error,
            responseType: responseType ?? self.responseType,
            timestamp: timestamp ?? self.timestamp
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


// MARK: - Datum
struct Datum: Codable {
    let avgPrice: String
    let cncUsedQuantity, collateralQty: Int
    let collateralType: String
    let collateralUpdateQty: Int
    let companyName: String
    let haircut: Double
    let holdingsUpdateQty: Int
    let isin, product: String
    let quantity: Int
    let symbol: String
    let t1HoldingQty: Int
    let tokenBse, tokenNse: String
    let withheldCollateralQty, withheldHoldingQty: Int
    let ltp, close: Double

    enum CodingKeys: String, CodingKey {
        case avgPrice = "avg_price"
        case cncUsedQuantity = "cnc_used_quantity"
        case collateralQty = "collateral_qty"
        case collateralType = "collateral_type"
        case collateralUpdateQty = "collateral_update_qty"
        case companyName = "company_name"
        case haircut
        case holdingsUpdateQty = "holdings_update_qty"
        case isin, product, quantity, symbol
        case t1HoldingQty = "t1_holding_qty"
        case tokenBse = "token_bse"
        case tokenNse = "token_nse"
        case withheldCollateralQty = "withheld_collateral_qty"
        case withheldHoldingQty = "withheld_holding_qty"
        case ltp, close
    }
}

extension Datum {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Datum.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        avgPrice: String? = nil,
        cncUsedQuantity: Int? = nil,
        collateralQty: Int? = nil,
        collateralType: String? = nil,
        collateralUpdateQty: Int? = nil,
        companyName: String? = nil,
        haircut: Double? = nil,
        holdingsUpdateQty: Int? = nil,
        isin: String? = nil,
        product: String? = nil,
        quantity: Int? = nil,
        symbol: String? = nil,
        t1HoldingQty: Int? = nil,
        tokenBse: String? = nil,
        tokenNse: String? = nil,
        withheldCollateralQty: Int? = nil,
        withheldHoldingQty: Int? = nil,
        ltp: Double? = nil,
        close: Double? = nil
    ) -> Datum {
        return Datum(
            avgPrice: avgPrice ?? self.avgPrice,
            cncUsedQuantity: cncUsedQuantity ?? self.cncUsedQuantity,
            collateralQty: collateralQty ?? self.collateralQty,
            collateralType: collateralType ?? self.collateralType,
            collateralUpdateQty: collateralUpdateQty ?? self.collateralUpdateQty,
            companyName: companyName ?? self.companyName,
            haircut: haircut ?? self.haircut,
            holdingsUpdateQty: holdingsUpdateQty ?? self.holdingsUpdateQty,
            isin: isin ?? self.isin,
            product: product ?? self.product,
            quantity: quantity ?? self.quantity,
            symbol: symbol ?? self.symbol,
            t1HoldingQty: t1HoldingQty ?? self.t1HoldingQty,
            tokenBse: tokenBse ?? self.tokenBse,
            tokenNse: tokenNse ?? self.tokenNse,
            withheldCollateralQty: withheldCollateralQty ?? self.withheldCollateralQty,
            withheldHoldingQty: withheldHoldingQty ?? self.withheldHoldingQty,
            ltp: ltp ?? self.ltp,
            close: close ?? self.close
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
