//
//  MiniPlayerView.swift
//  LevisSleepyTime
//
//  Created by Winnie Jao on 6/4/23.
//

import SwiftUI

struct MiniPlayerView: View {
    var body: some View {
        /*ZStack{
            HStack{
                Text("Book name")
                    .foregroundStyle(.white)
                    .background(
                        Rectangle()
                            .foregroundColor(.gray)
                            .frame(width: UIScreen.main.bounds.size.width, height: 100)
                    )
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    
            }*/
        HStack{
            Text("Book Name")
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Spacer()
            PlaybackControlButton(systemName: "play.fill", fontSize: 30) {
                // action
            }
            .padding()
        }
        .background(
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.size.width, height: 130)
        )
        .frame(maxHeight: .infinity, alignment: .bottom)
            /*Group {
                Rectangle()
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.size.width, height: 70)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()*/
    }
}

struct MiniPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MiniPlayerView()
    }
}
