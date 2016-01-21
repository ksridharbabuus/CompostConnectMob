//
//  PortsListViewController.h
//  CompostConnect
//
//  Created by Honeywell International Inc on 1/21/16.
//  Copyright © 2016 Honeywell International Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PortsListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    __weak IBOutlet UITableView *compostPortsTableView;
}


- (IBAction)gotoRegCompostPorts:(id)sender;
- (IBAction)gotoLogin:(id)sender;
@end
