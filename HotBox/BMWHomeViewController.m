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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    BMWMenuControllerViewController* menu = (BMWMenuControllerViewController *) [self parentViewController];
    [menu setMenubarTitle:@"Home"];
    menu.titleLabel.textColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
