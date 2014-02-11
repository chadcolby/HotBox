//
//  EventsDataSource.h
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventsDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) __block NSMutableArray *queryArray;
@property (nonatomic, strong) UIColor *darkColor;
@property (nonatomic, strong) UIColor *lighColor;
@property (nonatomic) BOOL isEvents;

+ (EventsDataSource *)sharedDataSource;

@end
