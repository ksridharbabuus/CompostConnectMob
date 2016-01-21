//
//  LoginViewController.h
//  CompostConnect
//
//  Created by Honeywell International Inc on 1/21/16.
//  Copyright © 2016 Honeywell International Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController{
    __weak IBOutlet UITextField *userName;
    __weak IBOutlet UITextField *password;
}

- (IBAction)singIn:(id)sender;

@end
