//
//  ViewController.swift
//  AR Dicee
//
//  Created by serena on 7/16/19.
//  Copyright © 2019 Serena Cheng. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Set the view's delegate
        sceneView.delegate = self
        
//        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
//
//        let material = SCNMaterial()
//        material.diffuse.contents = UIColor.red
//
//        cube.materials = [material]
//
//        let node = SCNNode()
//
//        node.position = SCNVector3(0, 0.1, -0.5)
//
//        node.geometry = cube
//
//        sceneView.scene.rootNode.addChildNode(node)
        
        sceneView.autoenablesDefaultLighting = true
        
//        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
//
//        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
//
//            diceNode.position = SCNVector3(0, 0, -0.1)
//
//            sceneView.scene.rootNode.addChildNode(diceNode)
//
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if anchor is ARPlaneAnchor {
            
            let planeAnchor = anchor as! ARPlaneAnchor
            
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            
            let planeNode = SCNNode()
            
            planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
            
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            
            plane.materials = [gridMaterial]
            
            planeNode.geometry = plane
            
            node.addChildNode(planeNode)
            
        }
        else {
            return
        }
        
    }
    
}
