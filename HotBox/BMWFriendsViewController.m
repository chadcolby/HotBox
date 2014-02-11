//
//  BMWFriendsViewController.m
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "BMWFriendsViewController.h"


@interface BMWFriendsViewController ()

@property (nonatomic, strong) UIColor *displayColor;

@property (nonatomic, strong) NSOperationQueue *getFriendsQueue;

@end

@implementation BMWFriendsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.displayColor = [UIColor colorWithRed:45/255.f green:45/255.f blue:61/255.f alpha:1.0f];
    self.getFriendsQueue = [[NSOperationQueue alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView:) name:@"downloadFinished" object:nil];
    
    if (!self.friendsArray) {
        NSLog(@"error");
        [self createRefreshControl];
        NSLog(@"???%@", self.friendsArray);
    }

}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    BMWMenuControllerViewController* menu = (BMWMenuControllerViewController *) [self parentViewController];
    [menu setMenubarTitle:@"Friends"];
    menu.titleLabel.textColor = [UIColor colorWithRed:243/255.f green:195/255.f blue:47/255.f alpha:1.0f];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)createRefreshControl
{
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshRequested) forControlEvents:UIControlEventValueChanged];
}

- (void)refreshRequested
{
    PFQuery *friendsQuerey = [PFUser query];
    [self.getFriendsQueue addOperationWithBlock:^{
        self.friendsArray = [NSArray arrayWithArray:[friendsQuerey findObjects]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"downloadFinished" object:self];
    }];
}

- (void)updateTableView:(NSNotification *)notification
{
    NSLog(@"%@", notification.name);
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

- (void)useFriendsArray:(NSNotification *)notification
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friendsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"friendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *downloadedFriend = [self.friendsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [downloadedFriend objectForKey:@"username"];
    cell.textLabel.textColor = self.displayColor;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
