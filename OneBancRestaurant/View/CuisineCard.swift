import SwiftUI

struct CuisineCard: View {
    @StateObject private var viewModel: CuisineViewModel = CuisineViewModel()
    @State private var currentIndex: Int = 0
    @State private var showPreviousCard: Bool = false

    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            ZStack {
                ForEach(viewModel.cuisines.indices, id: \.self) { index in
                    if index == currentIndex {
                        NavigationLink(
                            destination: Menu(selectedCuisine: viewModel.cuisines[index].cuisine_name)
                        ) {
                            CuisineCardView(cuisine: viewModel.cuisines[index])
                                .transition(.asymmetric(
                                    insertion: .move(edge: showPreviousCard ? .leading : .trailing),
                                    removal: .move(edge: showPreviousCard ? .trailing : .leading)))
                                .gesture(
                                    DragGesture()
                                        .onEnded { value in
                                            let threshold: CGFloat = 100
                                            withAnimation(.snappy) {
                                                if value.translation.width < -threshold {
                                                    showPreviousCard = false
                                                    currentIndex = (currentIndex + 1) % max(viewModel.cuisines.count, 1)
                                                } else if value.translation.width > threshold {
                                                    showPreviousCard = true
                                                    currentIndex = (currentIndex - 1 + viewModel.cuisines.count) % max(viewModel.cuisines.count, 1)
                                                }
                                            }
                                        }
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .onAppear {
                viewModel.fetchCuisinesIfNeeded()
            }
            
        }
    }
}

#Preview {
    CuisineCard().environmentObject(LanguageManager())
        .environmentObject(CartViewModel())
}
