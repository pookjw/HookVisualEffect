//
//  ViewController.swift
//  HookVisualEffect
//
//  Created by pookjw on 8/17/22.
//

import UIKit

class ViewController: UIViewController {
    private let imageView: UIImageView = .init(image: UIImage(named: "image"))
    
    private let firstBlurView: UIVisualEffectView = .init(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    private let firstVibrancyView: UIVisualEffectView = .init(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: .dark), style: .fill))
    private var firstSlider: UISlider!
    private let firstLabel: UILabel = .init()
    
    private let secondBlurView: UIVisualEffectView = .init(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    private let secondVibrancyView: UIVisualEffectView = .init(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: .dark), style: .fill))
    private let secondLabel: UILabel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        //
        
        view.addSubview(firstBlurView)
        firstBlurView.intensity = 7
        firstBlurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstBlurView.topAnchor.constraint(equalTo: view.topAnchor),
            firstBlurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstBlurView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        firstBlurView.contentView.addSubview(firstVibrancyView)
        firstVibrancyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstVibrancyView.topAnchor.constraint(equalTo: firstBlurView.contentView.topAnchor),
            firstVibrancyView.leadingAnchor.constraint(equalTo: firstBlurView.contentView.leadingAnchor),
            firstVibrancyView.trailingAnchor.constraint(equalTo: firstBlurView.contentView.trailingAnchor),
            firstVibrancyView.bottomAnchor.constraint(equalTo: firstBlurView.contentView.bottomAnchor)
        ])
        
        firstSlider = .init()
        firstSlider.addTarget(self, action: #selector(sliderDidChange(_:)), for: .valueChanged)
        firstSlider.minimumValue = .zero
        firstSlider.maximumValue = 50
        firstSlider.value = Float(firstBlurView.intensity)
        firstVibrancyView.contentView.addSubview(firstSlider)
        firstSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstSlider.leadingAnchor.constraint(equalTo: firstVibrancyView.contentView.safeAreaLayoutGuide.leadingAnchor),
            firstSlider.trailingAnchor.constraint(equalTo: firstVibrancyView.contentView.safeAreaLayoutGuide.trailingAnchor),
            firstSlider.topAnchor.constraint(equalTo: firstVibrancyView.contentView.safeAreaLayoutGuide.topAnchor)
        ])
        
        firstLabel.text = "intensity = \(firstBlurView.intensity)"
        firstLabel.font = .preferredFont(forTextStyle: .largeTitle)
        firstLabel.numberOfLines = 0;
        firstLabel.textAlignment = .center
        firstVibrancyView.contentView.addSubview(firstLabel)
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstLabel.centerYAnchor.constraint(equalTo: firstVibrancyView.contentView.centerYAnchor),
            firstLabel.leadingAnchor.constraint(equalTo: firstVibrancyView.contentView.safeAreaLayoutGuide.leadingAnchor),
            firstLabel.trailingAnchor.constraint(equalTo: firstVibrancyView.contentView.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        //
        
        
        view.addSubview(secondBlurView)
        secondBlurView.layer.opacity = 1.0
        secondBlurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondBlurView.topAnchor.constraint(equalTo: firstBlurView.bottomAnchor),
            secondBlurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondBlurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondBlurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            secondBlurView.heightAnchor.constraint(equalTo: firstBlurView.heightAnchor)
        ])
        
        secondBlurView.contentView.addSubview(secondVibrancyView)
        secondVibrancyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondVibrancyView.topAnchor.constraint(equalTo: secondBlurView.contentView.topAnchor),
            secondVibrancyView.leadingAnchor.constraint(equalTo: secondBlurView.contentView.leadingAnchor),
            secondVibrancyView.trailingAnchor.constraint(equalTo: secondBlurView.contentView.trailingAnchor),
            secondVibrancyView.bottomAnchor.constraint(equalTo: secondBlurView.contentView.bottomAnchor)
        ])
        
        secondLabel.text = "(Default) intensity = \(secondBlurView.intensity)"
        secondLabel.font = .preferredFont(forTextStyle: .largeTitle)
        secondLabel.numberOfLines = 0
        secondLabel.textAlignment = .center
        secondVibrancyView.contentView.addSubview(secondLabel)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondLabel.centerYAnchor.constraint(equalTo: secondVibrancyView.contentView.centerYAnchor),
            secondLabel.leadingAnchor.constraint(equalTo: secondVibrancyView.contentView.leadingAnchor),
            secondLabel.trailingAnchor.constraint(equalTo: secondVibrancyView.contentView.trailingAnchor)
        ])
    }

    @objc private func sliderDidChange(_ sender: UISlider) {
        self.firstBlurView.intensity = CGFloat(sender.value)
        //            self.firstVibrancyView.intensity = CGFloat(slider.value)
        self.firstLabel.text = "intensity = \(self.firstBlurView.intensity)"
    }
}

