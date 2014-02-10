//
//  BMWHomeViewController.m
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "BMWHomeViewController.h"


@interface BMWHomeViewController ()

@end

@implementation BMWHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.backgroundView.image = [UIImage imageNamed:@"background2.png"];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self checkCurrentUser];

    
    BMWMenuControllerViewController* menu = (BMWMenuControllerViewController *) [self parentViewController];
    [menu setMenubarTitle:@"Home"];
    menu.titleLabel.textColor = [UIColor colorWithRed:243/255.f green:195/255.f blue:47/255.f alpha:1.0f];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)checkCurrentUser
{
    self.currentUser = [PFUser currentUser];
    if (self.currentUser) {
        NSLog(@"Current User: %@", self.currentUser.username);
    } else {
        [self performSegueWithIdentifier:@"noUserLoggedIn" sender:self];
    }
}
@end
