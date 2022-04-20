//
//  GifImage.swift
//  Tamongus
//
//  Created by Hyeonsoo Kim on 2022/04/10.
//

import SwiftUI
import WebKit

struct GifImage2: UIViewRepresentable { //Essential methods are makeUIView and updateUIView.
    
    private let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        webView.scrollView.isScrollEnabled = false
        
        return webView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.reload()
    }
}

struct GifImage2_Previews: PreviewProvider {
    static var previews: some View {
        GifImage("logo-login-shadow")
    }
}
