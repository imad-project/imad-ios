//
//  MovieListView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/28/24.
//

import SwiftUI

public struct ListView<RefreshBinding, Data, ItemView: View>: View {
    
    @Binding var binding: RefreshBinding
    let items: [Data]
    @ViewBuilder var viewMapping: (Data) -> ItemView
    
    
      public init(
                  binding: Binding<RefreshBinding>,
                  items: [Data],
                  @ViewBuilder viewMapping: @escaping (Data) -> ItemView) {
    
        _binding = binding
        self.items = items
        self.viewMapping = viewMapping
    
      }
    
    public var body: some View {
        ForEach(Array(items.enumerated()), id: \.offset) { index, item in
            viewMapping(item)
        }
    }
}

public extension ListView where RefreshBinding == Never? {
    init(
        items: [Data],
        @ViewBuilder viewMapping: @escaping (Data) -> ItemView) {
            self.init(
                binding: .constant(nil),
                items: items,
                viewMapping: viewMapping)
        }
}


#Preview {
    ListView(items:["dsasd","sadasd"]){ a in
        Text(a)
    }
}
