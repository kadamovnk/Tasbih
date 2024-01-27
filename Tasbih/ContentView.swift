//
//  ContentView.swift
//  Tasbih
//
//  Created by Nodirbek Kadamov on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    var backgroundColor: Color = Color("customColor")
    @State var count: CGFloat = 0
    @State var name0 = "Start"
    @State var name1 = "Subhanallah"
    @State var name2 = "Alhamdulillah"
    @State var name3 = "AllahuAkbar"
    @State var name4 = "Finished"
    @State var totalCount = 0
    @State var itIsThirdyThree = false
    @State var itIsSixtySix = false
    @State var itIsNintyNine = false
    
    var body: some View {
        VStack(spacing: 50) {
            
            Text("Tasbih")
                .font(.title)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .fontWeight(.semibold)
                .shadow(radius: 10)
            
            VStack {
                Text("\(Int(count))/99")
                    .font(.title)
                
                if count > 0 && count <= 33 {
                    Text(name1)
                } else if count > 33 && count <= 66 {
                    Text(name2)
                } else if count > 66 && count < 99 {
                    Text(name3)
                } else if count == 99 {
                    Text(name4)
                } else {
                    Text(name0)
                }
            }
            .padding(50)
            .overlay (
                ZStack {
                    Circle()
                        .stroke(
                            Color.black.opacity(colorScheme == .dark ? 0.5 : 0.3),
                            lineWidth: 30
                        )
                    Circle()
                        .trim(from: 0, to: (count+0.1)/100)
                        .stroke(
                            Color.black,
                            style: StrokeStyle(
                                lineWidth: 30,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(.degrees(-90))
                        .animation(.easeOut, value: CGFloat((count+1)/100))
                }
            )
            
            Button(action: {
                countButton()
            }, label: {
                Text("Count\n \(Int(count))")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(colorScheme == .dark ? .white : backgroundColor)
                    .frame(width: 200, height: 200)
                    .background(Color.black)
                    .cornerRadius(50)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            })
                .sensoryFeedback(.success, trigger: itIsThirdyThree)
                .sensoryFeedback(.success, trigger: itIsSixtySix)
                .sensoryFeedback(.success, trigger: itIsNintyNine)
            
            Button(action: {
                resetFeedback()
            }, label: {
                Text("Reset")
                    .font(.headline)
                    .foregroundStyle(colorScheme == .dark ? .white : backgroundColor)
                    .frame(width: 100, height: 50)
                    .background(Color.black)
                    .cornerRadius(20)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            })
            
            Text("Total: \(totalCount)")
                .monospaced()
                .shadow(radius: 10)
            Text("Last: \(formatDate())")
                .monospaced()
                .shadow(radius: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor.ignoresSafeArea())
    }
    
    func formatDate() -> String {
        let format = DateFormatter()
        format.dateFormat = "MMM dd, yyyy, h:mm a"
        return format.string(from: Date())
        
    }
    
    func resetFeedback() {
        count = 0
        itIsThirdyThree = false
        itIsSixtySix = false
        itIsNintyNine = false
    }
    
    func countButton() {
        count += 1
        totalCount += 1
        if count == 33 {
            itIsThirdyThree = true
        } else if count == 66 {
            itIsSixtySix = true
        } else if count == 99 {
            itIsNintyNine = true
        }
        if count > 99 {
            resetFeedback()
        }
    }
}

#Preview {
    ContentView()
}
