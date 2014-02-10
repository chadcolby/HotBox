//
//  BMWNewUserSignInViewController.m
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "BMWNewUserSignInViewController.h"
#import "BMWMenuControllerViewController.h"
#import <Parse/Parse.h>

@interface BMWNewUserSignInViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *email;
- (IBAction)cancelPressed:(id)sender;


@end

@implementation BMWNewUserSignInViewController

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
    self.email = [NSString new];
    
    self.backgroundView.image = [UIImage imageNamed:@"background2.png"];
    self.usernameField.alpha = 0.5f;
    self.passwordField.alpha = 0.5f;
    self.passwordField.delegate = self;
    self.usernameField.delegate = self;
    self.emailField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    } else
        if (textField == self.passwordField) {
            [self.emailField becomeFirstResponder];
        } else
            if (textField == self.emailField) {
                [self.emailField resignFirstResponder];
            }
    return YES;
}

- (IBAction)signUpPressed:(id)sender {
    self.username = [self.usernameField.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.password = [self.passwordField.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.email = [self.emailField.text stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([self.username length] == 0 || [self.password length] == 0 || [self.email length] == 0) {
        [self showMissingInfoAlert];
    } else {
        [self createNewUser];
    }
}

- (IBAction)cancelPressed:(id)sender
{
    
}

#pragma mark - Parse Methods

- (void)createNewUser
{
    PFUser *newUser = [PFUser new];
    newUser.username = self.username;
    newUser.password = self.password;
    newUser.email = self.email;
    
    NSLog(@"Name: %@, pass: %@, email: %@", self.username, self.password, self.email);
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            [self showCreateNewAllert:error];
        } else {

        }
    }];
}

#pragma mark - Alert Views

- (void)showCreateNewAllert:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something Went Wrong." message:[error.userInfo objectForKey:@"error"] delegate:self cancelButtonTitle:@"Okay." otherButtonTitles: nil];
    
    [alert show];
}

- (void)showMissingInfoAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something went wrong:" message:@"Please try again." delegate:self cancelButtonTitle:@"Okay." otherButtonTitles: nil];
    
    [alert show];
}


@end