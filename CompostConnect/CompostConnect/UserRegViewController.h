//
//  UserRegViewController.h
//  CompostConnect
//
//  Created by Honeywell International Inc on 1/21/16.
//  Copyright © 2016 Honeywell International Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserRegViewController : UIViewController{
    
    __weak IBOutlet UITextField *firstName;
    
    __weak IBOutlet UITextField *lastName;
    
    __weak IBOutlet UITextField *email;
    
    __weak IBOutlet UITextField *contactNo;
    
    __weak IBOutlet UITextField *userType;
    
    
    __weak IBOutlet UITextField *password;
    
}
- (IBAction)gotoLogin:(id)sender;
@end
