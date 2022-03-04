//
//  SIViewModel.swift
//  UpstoxCoding
//
//  Created by Lokesh Vyas on 03/03/22.
//

import Foundation


protocol SIVMProtocol:AnyObject {
    func didSuccess()
    func didFail()
}

class SIViewModel {
    weak var delegate : SIVMProtocol?
    var listOfHoldingData: ListOfHoldings?
    
    var getSumOfCurrentValue: Double {
        let sum = listOfHoldingData?.data.map({ Double($0.ltp) * Double($0.quantity) }).reduce(0, +) ?? 0.0
        return sum
    }
    
    var totalInvestment: Double {
        let sum = listOfHoldingData?.data.map({ Double($0.avgPrice) ?? 0.0 - Double($0.quantity) }).reduce(0, +) ?? 0.0
        return sum
    }
    
    var totalPNL: Double {
        return self.getSumOfCurrentValue - self.totalInvestment
    }
    
    var todayPNL: Double {
        let sum = listOfHoldingData?.data.map({ (Double($0.close) - Double($0.ltp)) * Double($0.quantity) }).reduce(0, +) ?? 0.0
        return sum
    }

    
    func getPL(row:Int) -> String {
        return String(self.getItemCurrentValue(row: row) - self.getItemInvestmentValue(row: row))
    }
    
    func getItemCurrentValue(row:Int) -> Double {
        let currentValue = Double(listOfHoldingData?.data[row].ltp ?? 0.0) * Double(listOfHoldingData?.data[row].quantity ?? 0)
        return currentValue
    }
    
    func getItemInvestmentValue(row:Int) -> Double {
        let investmentValue = ((Double(listOfHoldingData?.data[row].avgPrice ?? "0") ?? 0.0) - Double(listOfHoldingData?.data[row].quantity ?? 0))
        return investmentValue
    }
        
    func fetchAllData() {
        let apiClient = APIClient()
        apiClient.fetch(request: self, basePath: NETWORK_CONSTANTS.BASE_PATH, keyDecodingStrategy: .useDefaultKeys, completionHandler: { (response:Result<ListOfHoldings,NetworkError>) in
            switch response {
            case .success(let success):
                DispatchQueue.main.async {
                    self.listOfHoldingData = success
                    self.delegate?.didSuccess()
                }
            case .failure(_):
                self.delegate?.didFail()
            }
        })
    }
}

extension SIViewModel : APIData {
    var path: String {
        return "v3/6d0ad460-f600-47a7-b973-4a779ebbaeaf"
    }
    var method: HTTPMethod {
        .get
    }
    var parameters: RequestParams {
        return RequestParams(urlParameters: nil, bodyParameters: nil)
    }
    var headers: [String : String]? {
        return nil
    }
    var dataType: ResponseDataType {
        return .JSON
    }
}
