//
//  BMWMenuControllerViewController.m
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "BMWMenuControllerViewController.h"

#import "IonIcons.h"

@interface BMWMenuControllerViewController ()

@property (nonatomic, weak) BMWLoginViewController *loginVC;
@property (nonatomic, strong) PFUser *currentUser;
- (IBAction)logOutPressed:(id)sender;

@end

@implementation BMWMenuControllerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self colorSetUp];
    [self checkForCurrentUser];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self dropDownMenuConfig];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)colorSetUp
{
    self.darkColor = [UIColor colorWithRed:45/255.f green:45/255.f blue:61/255.f alpha:1.0f];
    self.lightColor = [UIColor colorWithRed:243/255.f green:195/255.f blue:47/255.f alpha:1.0f];
    self.mediumColor = [UIColor colorWithRed:204/255.f green:154/255.f blue:31/255.f alpha:1.0f];
    self.redishColor = [UIColor colorWithRed:205/255.f green:53/255.f blue:41/255.f alpha:0.89f];
    self.greenishColor = [UIColor colorWithRed:165/255.f green:129/255.f blue:92/255.f alpha:1.0f];
}

- (void)dropDownMenuConfig
{
    [self.menuButton setTitle:nil forState:UIControlStateNormal];
    [self.menuButton setImage:[IonIcons imageWithIcon:icon_navicon size:30.0f color:self.lightColor] forState:UIControlStateNormal];
    [self setMenubarBackground:self.darkColor];
    for (UIButton *button in self.buttons) {

        if ([button.titleLabel.text isEqualToString:@"Home"]) {
            button.backgroundColor = self.redishColor;
            //[IonIcons labelWithIcon:icon_navicon_round size:15.0f color:self.darkColor];
            [button setImage:[IonIcons imageWithIcon:icon_person size:20.0f color:self.darkColor] forState:UIControlStateNormal];
        } else if ([button.titleLabel.text isEqualToString:@"Inbox"]) {
            button.backgroundColor = self.redishColor;
            //[IonIcons labelWithIcon:icon_home size:15.0f color:self.darkColor];
            [button setImage:[IonIcons imageWithIcon:icon_ios7_email size:20.0f color:self.darkColor] forState:UIControlStateNormal];
        } else if ([button.titleLabel.text isEqualToString:@"Friends"]) {
            button.backgroundColor = self.redishColor;
            //[IonIcons labelWithIcon:icon_information size:15.0f color:self.darkColor];
            [button setImage:[IonIcons imageWithIcon:icon_ios7_people size:20.0f color:self.darkColor] forState:UIControlStateNormal];
        }   else if ([button.titleLabel.text isEqualToString:@"Log Out"]) {
            button.backgroundColor = self.redishColor;
            //[IonIcons labelWithIcon:icon_information size:15.0f color:self.darkColor];
            [button setImage:[IonIcons imageWithIcon:icon_ios7_close size:20.0f color:self.darkColor] forState:UIControlStateNormal];
        }
        
        [button sizeToFit];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.frame.size.width - 10, 0, button.imageView.frame.size.width);
        button.imageEdgeInsets =UIEdgeInsetsMake(0, button.titleLabel.frame.size.width, 0, -button.titleLabel.frame.size.width);
        
        [button setTitleColor:self.darkColor forState:UIControlStateNormal];

    }
}

- (void)createNewViewController
{
    self.loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"newLoginVC"];
    [self addChildViewController:self.loginVC];
    self.loginVC.view.frame = self.view.frame;
    [self.view addSubview:self.loginVC.view];
    [self.loginVC didMoveToParentViewController:self];
}

- (void)checkForCurrentUser
{
    self.currentUser = [PFUser currentUser];
    if (self.currentUser ) {
        NSLog(@"%@", self.currentUser.username);
    } else {
        [self createNewViewController];
        NSLog(@"no user");
    }
}

- (IBAction)logOutPressed:(id)sender
{
    [PFUser logOut];
    [self checkForCurrentUser];
}

@end
