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
    
    [PFUser logOut];
    
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

#pragma mark - IBActions

- (IBAction)signInPressed:(id)sender {
    self.username = [self.usernameField.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.password = [self.passwordField.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([self.username length] == 0 || [self.password length] == 0 ) {
        [self emptyFieldsError];

        
    } else {
        [self tryLogin];
        [self.passwordField resignFirstResponder];

    }
    
    
}

- (IBAction)createNewAccountPressed:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)tryLogin
{
    [PFUser logInWithUsernameInBackground:self.username password:self.password block:^(PFUser *user, NSError *error) {
        if (error) {
            [self showLoginError:error];
        } else {

        }
    }];
}

#pragma mark - Alert Views

- (void)showLoginError:(NSError *)error;
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something Went Wrong." message: [error.userInfo objectForKey:@"error"] delegate:self cancelButtonTitle:@"Try again." otherButtonTitles: nil];
    
    [alert show];
}

- (void)emptyFieldsError
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something Went Wrong." message:@"Please Fill in Both Fields" delegate:self cancelButtonTitle:@"Try again." otherButtonTitles: nil];
    
    [alert show];
}
@end
