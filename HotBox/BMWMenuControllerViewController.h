//
//  BMWMenuControllerViewController.h
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "DropdownMenuController.h"
#import "BMWAppDelegate.h"
#import "BMWHomeViewController.h"
#import <Parse/Parse.h>

@interface BMWMenuControllerViewController : DropdownMenuController

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIColor *darkColor;
@property (nonatomic, strong) UIColor *lightColor;
@property (nonatomic, strong) UIColor *mediumColor;
@property (nonatomic, strong) UIColor *redishColor;
@property (nonatomic, strong) UIColor *greenishColor;

@property (weak, nonatomic) IBOutlet UIButton *logOut;


@end
