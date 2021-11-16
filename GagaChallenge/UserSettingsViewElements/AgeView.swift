import SwiftUI

struct AgeView: View {

    var sizeOfRROfDescription: CGSize
    @Binding var age: String
    @State var ageIsEditing: Bool = false

    var body: some View {
        HStack {
            Text("Select age")
                .padding(.leading)
            Spacer()
            RoundedRectangle(cornerRadius: 10)
                .frame(width: sizeOfRROfDescription.width*0.7, height: sizeOfRROfDescription.height/4)
                .foregroundColor(Color(.systemGroupedBackground))
                .padding(.trailing)
                .overlay(alignment: .center) {
                    HStack {
                        TextField("Age", text: $age) { isEditing in
                            self.ageIsEditing = isEditing
                        }
                        .multilineTextAlignment(.center)
                        Spacer()
                        if self.ageIsEditing && age != "" {
                            Button {
                                age = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .padding(.trailing)
                                    .foregroundColor(Color(.init(gray: 0, alpha: 0.2)))
                            }
                        }
                    }
                }
        }
    }
}
