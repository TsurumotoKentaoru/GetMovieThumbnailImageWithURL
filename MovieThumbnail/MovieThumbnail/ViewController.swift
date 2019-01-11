//
//  ViewController.swift
//  MovieThumbnail
//
//  Created by 鶴本賢太朗 on 2019/01/11.
//  Copyright © 2019 Kentarou. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let strUrl: String = "https://etc.dounokouno.com/testmovie/mpeg4/testmovie-480x272.mp4"
        let encoded = strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encoded!)
        let asset = AVURLAsset(url: url!)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        generator.requestedTimeToleranceAfter = kCMTimeZero
        generator.requestedTimeToleranceBefore = kCMTimeZero
        let time: NSValue = CMTime(seconds: 1, preferredTimescale: 1) as NSValue
        generator.generateCGImagesAsynchronously(forTimes: [time]) { (time, image, _, result, error) in
            if let error: Error = error {
                print(error.localizedDescription)
            }
            if let image: CGImage = image {
                DispatchQueue.main.async {
                    let thumbnail = UIImage(cgImage: image)
                    self.imageView.image = thumbnail
                }
            }
        }
    }
}

