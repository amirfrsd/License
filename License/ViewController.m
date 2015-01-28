//
//  ViewController.m
//  License
//
//  Created by Amir Farsad on 1/28/15.
//  Copyright (c) 2015 Amyr Farsad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
-(IBAction)refreshStatus:(id)sender{
    [self load];
    
}
-(IBAction)help:(id)sender{
    UIAlertView *activeMsg = [[UIAlertView alloc] initWithTitle:@"راهنما"
                                                        message:@"همراه سورس کد فایل JSON برای شما آماده می باشد، برای استفاده UDID دستگاه خود را در فایل JSON قرار دهید و با آپلود فایل روی سرور شخصی و عوض کردن آدرس فایل JSON در سورس کد برنامه شما امکان استفاده از برنامه را خواهید داشت! این برنامه هنوز کامل نیست. بزودی CMS ای با زبان PHP و پشتیبانی از درگاه های مختلف برای برنامه های شما منتشر خواهد شد به طوری که کاربر نرم افزار شما با مراجعه به سایتی که CMS در آن نصب شده لایسنس را تهیه می نماید و از داخل برنامه آن را فعال می سازد."
                                                       delegate:nil
                                              cancelButtonTitle:@"بستن"
                                              otherButtonTitles:nil];
    [activeMsg show];

}

-(void)load{
    
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL:
                        [NSURL URLWithString:@"http://khodkaar.ir/license/activation.json"]];
    NSError *error;
    NSMutableDictionary *jsonDatas = [NSJSONSerialization
                                      JSONObjectWithData:jsonData
                                      options:NSJSONReadingMutableContainers
                                      error:&error];
    
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }
    else {
        NSArray *status = jsonDatas[@"activation"];
        for ( NSDictionary *jsonData in status )
        {
            NSString *udid = [[[UIDevice currentDevice]identifierForVendor]UUIDString];
            BOOL containsudid = [jsonData[@"UDID"] containsObject:udid];
            if (containsudid == YES) {
                NSLog(@"Device is Registered");
                activationStatus.text = @"فعال";
                activationStatus.textColor = [UIColor greenColor];
            //    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isRegistered"];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setBool:YES forKey:@"isRegistered"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                NSLog(@"isRegistered is now set to = YES");
                                      active.hidden = NO;
                                      active.enabled = YES;

            }
            else {
                NSLog(@"Device is not Registered!");
                activationStatus.text = @"غیر فعال";
                activationStatus.textColor = [UIColor redColor];
                UIAlertView *activeMsg = [[UIAlertView alloc] initWithTitle:@"فعال سازی"
                                                                  message:@"نرم افزار برای شما فعال نشده است! برای فعال سازی به آدرس\nkhodkaar.ir/license/\n مراجعه نمایید.\nبا تشکر"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"بستن"
                                                       otherButtonTitles:nil];
                          [activeMsg show];

               //[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isRegistered"];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setBool:NO forKey:@"isRegistered"];
                [[NSUserDefaults standardUserDefaults] synchronize];

                NSLog(@"isRegistered is now set to = NO");
            }
        }
    }
    
}
-(IBAction)activeMyApp:(id)sender{
    UINavigationController *settingsNC = [self.storyboard instantiateViewControllerWithIdentifier:@"registeredPage"];
    [self presentViewController:settingsNC animated:YES completion:NULL];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] objectForKey:@"isRegistered"];
    NSString *udid = [[[UIDevice currentDevice]identifierForVendor]UUIDString];
    UDID.text = udid;
    active.hidden = YES;
    active.enabled = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
