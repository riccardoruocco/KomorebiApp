//
//  GifViewer.swift
//  Komorebi
//
//  Created by Luigi Parente on 23/11/21.
//

import SwiftUI
import WebKit

struct GifViewer: UIViewRepresentable {
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
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        // webView.scrollView.isScrollEnabled = false

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }

}


struct GifViewer_Previews: PreviewProvider {
    static var previews: some View {
        GifViewer("meditationloader")
    }
}
