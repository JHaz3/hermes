//
//  SwiftUIImage.swift
//  GithubGraphQL
//
//  Created by Santiago Carmona on 28/02/22.
//  Copyright © 2022 test. All rights reserved.
//

import URLImage
import SwiftUI

struct SwiftUIImage<Content>: View where Content: View {
  private let url: URL?
  private let content: (Image) -> Content
  private let placeholder: String?
  init(_ url: String, placeholder: String? = "avatar", @ViewBuilder content: @escaping (Image) -> Content) {
    self.url = URL(string: url)
    self.content = content
    self.placeholder = placeholder
  }

  var body: some View {
    if let url = self.url {
      URLImage(url) { _ in
        ProgressView()
          .frame(width: 50, height: 50, alignment: .center)
      } content: { image, _ in
        self.content(image)
      }
    } else {
      content(Image(placeholder ?? ""))
    }
  }
}
