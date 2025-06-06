import SwiftUI
import SafariServices

struct ReviewView: View {
    @Binding var isActive: Bool
    @State private var activeTab: NavBar.Tab = .reviews
    
    // MARK: - Article Model
    struct Article: Identifiable {
        let id = UUID()
        let title: String
        let imageURL: String
        let articleURL: String
        let description: String
    }
    
    // MARK: - Sample Articles
    let articles: [Article] = [
        Article(
            title: "Like Clogs, But Make it Barefoot Shoes",
            imageURL: "https://anyasreviews.com/wp-content/uploads/2024/04/barefoot-clogs-vs-birkenstocks.jpg",
            articleURL: "https://anyasreviews.com/like-clogs-but-make-it-barefoot-shoes/",
            description: "Discover the best barefoot clogs that combine style with foot health, featuring flexible soles and proper toe space."
        ),
        // Add more sample articles here
    ]
    
    var body: some View {
        ZStack {
            // Background
            Color.EEEBE3
                .ignoresSafeArea()
            
            // Main content
            VStack(spacing: 0) {
                headerView
                
                ScrollView {
                    VStack(spacing: 24) {
                        ForEach(articles) { article in
                            ArticleCardView(article: article)
                        }
                        .padding(.top, 16)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 140)
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Header View
    private var headerView: some View {
        ZStack {
            Color.white
                .frame(height: 84)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            
            HStack {
                Button(action: { isActive = false }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color.CA0013)
                }
                .padding(.leading, 24)
                
                Spacer()
                
                Text("REVIEWS")
                    .font(.custom("Bagel Fat One", size: 24))
                    .foregroundColor(Color.CA0013)
                    .kerning(-1)
                
                Spacer()
                
                Image(systemName: "bell")
                    .font(.system(size: 20))
                    .foregroundColor(Color.CA0013)
                    .padding(.trailing, 24)
            }
            .frame(height: 84)
        }
    }
}

// MARK: - ArticleCardView
private struct ArticleCardView: View {
    let article: ReviewView.Article
    @State private var showWebView = false
    
    var body: some View {
        Button(action: { showWebView = true }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.FCFBF9)
                    .frame(height: 200)
                    .shadow(color: Color.black.opacity(0.07), radius: 80, x: 0, y: 22)
                    .shadow(color: Color.black.opacity(0.0417), radius: 22.3363, x: 0, y: 6.6501)
                
                VStack(alignment: .leading, spacing: 12) {
                    // Article Image
                    AsyncImage(url: URL(string: article.imageURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(height: 120)
                    .clipped()
                    .cornerRadius(16)
                    
                    // Article Title and Description
                    VStack(alignment: .leading, spacing: 4) {
                        Text(article.title)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.CA0013)
                            .lineLimit(2)
                        
                        Text(article.description)
                            .font(.system(size: 12))
                            .foregroundColor(Color.textDark)
                            .lineLimit(2)
                    }
                    .padding(.horizontal, 12)
                }
                .padding(.vertical, 12)
            }
        }
        .sheet(isPresented: $showWebView) {
            WebView(url: URL(string: article.articleURL)!)
        }
    }
}

// MARK: - WebView
struct WebView: View {
    let url: URL
    
    var body: some View {
        SafariView(url: url)
    }
}

// MARK: - SafariView
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}

// MARK: - Preview
struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(isActive: .constant(true))
    }
} 