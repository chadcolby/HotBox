//
//  BMWLoginViewController.m
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "BMWLoginViewController.h"
#import "BMWMenuControllerViewController.h"
#import "BMWHomeViewController.h"
#import <Parse/Parse.h>

@interface BMWLoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;


@end

@implementation BMWLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpview];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)setUpview
{
    self.username = [NSString new];
    self.password = [NSString new];
    
    self.backgroundView.image = [UIImage imageNamed:@"background2.png"];
    self.usernameField.alpha = 0.5f;
    self.passwordField.alpha = 0.5f;
    self.passwordField.delegate = self;
    self.usernameField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    } else
        if (textField == self.passwordField) {
            [self.passwordField resignFirstResponder];
        }
    
    return YES;
}

- (IBAction)signInPressed:(id)sender {
    self.username = [self.usernameField.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.password = [self.passwordField.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([self.username length] == 0 || [self.password length] == 0 ) {
        [self showLoginError];
    } else {
        [self tryLogin];
        [self.passwordField resignFirstResponder];
    }
    
    
}

- (void)tryLogin
{
    [PFUser logInWithUsernameInBackground:self.username password:self.password block:^(PFUser *user, NSError *error) {
        if (error) {
            [self showLoginError];
        } else {

        }
    }];
}

#pragma mark - Alert Views

- (void)showLoginError
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something Went Wrong." message: nil delegate:self cancelButtonTitle:@"Try again." otherButtonTitles: nil];
    
    [alert show];
}

@end
