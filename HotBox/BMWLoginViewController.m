//
//  BMWLoginViewController.m
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "BMWLoginViewController.h"

#import "BMWMenuControllerViewController.h"
#import "DropdownMenuSegue.h"
#import "BMWHomeViewController.h"
#import "BMWNewUserSignInViewController.h"
#import "BMWHomeViewController.h"
#import "BMWAppDelegate.h"
#import <Parse/Parse.h>

@interface BMWLoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (strong, nonatomic) BMWNewUserSignInViewController *addAccountViewController;

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) BMWMenuControllerViewController *menu;

@end

@implementation BMWLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [PFUser logOut];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newUserSuccessfullyCreate:) name:@"newAccountCreated" object:nil];
    
    if (![PFUser currentUser]) {
        self.menu.menuButton.enabled = NO;
    }
    
    [self setUpview];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![PFUser currentUser]) {

    } else {

        
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.menu = (BMWMenuControllerViewController *) [self parentViewController];
    [self.menu setMenubarTitle:@"Sign In"];
    self.menu.titleLabel.textColor = [UIColor colorWithRed:243/255.f green:195/255.f blue:47/255.f alpha:1.0f];
     
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
        [self.usernameField becomeFirstResponder];
    } else {
        
            [self willMoveToParentViewController:nil];
            [self.view removeFromSuperview];
    }
    
    
}



- (IBAction)createNewAccountPressed:(id)sender {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];

    [UIView animateWithDuration:0.1 animations:^{
        [self createNewViewController];
    } completion:^(BOOL finished) {
        self.view.alpha = 1.0;
    }];

}

- (void)createNewViewController
{
    self.addAccountViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newAccountVC"];
    self.menu.titleLabel.text = @"Sign Up";
    [self addChildViewController:self.addAccountViewController];
    self.addAccountViewController.view.frame = self.view.frame;
    [self.view addSubview:self.addAccountViewController.view];
    [self.addAccountViewController didMoveToParentViewController:self];
}

#pragma mark - Parse

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

- (void)newUserSuccessfullyCreate:(NSNotification *)notification
{
    [self willMoveToParentViewController:self];
    [self.view removeFromSuperview];
}


@end
