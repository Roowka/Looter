import SwiftUI

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let description: String
    let imageColor: Color
    @Binding var currentPage: Int
    let isLastPage: Bool
    @Binding var isOnboardingDone: Bool

    var body: some View {
        VStack(spacing: 20) {
            VStack{
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(imageColor)
                    .padding()
                
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .padding(.vertical, 75)

            Button(action: {
                if isLastPage {
                    isOnboardingDone = true
                } else {
                    currentPage += 1
                }
            }) {
                Text(isLastPage ? "Commencer" : "Suivant")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding()
            }
        }
    }
}

#Preview {
    OnboardingPageView(
        imageName: "backpack.circle.fill",
        title: "Gérer ses loots",
        description: "Ajoutez facilement vos trouvailles et vos achats à votre collection personnelle.",
        imageColor: Color.purple,
        currentPage: .constant(0),
        isLastPage: false,
        isOnboardingDone: .constant(false)
    )
}
