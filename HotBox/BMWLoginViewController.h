//
//  BMWLoginViewController.h
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMWLoginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


- (IBAction)signInPressed:(id)sender;
- (IBAction)createNewAccountPressed:(id)sender;

@end
