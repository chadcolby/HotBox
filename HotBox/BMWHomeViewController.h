//
//  BMWHomeViewController.h
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "BMWMenuControllerViewController.h"
#import "EventsDataSource.h"

@interface BMWHomeViewController : UIViewController <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (strong, nonatomic) EventsDataSource *eventsDataSource;



@end
