//
//  UIImageExtension.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 24/04/2025.
//

import UIKit
import CoreImage

extension UIImage {
    func isDark(threshold: Float = 0.6) -> Bool {
        guard let inputImage = CIImage(image: self) else { return false }

        // Create CIAreaAverage filter
        let extent = inputImage.extent
        let context = CIContext()
        let filter = CIFilter(name: "CIAreaAverage", parameters: [
            kCIInputImageKey: inputImage,
            kCIInputExtentKey: CIVector(cgRect: extent)
        ])!

        guard let outputImage = filter.outputImage else { return false }

        // Render to 1x1 pixel to get average color
        var bitmap = [UInt8](repeating: 0, count: 4)
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: CGColorSpaceCreateDeviceRGB())

        // Get brightness from average color
        let red = Float(bitmap[0]) / 255.0
        let green = Float(bitmap[1]) / 255.0
        let blue = Float(bitmap[2]) / 255.0
        let brightness = (0.3 * red + 0.59 * green + 0.11 * blue)
        let dark = brightness < threshold ? true : false
        return dark // true = dark, false = light
    }
}

