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

@end

@implementation BMWMenuControllerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    


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

- (void)dropDownMenuConfig
{
    [self.menuButton setTitle:nil forState:UIControlStateNormal];
    [self.menuButton setImage:[IonIcons imageWithIcon:icon_navicon size:30.0f color:[UIColor blueColor]] forState:UIControlStateNormal];
    [self setMenubarBackground:[UIColor lightGrayColor]];
    
    for (UIButton *button in self.buttons) {

        if ([button.titleLabel.text isEqualToString:@"Home"]) {
            button.backgroundColor = [UIColor whiteColor];
            [IonIcons labelWithIcon:icon_navicon_round size:15.0f color:[UIColor blueColor]];
            [button setImage:[IonIcons imageWithIcon:icon_person size:20.0f color:[UIColor blueColor]] forState:UIControlStateNormal];
        } else if ([button.titleLabel.text isEqualToString:@"Inbox"]) {
            button.backgroundColor = [UIColor whiteColor];
            [IonIcons labelWithIcon:icon_home size:15.0f color:[UIColor blueColor]];
            [button setImage:[IonIcons imageWithIcon:icon_ios7_email size:20.0f color:[UIColor blueColor]] forState:UIControlStateNormal];
        } else if ([button.titleLabel.text isEqualToString:@"Friends"]) {
            button.backgroundColor = [UIColor whiteColor];
            [IonIcons labelWithIcon:icon_information size:15.0f color:[UIColor blueColor]];
            [button setImage:[IonIcons imageWithIcon:icon_ios7_people size:20.0f color:[UIColor blueColor]] forState:UIControlStateNormal];
        }
        
        [button sizeToFit];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.frame.size.width - 10, 0, button.imageView.frame.size.width);
        button.imageEdgeInsets =UIEdgeInsetsMake(0, button.titleLabel.frame.size.width, 0, -button.titleLabel.frame.size.width);
        
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
}
@end
