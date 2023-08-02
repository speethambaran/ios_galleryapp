//
//  ContentView.swift
//  Sample APP
//
//  Created by Shyam Boban on 02/08/23.
//

import SwiftUI

struct ContentView: View {
    @State var dataForListView: [[CultureData]] = [[CultureData(cultureString: "Music"), CultureData(cultureString: "Arts & crafts"), CultureData(cultureString: "Gaming"), CultureData(cultureString: "Princesses"), CultureData(cultureString: "Movie & TV Shows")], [CultureData(cultureString: "Animals"), CultureData(cultureString: "Flowers"), CultureData(cultureString: "Trees"), CultureData(cultureString: "Elements"), CultureData(cultureString: "Forest")]]
    @State var dataForListViewHeadings: [String] = ["CULTURE", "NATURE"]
    @State var colorArray: [Color] = [.blue, .green]
    @State var lockEnabledArray: [Bool] = [true, false]
    var body: some View {
        VStack {
            ScrollView(.vertical,showsIndicators: false){
                HeadingView()
                .padding(.top, 15)
           
                NewsHeadingBodyView()
                    .padding(.top, 10)
                TrendingHeader()
                    .padding(.top, 10)
                TrendingNowView()
                    .padding(.top, 10)
                VStack {
                    ForEach(0..<dataForListView.count, id: \.self) { i in
                        SubHeadingView(color: colorArray[i], heading: dataForListViewHeadings[i], isLockIconEnabled: lockEnabledArray[i])
                            .padding(.top, 10)
                        SubHeadingBodyView(dataForCulture: dataForListView[i], color: colorArray[i], imageHeading: dataForListViewHeadings[i])
                            .padding(.top, 10)
                    }
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HeadingView: View {
    var body: some View {
        HStack {
            Text("NEWS")
                .padding(.leading, 20)
                .font(.title2)
                .fontWeight(.medium)
            Spacer()
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
                .padding(.trailing,20)
                .font(.title2)
                .fontWeight(.medium)
        }
    }
}

struct NewsHeadingBodyView: View {
    var body: some View {
        HStack {
            ScrollView(.horizontal,showsIndicators: false){
                HStack {
                    TopVerticalMenuView()
                        .frame(width: 120, height: 120)
                        .padding(.leading, 2)
                }.padding(.leading, 15)
                    .padding(.trailing, 15)
            }
        }
    }
}

struct TopVerticalMenuView: View {
    let images = ["testImage1", "testImage2", "testImage3", "testImage4", "testImage5", "testImage6"]
    let imageText = ["Img 1", "Img 2", "Img 3", "Img 4", "Img 5", "Img 6"]
    var body: some View {
        ForEach(0..<imageText.count, id: \.self) { imageTxt in
            ZStack {
                Image(images[imageTxt])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(15)
                    .overlay(
                        Text(imageText[imageTxt])
                            .font(.title3)
                            .fontWeight(.medium)
                            .padding(.bottom, 8)
                            .padding(.leading, 10)
                            .foregroundColor(.white), alignment: .bottomLeading
                    )
            }
            .frame(width: 110, height: 110)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                .stroke(.blue, lineWidth: 2)
                .frame(width: 110, height: 110)
            )
        }
        
    }
}

struct TrendingHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .foregroundColor(.orange)
                .font(.title3)
                .fontWeight(.medium)
                .padding(.leading, 15)
            Text("TRENDING RIGHT NOW")
                .font(.title3)
                .fontWeight(.medium)
            Spacer()
        }
    }
}

struct TrendingNowView: View {
    var body: some View {
        Image("testImage4")
            .resizable()
            .cornerRadius(20)
            .frame(height: 300)
            .padding(.leading, 18)
            .padding(.trailing, 18)
            .overlay(
                HStack() {
                    Text("Around Wild World")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.leading, 45)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: { }) {
                        Text("See")
                            .padding()
                            .font(.title2)
                            .fontWeight(.medium)
                    }.foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(12)
                        .padding(.trailing, 35)
                    
                }
                    .padding(.bottom, 25), alignment: .bottom
            )
    }
}

struct SubHeadingView: View {
    @State var color: Color
    @State var heading: String
    @State var isLockIconEnabled: Bool
    var body: some View {
        HStack {
            Image(systemName: "diamond.fill")
                .foregroundColor(color)
                .padding(.leading, 15)
            Text(heading)
                .font(.title3)
                .fontWeight(.medium)
            if isLockIconEnabled {
                Image(systemName: "lock")
            } else {
                Image(systemName: "lock")
                    .hidden()
            }
            Spacer()
            Button("See more...") {
                
            }.padding(.trailing, 15)
                .foregroundColor(.gray)
        }
    }
}

struct SubHeadingBodyView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 300)),
        GridItem(.adaptive(minimum: 300)),
        GridItem(.adaptive(minimum: 300))
    ]
    
    @State var dataForCulture : [CultureData]
    @State var color: Color
    @State var imageHeading: String
    
    
    var body: some View {
        HStack {
            Image("testImage2")
                .resizable()
                .frame(width: 120, height: 120)
                .cornerRadius(12)
                .overlay(
                    Text(imageHeading)
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                        .padding(.bottom, 8)
                        .foregroundColor(.white), alignment: .bottomLeading
                )
                .padding(.leading, 15)
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
            Spacer()
        }.frame(height: 120)
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(dataForCulture) { platform in
                item(for: platform.cultureString)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if platform.cultureString == dataForCulture.last!.cultureString {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if platform.cultureString == dataForCulture.last!.cultureString {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }
    
    func item(for text: String) -> some View {
        Text(text)
            .padding(.all, 5)
            .font(.body)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .background(color)
            .foregroundColor(Color.white)
            .cornerRadius(5)
            .clipShape(Capsule())
    }
}

struct CultureData: Identifiable {
    var id = UUID().uuidString
    var cultureString: String
}



