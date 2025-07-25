//
//  Cart.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/18/25.
//

import SwiftUI

struct Cart: View {
    @EnvironmentObject var languageManager : LanguageManager
    @EnvironmentObject var cartVM: CartViewModel
    @StateObject var cuisineVM = CuisineViewModel()
    @State var isActive: Bool = false
    @State var isActiveFailure: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    if cartVM.items.isEmpty {
                        VStack{
                            Image(systemName: "cart.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 80))
                            Text(languageManager.localText("Cart is empty","कार्ट खाली है",language: languageManager.currentLanguage))
                                .font(.system(size: 30))
                        }
                    } else {
                        let groupedItems = Dictionary(grouping: cartVM.items, by: { $0.cuisineID })
                        
                        let sortedCuisineIDs = groupedItems.keys.sorted()
                        List {
                            ForEach(sortedCuisineIDs, id: \.self) { cuisineID in
                                let cuisineName = cuisineVM.cuisines.first { $0.cuisine_id == cuisineID }?.cuisine_name ?? "Unknown Cuisine"
                                Section(header: Text("\(cuisineName)")) {
                                    ForEach(groupedItems[cuisineID] ?? []) { item in
                                        HStack {
                                            Text(item.name)
                                            Spacer()
                                            VStack{
                                                HStack(spacing: 12) {
                                                    Button("-") {
                                                        if cartVM.quantityForDish(itemID: item.id) > 0 {
                                                            cartVM.removeItem(item)
                                                        }
                                                    }
                                                    .buttonStyle(.plain)
                                                    
                                                    Text("\(cartVM.quantityForDish(itemID: item.id))")
                                                    
                                                    Button("+") {
                                                        cartVM.addItem(item)
                                                    }
                                                    .buttonStyle(.plain)
                                                }
                                                .padding(.vertical, 6)
                                                .padding(.horizontal, 12)
                                                .background(.ultraThinMaterial)
                                                .foregroundColor(.black)
                                                .clipShape(Capsule())
                                                .shadow(radius: 3)
                                                
                                                Text("₹\(item.price * item.quantity)")
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                            VStack(alignment: .trailing) {
                                Text(languageManager.localText(
                                    "SubTotal: ₹\(cartVM.netTotal)",
                                    "कुल :₹\(cartVM.netTotal)",
                                    language: languageManager.currentLanguage))
                                
                                Text("CGST: ₹\(String(format: "%.2f", cartVM.cgst))")
                                Text("SGST: ₹\(String(format: "%.2f", cartVM.sgst))")
                                Text(languageManager.localText(
                                    "Grand Total: ₹\(String(format: "%.2f", cartVM.grandTotal))",
                                    "कुल योग: ₹\(String(format: "%.2f", cartVM.grandTotal))",
                                    language: languageManager.currentLanguage))
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .listStyle(PlainListStyle())
                        Button(action: {
                            cartVM.makePayment { responseCode in
                                if responseCode == 200 {
                                    cartVM.clearCart()
                                    isActive = true
                                } else {
                                    isActiveFailure = true
                                }
                            }
                            
                        })
                        {
                            Text(languageManager.localText("Place Order","खरीदो",language: languageManager.currentLanguage))
                        }
                        .padding()
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        
                    }
                }
                if isActiveFailure {
                    if languageManager.currentLanguage == .english {
                        FailureDialog(isActive: $isActiveFailure)
                    }
                    else{
                        FailureDialog(isActive: $isActiveFailure,title:"ऑर्डर असफल हुआ", message:"अपना ऑर्डर देते समय कुछ मुद्दे हुए। कृपया बाद में पुन: प्रयास करें।", buttonTitle:"होम स्क्रीन पर जाएं")
                    }
                }
                if isActive {
                    if languageManager.currentLanguage == .english {
                        OrderPlacedDialog(isActive: $isActive)
                    }
                    else{
                        OrderPlacedDialog(isActive: $isActive,title:"ऑर्डर प्राप्त हुआ", message:"आपका ऑर्डर सफलतापूर्वक प्राप्त हो गया है और हम शीघ्र ही आप तक पहुंचेंगे। वनबैंक रेस्तरां का उपयोग करने के लिए धन्यवाद", buttonTitle:"होम स्क्रीन पर जाएं")
                    }
                }
            }
            .onAppear(){
                cuisineVM.fetchCuisinesIfNeeded()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            Toolbar(pageName: "Cart")
        }
    }

}

#Preview {
    Cart().environmentObject(CartViewModel())
        .environmentObject(LanguageManager())
}
