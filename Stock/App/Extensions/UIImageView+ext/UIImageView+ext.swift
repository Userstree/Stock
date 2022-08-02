//
// Created by Dossymkhan Zhulamanov on 29.07.2022.
//

extension UIImageView {
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }

        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}