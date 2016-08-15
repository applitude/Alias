//
//  SpillViewController.swift
//  heads-up
//
//  Created by Espen Næss on 14.08.2016.
//  Copyright © 2016 Espen Næss. All rights reserved.
//

import UIKit

class SpillViewController : UIViewController {
    var gestures:[UISwipeGestureRecognizer] = [];
    var spill:Spill!;
    
    @IBOutlet weak var tidslabel: UILabel!
    @IBOutlet weak var tilbakeknapp: UIButton!
    @IBOutlet weak var label:UILabel!
    
    @IBAction func tilbake(sender: UIButton) {
        self.performSegueWithIdentifier("tilHovedmeny", sender: self);
    }
    
    override func viewDidLoad() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(SpillViewController.responderTilSwipe(_:)));
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down;
        self.view.addGestureRecognizer(swipeDown);
        
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(SpillViewController.responderTilSwipe(_:)));
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up;
        self.view.addGestureRecognizer(swipeUp);
        
        gestures = [swipeDown, swipeUp];
        spill = Spill(visning: self);
        tilbakeknapp.hidden = true;
        tidslabel.hidden = false;
        spill.startSpill();
    }
    
    func responderTilSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Down:
                spill.addPoeng();
                lastNeste();
            case UISwipeGestureRecognizerDirection.Up:
                lastNeste();
            default:
                break;
            }
        }
    }
    
    func avsluttSpill() {
        for gesture in gestures {
            self.view.removeGestureRecognizer(gesture);
        }
        visScore();
        spill.spillAvsluttningslyd();
        spill.stoppNedtelling();
        tidslabel.hidden = true;
        tilbakeknapp.hidden = false;
    }
    
    func lastNeste() {
        spill.indeks = arc4random_uniform(UInt32(spill.gjetteArr.count));
        
        if (spill.gjetteArr.count == 0) {
            avsluttSpill();
            return;
        }
        label.text = spill.gjetteArr[Int(spill.indeks)];
        spill.gjetteArr.removeAtIndex(Int(spill.indeks));
    }
    
    func oppdaterTidIgjen(tid:Int) {
        tidslabel.text = "Tid: "+String(tid);
    }
    
    func visScore() {
        label.text = "Poeng: "+String(spill.poeng);
    }
}