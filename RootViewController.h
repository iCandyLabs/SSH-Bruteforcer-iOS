//
//  RootViewController.h
//  SSH Brute
//
//  Created by Sam Sheffres on 06/07/15.
//  Copyright (c) 2015 Sam Sheffres. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *targetTextField;
@property (nonatomic, weak) IBOutlet UIButton *goButton;

- (IBAction)startAttack:(id)sender;

@end
