//
//  NearByPortsViewController.h
//  CompostConnect
//
//  Created by Honeywell International Inc on 1/21/16.
//  Copyright © 2016 Honeywell International Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface NearByPortsViewController : UIViewController{
    __weak IBOutlet MKMapView *nearByPortsMapView;
    
    __weak IBOutlet UITextField *CunsumerLocation;
    
}
- (IBAction)gotoLogin:(id)sender;
- (IBAction)getNearPorts:(id)sender;

@end
