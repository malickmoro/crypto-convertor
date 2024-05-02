import SwiftUI

struct CryptoSelectionView: View {
    let title: String
    let prompt: String
    let options: [String]
    
    @State private var isExpanded = false
    @Binding var selection: String?
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.gray)
           
            VStack {
                HStack {
                    Text(selection ?? prompt)
                        .font(.title3)
                        .foregroundStyle((selection != nil) ? Color.primary : .gray)

                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .rotationEffect(.degrees(isExpanded ? -18 : 0))
                }
                .frame(height: 50)
                .background(scheme == .dark ? .black : .white)
                .padding(.horizontal)
                .onTapGesture { withAnimation(.smooth) { isExpanded.toggle() }
                }
                
                if isExpanded {
                    VStack {
                        ForEach(options, id: \.self) { option in
                            HStack {
                                Text(option)
                                    .foregroundStyle(selection == option ? Color.primary : .gray)
                                
                                Spacer()
                                
                                if selection == option {
                                    Image(systemName: "checkmark")
                                        .font(.subheadline)
                                }
                            }
                            .frame(height: 50)
                            .padding(.horizontal)
                            .onTapGesture {
                                withAnimation(.smooth) {
                                    selection = option
                                    isExpanded.toggle()
                                }
                            }
                            
                        }
                    }
                   // .transition(.move(edge: .bottom))
                }
            }
            .background(scheme == .dark ? .black : .white)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
            .frame(width: 130)
        }
    }
}


#Preview {
    CryptoSelectionView(title: "Select Crypto", prompt: "Select", options: [
        "LTC",
        "XMR",
        "USDT",
        "BTC"
        ], selection: .constant("LTC"))
}
