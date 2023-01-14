//
//  LocalFileManager.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 14.01.2023.
//

import SwiftUI

class LocalFileManager {
   static let instance = LocalFileManager()

    private init() { }
    // MARK: - Private
    // return folder path
    private func getFolderPath(for folderName: String) -> URL? {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(path: folderName)
    }

    // create folder if it doesn't exist
    private func createFolderIfNeeded(for folderName: String) {
        guard let url = getFolderPath(for: folderName) else { return }

        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                print("Created folder")
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    // this is for creating a file in the folder
    private func getItemPath(for key: String, fileExtension: String, imageName: String) -> URL? {
        guard let folder = getFolderPath(for: key) else { return nil }
        return folder.appending(path: imageName + fileExtension)
    }
    // MARK: - Public
    // add image to file manager
    func add(image: UIImage, for key: String, fileExtension: String, imageName: String) {
        guard
            let data = image.pngData(),
            let url = getItemPath(for: key, fileExtension: fileExtension, imageName: imageName) else { return }

         createFolderIfNeeded(for: key)

        do {
           try data.write(to: url)
        } catch let error {
            print("Error saving to file manager. \(error.localizedDescription)")
        }
    }

    // get image from File Manager
     func getImage(for key: String, imageName: String, fileExtension: String) -> UIImage? {
        guard
            let url = getItemPath(for: key, fileExtension: fileExtension, imageName: imageName),
            FileManager.default.fileExists(atPath: url.path()) else { return nil }

        return UIImage(contentsOfFile: url.path())
    }

    func removeItem(for key: String, fileExtension: String, imageName: String) {
        guard
            let url = getItemPath(for: key, fileExtension: fileExtension, imageName: imageName),
            FileManager.default.fileExists(atPath: url.path()) else { return }

        do {
            try FileManager.default.removeItem(at: url)
        } catch let error {
            print("Error in removing item. Error: \(error)")
        }
    }
}
