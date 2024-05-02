//
//  MainView.swift
//  CyptoConvertor
//
//  Created by Malick Moro-Samah on 30/03/2024.
//

import SwiftUI

struct MainView: View {
    let options: [String] = [
        "BTC", "LTC", "USDT", "XMR"
    ]
    @State var selectedCrypto: String?
    @State var rate: String
    @State var usdAmount: String
    @State var cediAmount: String
    @State var fee: String = "$3.00"
    @State var quantity: String
    
    let service = NetworkService()
    
    var body: some View {
        VStack (alignment: .leading,spacing: 30){
            HStack{
                CryptoSelectionView(title: "Choose Crypto", prompt: "Select", options: options, selection: $selectedCrypto)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Enter Rate")
                        .font(.headline)
                        .foregroundStyle(.gray)
                    
                    TextField(text: $rate, prompt: Text("Rate")) {
                        
                    }
                    .padding()
                    .frame(width: 130, height: 50)
                    .background{
                        RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5)
                            .foregroundStyle(.gray )
                    }
                    .keyboardType(.decimalPad)
                }
            }
            
            HStack {

                VStack(alignment: .leading) {
                    
                    Text("Fee")
                        .font(.headline)
                        .foregroundStyle(.gray)
                    
                    TextField(text: $fee, prompt: Text("$3.00")) {
                        
                    }
                    .padding()
                    .frame(width: 130, height: 50)
                    .background{
                        RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5)
                    }
                    .foregroundStyle(.gray)
                    .disabled(true)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    Text("USD Amount")
                        .font(.headline)
                        .foregroundStyle(.gray)
                    
                    TextField(text: $usdAmount, prompt: Text("Amount")) {
                        
                    }
                    .padding()
                    .frame(width: 130, height: 50)
                    .background{
                        RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5)
                    }
                    .foregroundStyle(.gray)
                    .keyboardType(.decimalPad)
                }
            }
            
            
            VStack(alignment: .center) {
                
                Text("Amount In Cedis")
                    .font(.headline)
                    .foregroundStyle(.gray)
                
                
                HStack (spacing: 5){
                    Text("₵") // Symbol for the Ghanaian Cedi
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(.systemGray))

                    
                    TextField(text: $cediAmount, prompt: Text("Total")) {
                            
                        }
                        .font(.system(size: 65, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(.systemGray))
                        .disabled(true)
                }
            }
            
          
            
            HStack (){
                Text("Quantity")
                    .font(.system(.headline))
                
                Spacer()
                
                TextField("0.00", text: $quantity)
                    .frame(width: 200)
                    .font(.system(.title))
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = quantity
                        }) {
                            Text("Copy")
                            Image(systemName: "doc.on.doc")
                        }
                    }
            }
            Spacer()
        }
        .padding(50)
        .onChange(of: usdAmount) { newValue in
            // Update cediAmount
            if rate != "" && newValue != "" {
                cediAmount = String(format: "%.2f", service.getAmountInCedis(amount: Double(newValue) ?? 0, fee: 3.00 , rate: Double(rate) ?? 0))
            } else {
                cediAmount = String(format: "%.2f", 0.00)
            }
            
            // Call the asynchronous function
            Task {
                do {
                    let q = try await service.convertUsdToCrypto(Double(newValue) ?? 0, type: selectedCrypto ?? "BTC")
                    quantity = String(format: "%.5f", q)
                } catch {
                    print("Error")
                }
            }
        }
    }
}

#Preview {
    MainView(selectedCrypto: nil, rate: "", usdAmount: "", cediAmount: "", quantity: "")
}






// Get the price in cedis


//    Reset button
