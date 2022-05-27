//
//  DisclaimerView.swift
//  GithubGraphQL
//
//  Created by Santiago Carmona on 28/02/22.
//  Copyright © 2022 test. All rights reserved.
//

import SwiftUI

struct Disclaimer {
  let title: String
  let subtitle: String?
}

struct DisclaimerView: View {
  let disclaimer: Disclaimer

  var body: some View {
    VStack(spacing: 16) {
      Text(disclaimer.title)
        .font(.title2)
        .foregroundColor(Color.gray)
        .frame(maxWidth: .infinity, alignment: .center)
        .multilineTextAlignment(.center)
      if let subtitle = disclaimer.subtitle {
        Text(subtitle)
          .font(.title3)
          .frame(maxWidth: .infinity, alignment: .center)
          .foregroundColor(Color.gray.opacity(0.6))
          .multilineTextAlignment(.center)
      }
      Spacer()
    }
  }
}
