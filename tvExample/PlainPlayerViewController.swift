//
//  PlainPlayerViewController.swift
//  tvExample
//
//  Created by Kurniadi on 8/12/22.
//

import Foundation
import UIKit
import AVKit

class VideoPlayerViewController: UIViewController, AVPlayerViewControllerDelegate {
    
    // MARK: IB Actions
    
    @IBAction func playVideo(_ sender: AnyObject) {
        // Create an AVAsset with for the media's URL.
        let mediaURL = URL(string: "https://cdn.bitmovin.com/content/assets/sintel/hls/playlist.m3u8")!
        let asset = AVAsset(url: mediaURL)

        /*
            Create an `AVPlayerItem` for the `AVAsset` and populate it with information
            about the video.
        */
        let playerItem = AVPlayerItem(asset: asset)
        playerItem.externalMetadata = sampleExternalMetaData()
        
        // Create and present an `AVPlayerViewController`.
        let playerViewController = AVPlayerViewController()
        playerViewController.delegate = self
        
        let player = AVPlayer(playerItem: playerItem)
        playerViewController.player = player
        
        self.present(playerViewController, animated: true) {
            /*
                Begin playing the media as soon as the controller has
                been presented.
            */
            player.play()
        }
    }
    
    // MARK: Meta data
    
    func sampleExternalMetaData() -> [AVMetadataItem] {
        let titleItem = AVMutableMetadataItem()
        titleItem.identifier = AVMetadataIdentifier.commonIdentifierTitle
        titleItem.value = "Example Content" as NSString
        titleItem.extendedLanguageTag = "und"
        
        let imageItem = AVMutableMetadataItem()
        imageItem.identifier = AVMetadataIdentifier.commonIdentifierArtwork
        let image = UIImage(named: "AwTu6RFgWj8")!
        imageItem.value = image.pngData()! as NSData
        imageItem.dataType = kCMMetadataBaseDataType_PNG as String
        imageItem.extendedLanguageTag = "und"
        
        let descriptionItem = AVMutableMetadataItem()
        descriptionItem.identifier = AVMetadataIdentifier.commonIdentifierDescription
        descriptionItem.value = "Check out iPhone 6s and iPhone 6s Plus, learn about the powerful iPad Pro, take a look at the new features and bands for Apple Watch, and see the premiere of the all-new Apple TV." as NSString
        descriptionItem.extendedLanguageTag = "und"
        
        return [titleItem, descriptionItem, imageItem]
    }
}
