//
//  RegSourceViewController.h
//  CompostConnect
//
//  Created by Honeywell International Inc on 1/21/16.
//  Copyright © 2016 Honeywell International Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegSourceViewController : UIViewController{
    
__weak IBOutlet UITextField *address;
__weak IBOutlet UITextField *contactName;
__weak IBOutlet UITextField *contactNum;
__weak IBOutlet UITextField *altContactNum1;
__weak IBOutlet UITextField *altContactNum2;
__weak IBOutlet UITextField *sourceType;
__weak IBOutlet UITextField *longitude;
__weak IBOutlet UITextField *latitude;

}


@end
