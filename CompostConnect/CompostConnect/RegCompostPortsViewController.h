//
//  RegCompostPortsViewController.h
//  CompostConnect
//
//  Created by Honeywell International Inc on 1/21/16.
//  Copyright © 2016 Honeywell International Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegCompostPortsViewController : UIViewController{
    
    __weak IBOutlet UISwitch *isActive;
    __weak IBOutlet UITextField *description;
    __weak IBOutlet UITextField *sensorName;
}

@end
