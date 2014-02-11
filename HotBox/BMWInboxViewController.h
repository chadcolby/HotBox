//
//  BMWInboxViewController.h
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMWMenuControllerViewController.h"

@interface BMWInboxViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate>

- (IBAction)createEventPressed:(id)sender;

@end
