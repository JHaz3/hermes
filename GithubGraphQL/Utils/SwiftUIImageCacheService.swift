//
//  SwiftUIImageCacheService.swift
//  GithubGraphQL
//
//  Created by Santiago Carmona on 28/02/22.
//  Copyright © 2022 test. All rights reserved.
//

import Combine
import URLImage
import URLImageStore
import SwiftUI

struct ImageCacheService {
  fileprivate let urlImageService = URLImageService(
    fileStore: URLImageFileStore(),
    inMemoryStore: URLImageInMemoryStore()
  )
  private var cancellable: AnyCancellable?

  mutating func download(urls: [String]) {
    let publishers: [URLImageService.RemoteImagePublisher] = urls.map {
      let url = URL(string: $0)!
      return urlImageService.remoteImagePublisher(url, identifier: nil)
    }

    cancellable = Publishers.MergeMany(publishers)
      .tryMap { $0.cgImage }
      .catch { _ in
        Just(nil)
      }
      .collect()
      .sink { _ in
      }

  }
}

struct ImageInMemoryStore: ViewModifier {
  let imageService: ImageCacheService

  func body(content: Content) -> some View {
    content
      .environment(\.urlImageService, imageService.urlImageService)
  }
}

extension View {
  func inMemoryImagesStored(cache: ImageCacheService) -> some View {
    modifier(ImageInMemoryStore(imageService: cache))
  }
}
