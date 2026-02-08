//
//  ContentView.swift
//  CustomTabView
//
//  Created by Куприянов Тимофей on 05.02.2026.
//

import SwiftUI

struct TabItemPreferenceKey: PreferenceKey {
    static var defaultValue: [TabItem] = []
    
    static func reduce(value: inout [TabItem], nextValue: () -> [TabItem]) {
        value += nextValue()
    }
}

struct TabItemModifier: ViewModifier {
    let tabBarItem: TabItem
    
    func body(content: Content) -> some View {
        content
            .preference(key: TabItemPreferenceKey.self, value: [tabBarItem])
    }
}

extension View {
    func myTabItem(_ label: () -> TabItem) -> some View {
        modifier(TabItemModifier(tabBarItem: label()))
    }
}


struct TabItem: Identifiable, Equatable {
    var id = UUID()
    var text: String
    var icon: String
}

struct CustomTabView<Content: View>: View {
    @Binding var selection: Int
    
    @Namespace private var TabBarItem
    
    @State private var tabItems: [TabItem] = []
    
    private var content: Content
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
            HStack {
                tabsView
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .padding(.vertical, 5)
            .background(Color.white)
            .ignoresSafeArea(edges: .bottom)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
        }
        .onPreferenceChange(TabItemPreferenceKey.self) { value in
            self.tabItems = value
        }
    }
    
    
    init(selection: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.content = content()
        _selection = selection
    }
    
    private var tabsView: some View {
        ForEach(Array(tabItems.enumerated()), id: \.offset) { index, element in
            Spacer()
            VStack(spacing: 5) {
                Image(systemName: "\(element.icon)")
                Text(element.text)
                    .font(.system(size: 10))
            }
            .foregroundStyle(selection == index ? .black : .gray)
            .background(
                ZStack {
                    if selection == index {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.yellow.opacity(0.4))
                            .frame(width: 70, height: 50)
                            .matchedGeometryEffect(id: "tabBarItem", in: TabBarItem)
                            
                    }
                }
            )
            
            .onTapGesture {
                withAnimation {
                    selection = index
                }
            }
            Spacer()
        }
    }
}

struct ContentView: View {
    @State var selection = 0
    var body: some View {
        CustomTabView(selection: $selection) {
            Color.red
                .ignoresSafeArea()
                .myTabItem {
                    TabItem(text: "Home", icon: "house.fill")
                }
                .opacity(selection == 0 ? 1 : 0)
            Color.blue
                .ignoresSafeArea()
                .myTabItem {
                    TabItem(text: "Profile", icon: "person.fill")
                }
                .opacity(selection == 1 ? 1 : 0)
            Color.green
                .ignoresSafeArea()
                .myTabItem {
                    TabItem(text: "Settings", icon: "gear")
                }
                .opacity(selection == 2 ? 1 : 0)
        }
    }
}

#Preview {
    ContentView()
}
