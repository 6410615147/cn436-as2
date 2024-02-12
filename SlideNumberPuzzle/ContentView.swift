//
//  ContentView.swift
//  SlideNumberPuzzle
//
//  Created by นางสาวสุภาพันธ์ หง่อสกุล on 10/2/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = NumberViewModel()
    
    let spacing = 4 as CGFloat
    let aspectRatio = 1 as CGFloat
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Move: \(viewModel.count)")
                
                AspectVGrid(items: viewModel.blocks, aspectRatio: aspectRatio) {
                    block in BlockView(block)
                        .padding(spacing)
                        .onTapGesture {
                            viewModel.choose(block)
                        }
                        .animation(.default, value: viewModel.blocks)
                }
                Spacer()
                Button("Shuffle"){
                    withAnimation {
                        viewModel.shuffle()
                    }
                    
                }
                .foregroundColor(.yellow)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .tint(.white)
                .padding(30)
            }.padding([.top, .leading, .trailing], 50)
        }
    }
}

struct BlockView: View{
    var block: SlideNumberModel<String>.Block
    init(_ block: SlideNumberModel<String>.Block) {
        self.block = block
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 10)
            Group {
                if !block.isSpace {
                    base.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    base.stroke(lineWidth: 2)
                    Text(block.content)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
