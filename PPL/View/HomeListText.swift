//
//  HomeListText.swift
//  PPL
//
//  Created by Chandler Mathews on 6/2/21.
//

import SwiftUI

struct HomeListText: View {
        var listIndex : Int
        let repList: String =
            """
            3 x 10\n
            3 x 10\n
            3 x 10\n
            3 x 10\n
            3 x 10\n
            """
        var liftTextDict : [Int : String] = [
            0 : """
            Bench Press:\n
            Incline Press:\n
            Shoulder Press:\n
            Tricep Extensions:\n
            Tricep Pulldown:\n
            """,
            1 : """
            Pull Ups:\n
            Barbell Row:\n
            Dumbbell Fly:\n
            Bicep Curl:\n
            Hammer Curl:\n
            """,
            2 : """
            Squat:\n
            Deadlift:\n
            Leg Press:\n
            Hamstring curl:\n
            Quad Extensions:\n
            """
        ]
        
        var body: some View {
            HStack {
                Text(liftTextDict[listIndex]!)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    //.multilineTextAlignment(.trailing)
                    .font(.system(size: 28))
                Spacer()
                Text(repList)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.system(size: 28))
            }
            .padding(.horizontal, 20)
        }
}

struct HomeListText_Previews: PreviewProvider {
    static var previews: some View {
        HomeListText(listIndex: 0)
    }
}
