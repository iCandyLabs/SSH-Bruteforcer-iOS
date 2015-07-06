//
//  DetailViewController.h
//  SSH Brute
//
//  Created by Sam Sheffres on 06/07/15.
//  Copyright (c) 2015 Sam Sheffres. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

