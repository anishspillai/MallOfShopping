import SwiftUI

struct SignInView : View {
    
    @State private var showingAlert = false
    
    @State var isSignUp = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var email: String = "test@gmail.com"
    @State var password: String = "12345678"
    @State var loading = false
    @State var error = false
    @State var errorMessage: String = ""
    
    @EnvironmentObject var session: SessionStore
    
    func signIn () {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.errorMessage = error?.localizedDescription ?? "Something went wrong with the Sign In"
                self.error = true
                self.showingAlert = true
            } else {
                self.email = ""
                self.password = ""
                //self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func signUp () {
        loading = true
        error = false
        session.signUp(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.errorMessage = error?.localizedDescription ?? "Something went wrong with the Sign up"
                self.error = true
                self.showingAlert = true
            } else {
                print("Sign up succesful")
                self.email = ""
                self.password = ""
            }
        }
    }
    
    
    
    func clear () {
        self.errorMessage = ""
    }
    
    var body: some View {
        
        
        
        ZStack{
            Image("1").resizable()
            VStack {
                TextField("Enter a password", text: $email)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                SecureField("Enter a password", text: $password)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                Group {
                    if(!self.isSignUp) {
                        Button(action: signIn) {
                            Text("Sign in").frame(width: 80, height: 40).background(Color.purple).cornerRadius(20).foregroundColor(Color.white)
                        }
                    } else {
                        Button(action: signUp) {
                            Text("Sign up").frame(width: 80, height: 40).background(Color.purple).cornerRadius(20).foregroundColor(Color.white)
                        }
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error Message"), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}
