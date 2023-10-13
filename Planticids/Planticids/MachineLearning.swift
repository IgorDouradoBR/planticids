//
//  ContentView.swift
//  Teste
//
//  Created by Igor Dourado  on 10/10/23.
//

import SwiftUI
import Photos
import Lottie

struct LottieView: UIViewRepresentable {
    
    var name = "success"
    var loopMode: LottieLoopMode = .playOnce
    

    func makeUIView(context: Context) -> LottieAnimationView {
        let view = LottieAnimationView(name: name, bundle: Bundle.main)
        view.loopMode = loopMode
        view.contentMode = .scaleAspectFit
        
        view.play()
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}


struct TesteSwiftUI: View {
    
    @State var imageResults = ImageResults(results: [])
    @State var plantImage = UIImage()
//    @State var plantImageView: UIImageView!
//    @State var photoSelectBtn: UIBarButtonItem!
    @State private var isShowingAlert = false
    @State private var isCameraPresented = false
    @Environment(\.presentationMode) var presentationMode
    @State private var isGalleryPickerPresented = false
    @State var isSheetPresented = false

    
    func getImageResults(imageURL:URL){
        ImageRecognitionServices.instance.getImageRecognitionResults(image: imageURL) { res in
            switch res{
            case .success(let data):
                self.imageResults = data
            case .failure(_):
                print("falhou")
            }
            
        }
    }
    
    
        func getImageResults(imageData:Data){
            ImageRecognitionServices.instance.getImageRecognitionResults(image: imageData) { res in
                switch res{
                case .success(let data):
                    self.imageResults = data

                case .failure(_):
                    print("falhou a 2")
                }
                
            }
    }
    
    func saveImage(image: UIImage){
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = "takenPhoto-\(Date()).png"
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            guard let data = image.jpegData(compressionQuality: 1) else { return }

           
            if FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    try FileManager.default.removeItem(atPath: fileURL.path)
                    print("Removed old image")
                } catch let removeError {
                    print("couldn't remove file at path", removeError)
                }

            }

            do {
                try data.write(to: fileURL)
                getImageResults(imageURL: fileURL)
            } catch let error {
                print("error saving file with error", error)
            }
    }
    
    func openCamera() {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                isCameraPresented.toggle()
            } else {
                // Handle the case where the camera is not available on the device
            }
        }

        func openGallery() {
            isGalleryPickerPresented.toggle()
        }

    
    
    var body: some View {
        
        VStack {
            Text("The Planticids 🪴🎸\n").font(.title3)
            Button(action: {
                isShowingAlert.toggle()
            }) {
                Text("Identificar espécie")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(
                    title: Text("Escolha como"),
                    message: Text("Selecione a forma de obter a imagem para identificar"),
                    primaryButton: .default(Text("Camera"), action: {
                        openCamera()
                    }),
                    secondaryButton: .default(Text("Gallery"), action: {
                        openGallery()
                    })
                    
                )
            }.onAppear{
                //saveImage(image: UIImage(named: "carn")!)
            }
            
                    
        }
        .padding()
        .sheet(isPresented: $isCameraPresented) {
            ImagePicker(sourceType: .camera, selectedImage: $plantImage, auxParent: self)
                }
        .sheet(isPresented: $isGalleryPickerPresented) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $plantImage, auxParent: self)
               }
        .sheet(isPresented: $isSheetPresented){
            VStack{
                if imageResults.results.count >= 1 {

                    PlantRowView(image: plantImage, scientificName: imageResults.results[0].species.scientificName, scientificNameAuthorship: imageResults.results[0].species.scientificNameAuthorship, score: imageResults.results[0].score)
                        
                }else{
                    LottieView(name: "loading", loopMode: .loop)
                        .scaleEffect(0.38)
                        //.frame(height: UIScreen.main.bounds.height * 0.23)
                }
                
            }
        }
    }
    

    
    struct PlantRowView: View {
        let image: UIImage?
        @State var scientificName : String
        @State var scientificNameAuthorship : String

        @State var score : Double
        
        var body: some View {
            HStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 120, height: 120)
                }
                VStack(alignment: .leading) {
                    Text("\(scientificName)")
                        .font(.headline)
                    Text("\(scientificNameAuthorship)")
                        .font(.subheadline)
                    Text("Acurácia: \(String(format: "%.1f%%", score * 100))")
                        .font(.subheadline)
                }
            }
        }
    }
    
}


struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage
    var auxParent : TesteSwiftUI

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update here
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
                if let image = info[.originalImage] as? UIImage {
                    parent.selectedImage = image
                    parent.auxParent.isSheetPresented.toggle()
                    parent.auxParent.imageResults = ImageResults(results: [])
                    parent.auxParent.saveImage(image: image)
                }
                picker.dismiss(animated: true)
            }
    }
}
