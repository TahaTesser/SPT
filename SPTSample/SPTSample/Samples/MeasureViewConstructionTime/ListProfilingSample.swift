//
//  ListProfilingSample.swift
//  SPTSample
//

import SwiftUI
import SPT

/// Demonstrates profiling list and collection views
struct ListProfilingSample: View {
    @State private var items = (1...50).map { Item(id: $0, title: "Item \($0)") }
    @State private var isGrid = false
    
    var body: some View {
        VStack {
            Toggle("Grid Layout", isOn: $isGrid)
                .padding(.horizontal)
            
            if isGrid {
                GridView(items: items)
                    .sptProfile("GridView")
            } else {
                ListView(items: items)
                    .sptProfile("ListView")
            }
        }
        .sptProfile("ListProfilingSample")
        .navigationTitle("List Profiling")
        .toolbar {
            Button("Shuffle") {
                items.shuffle()
            }
        }
    }
}

private struct Item: Identifiable {
    let id: Int
    let title: String
}

private struct ListView: View {
    let items: [Item]
    
    var body: some View {
        List(items) { item in
            ItemRow(item: item)
        }
    }
}

private struct GridView: View {
    let items: [Item]
    
    private let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(items) { item in
                    ItemCell(item: item)
                }
            }
            .padding()
        }
    }
}

private struct ItemRow: View {
    let item: Item
    
    var body: some View {
        HStack {
            Circle()
                .fill(.blue)
                .frame(width: 40, height: 40)
                .overlay {
                    Text("\(item.id)")
                        .foregroundStyle(.white)
                        .font(.caption)
                }
            Text(item.title)
            Spacer()
        }
    }
}

private struct ItemCell: View {
    let item: Item
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.blue.opacity(0.2))
                .frame(height: 60)
                .overlay {
                    Text("\(item.id)")
                        .font(.title2)
                }
            Text(item.title)
                .font(.caption)
        }
    }
}

#Preview {
    NavigationStack {
        ListProfilingSample()
    }
}
