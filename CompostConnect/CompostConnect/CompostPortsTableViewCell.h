//
//  CompostPortsTableViewCell.h
//  CompostConnect
//
//  Created by Honeywell International Inc on 1/21/16.
//  Copyright © 2016 Honeywell International Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompostPortsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *compostPortName;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end
