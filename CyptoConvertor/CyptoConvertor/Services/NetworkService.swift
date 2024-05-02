import Foundation

struct CryptoList: Codable {
    let state: Int
    let result: [Crypto]
    
}

struct Crypto: Codable {
    let from: String?
    let to: String?
    let course: String?
}

enum MyErrors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

enum AmountErors: Error {
    case invalidAmount
}

class NetworkService {
    
    func getCryptoPrice(_ type: String) async throws -> String {
        let endpoint = "https://api.cryptomus.com/v1/exchange-rate/\(type)/list"
        
        guard let url = URL(string: endpoint) else { throw MyErrors.invalidURL}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MyErrors.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let list = try decoder.decode(CryptoList.self, from: data)
            let desiredToCurrency = "USD"
            
            let result = list.result.first(where: {$0.to == desiredToCurrency})
            return result?.course ?? "null"
        } catch {
            throw MyErrors.invalidData
        }
    }
    
    func convertUsdToCrypto(_ amount: Double, type: String ) async throws -> Double {
        guard let price = Double(try await getCryptoPrice(type)) else { throw AmountErors.invalidAmount }
        
        let cryptoAmount = amount / price
        
        return cryptoAmount
    }
    
    func getAmountInCedis(amount: Double, fee : Double, rate: Double ) -> Double {
        let amountInCedis = (amount + fee) * rate
        
        return amountInCedis
    }
    
    // Plutus Calculator

}
