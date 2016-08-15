//
//  Spill.swift
//  heads-up
//
//  Created by Espen Næss on 14.08.2016.
//  Copyright © 2016 Espen Næss. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Spill : NSObject {
    var gjetteArr = ["Ku", "Programmerer", "Fødsel", "Twerking", "Esel", "Sel", "Ape", "Spise en banan", "Okse", "Kråke", "Krabbe", "Fisk", "Måne", "Hårklipping", "Fisking", "Full", "Struts", "Hund", "Katt", "Pølse", "Stol", "Gaming", "Helikopter", "Lapdance", "Kutte løk", "Elefant", "Kenguru", "Gris", "Frosk", "Asiater", "Julenissen", "Student", "Trehogger", "Sjåfør", "Pedofil", "Terrorist", "Donald Trump", "Mat", "Krydderbørse", "Dildo", "Bonde", "Nettbrett", "Løpe", "Askebeger", "Toalett", "Flerkoneri", "Sadomachocist", "Hitler", "Ku Klux Klan", "Viagra", "Veps", "Sigarettenner", "Hårvoksing", "Pinoccio", "Pokémon", "Pacman", "Fotball", "Svømming", "Pizza", "Danse", "Blekksprut"];
    
    var poeng = 0;
    var indeks:UInt32 = 0;
    var nedteller = NSTimer();
    var nedtellertid = 60;
    var tidFoerStart = 3;
    var view:SpillViewController!;
    var lydSpiller = AVAudioPlayer();
    
    init(visning: SpillViewController) {
        view = visning;
    }
    
    func startSpill() {
        poeng = 0;
        
        print(gjetteArr.count);
        nedteller = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(Spill.oppdater), userInfo: nil, repeats: true);
    }
    
    func oppdater() {
        if (tidFoerStart > 0) {
            view.label.text = String(tidFoerStart);
            let beep = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("beep", ofType: "mp3")!);
            lydSpiller = try! AVAudioPlayer(contentsOfURL: beep);
            lydSpiller.play();
            tidFoerStart -= 1;
        } else if (tidFoerStart == 0) {
            tidFoerStart -= 1;
            view.lastNeste();
        } else {
            if (nedtellertid == 15) {
                let lyd = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tick_tock", ofType: "wav")!);
                lydSpiller = try! AVAudioPlayer(contentsOfURL: lyd);
                lydSpiller.play();
                lydSpiller.numberOfLoops = -1;
            }
            
            view.oppdaterTidIgjen(nedtellertid);
            
            if (nedtellertid > 0) {
                nedtellertid -= 1;
            } else {
                view.avsluttSpill();
            }
        }
        
    }
    
    func spillAvsluttningslyd() {
        let lyd = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("lufthorn", ofType: "mp3")!);
        
        lydSpiller = try! AVAudioPlayer(contentsOfURL: lyd)
        lydSpiller.numberOfLoops = 0;
        lydSpiller.play();
    }
    
    func addPoeng() {
        poeng += 1;
    }
    func stoppNedtelling() {
        nedteller.invalidate();
    }
}
