//
//  TimerSelectView.swift
//  LevisSleepyTime
//
//  Created by Winnie Jao on 6/18/23.
//

import SwiftUI

struct TimerSelectView: View {
    @EnvironmentObject var audioManager: AudioManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Spacer()
            
            Group{
                Text("Sleep timer")
                    .font(.system(size: 25, weight: .bold))
                
                Button {
                    setTimer(chap: 1)
                } label: {
                    Text("End of chapter")
                }
                
                Button {
                    setTimer(chap: 2)
                } label: {
                    Text("2 chapters")
                }
                
                Button {
                    setTimer(chap: 3)
                } label: {
                    Text("3 chapters")
                }
                
                Button {
                    setTimer(chap: 5)
                } label: {
                    Text("5 chapters")
                }
                
                Button {
                    setTimer(chap: 8)
                } label: {
                    Text("8 chapters")
                }
                
                Button {
                    setTimer(chap: 10)
                } label: {
                    Text("10 chapters")
                }
            }
            .foregroundStyle(.white)
            .padding()
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Text("Close")
                    .foregroundStyle(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.black.opacity(0.8)
                .background(BackgroundCleanerView())
                .ignoresSafeArea()
        )
    }
    
    func setTimer(chap: Int) {
        audioManager.setTimer(chap: chap)
        dismiss()
    }
}

struct BackgroundCleanerView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct TimerSelectView_Previews: PreviewProvider {
    static var previews: some View {
        TimerSelectView()
            .environmentObject(AudioManager())
    }
}
