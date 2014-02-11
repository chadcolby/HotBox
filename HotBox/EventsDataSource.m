//
//  EventsDataSource.m
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "EventsDataSource.h"
#import <Parse/Parse.h>

@implementation EventsDataSource

- (id)init
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryLatestEvents:) name:@"refreshRequested" object:nil];

    self.darkColor = [UIColor colorWithRed:45/255.f green:45/255.f blue:61/255.f alpha:1.0f];
    self.lighColor = [UIColor colorWithRed:243/255.f green:195/255.f blue:47/255.f alpha:1.0f];
    self.tableView.backgroundColor = self.darkColor;
    
    self.isEvents = YES;
    
    return self;
}

+ (EventsDataSource *)sharedDataSource
{
    static dispatch_once_t pred;
    static EventsDataSource *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[EventsDataSource alloc] init];
    });
    
    return shared;
}



#pragma mark - Parse query
/*
 This method is called by table view when it recieves the notification from 'pull to refresh'
 */
- (void)queryLatestEvents:(NSNotification *)notification
{
    NSLog(@"LOGGED: %@", [notification name]);
    self.queryArray = [NSMutableArray new];
    
    PFQuery *queryNewestEvents = [PFQuery queryWithClassName:@"newEvent"];
    queryNewestEvents.limit = 6;
    [queryNewestEvents findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!objects) {
            NSLog(@"Error");
        } else {
            NSLog(@"count:%d", objects.count);
            self.queryArray = (NSMutableArray *)objects;
        }
        if (self.queryArray.count == 0) {
            NSLog(@"No events to update.");

            [[NSNotificationCenter defaultCenter] postNotificationName:@"noEvents" object:self];
        } else {
        
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshComplete" object:self];
            
        }
    }];
    
}

#pragma mark - Table view Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Upcoming Events";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.queryArray count] == 0) {
        return 1;
    } else {
        return [self.queryArray count];
        NSLog(@"More info: %d", self.queryArray.count);
    }
    //return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
        if (self.queryArray.count == 0) {
        
            cell.textLabel.text = @"Pull Down To Refresh";
            cell.detailTextLabel.text = @"";
        
        } else {
        
            PFObject *event = [self.queryArray objectAtIndex:indexPath.row];
            cell.textLabel.text = [event objectForKey:@"eventTitle"];
            cell.detailTextLabel.text = [event objectForKey:@"onDay"];
            cell.textLabel.textColor = self.darkColor;
            cell.detailTextLabel.textColor = self.lighColor;
        }

    return cell;
}

@end
