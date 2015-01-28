//
//  ViewController.h
//  License
//
//  Created by Amir Farsad on 1/28/15.
//  Copyright (c) 2015 Amyr Farsad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    IBOutlet UILabel *UDID;
    IBOutlet UILabel *activationStatus;
    IBOutlet UIButton *active;
}
-(IBAction)refreshStatus:(id)sender;
-(IBAction)activeMyApp:(id)sender;
-(IBAction)help:(id)sender;
@end

