//
//  SearchBar.swift
//  GithubGraphQL
//
//  Created by Santiago Carmona on 28/02/22.
//  Copyright © 2022 test. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
  var placeHolder: String
  @Binding var text: String
  var onSubmit: (() -> Void)
  @State private var isEditing = false
  
  var body: some View {
    HStack {
      TextField(placeHolder, text: $text, onCommit: onSubmit)
        .padding(7)
        .padding(.horizontal, 25)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal, 10)
        .onTapGesture {
          self.isEditing = true
        }
        .accessibilityIdentifier("RepositorySearchText")
    }
    .overlay(
      HStack {
        Image(systemName: "magnifyingglass")
          .foregroundColor(.gray)
          .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 16)
        
        if isEditing {
          Button(action: {
            self.text = ""
          }) {
            Image(systemName: "multiply.circle.fill")
              .foregroundColor(.gray)
              .padding(.trailing, 16)
          }
        }
      }
    )
  }
}
