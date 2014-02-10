//
//  BMWHomeViewController.m
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "BMWHomeViewController.h"
#import "BMWLoginViewController.h"
#import "BMWCurrentUserContainerViewController.h"


@interface BMWHomeViewController ()

@property (strong, nonatomic)BMWLoginViewController *loginView;
@property (strong, nonatomic)BMWCurrentUserContainerViewController *userContainerView;


@end

@implementation BMWHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self checkCurrentUser];

    self.backgroundView.image = [UIImage imageNamed:@"background2.png"];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    


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
        [self goToContainerLogIn];
    }
}

- (void)newLoginSession
{
    self.loginView = [[BMWLoginViewController alloc] init];
    self.loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"newLoginVC"];
    [self addChildViewController:self.loginView];
    self.loginView.view.frame = self.view.frame;
    [self.view addSubview:self.loginView.view];
    [self.loginView didMoveToParentViewController:self];
    
}

- (void)goToContainerLogIn
{
    self.userContainerView = [[BMWCurrentUserContainerViewController alloc] init];
    self.userContainerView = [self.storyboard instantiateViewControllerWithIdentifier:@"loginContainerView"];
    [self addChildViewController:self.userContainerView];
    self.userContainerView.view.frame = self.view.frame;
    [self.view addSubview:self.userContainerView.view];
    [self.userContainerView didMoveToParentViewController:self];
    
}
@end
