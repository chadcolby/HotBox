//
//  BMWHomeViewController.m
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "BMWHomeViewController.h"
#import "BMWLoginViewController.h"



@interface BMWHomeViewController ()

@property (strong, nonatomic) BMWMenuControllerViewController *menu;
@property (strong, nonatomic) UITableViewController *tableViewController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BMWHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpEventsDataSource];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryFinished:) name:@"refreshComplete" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedWithNoEvents:) name:@"noEvents" object:nil];
    self.backgroundView.image = [UIImage imageNamed:@"background2.png"];    
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self createRefreshControl];
    self.menu = (BMWMenuControllerViewController *) [self parentViewController];
    [self.menu setMenubarTitle:@"Home"];
    self.menu.titleLabel.textColor = [UIColor colorWithRed:243/255.f green:195/255.f blue:47/255.f alpha:1.0f];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)setUpEventsDataSource
{
    self.tableViewController = [[UITableViewController alloc] init];
    
    self.tableView.delegate = self;
    self.eventsDataSource = [EventsDataSource sharedDataSource];
    self.eventsDataSource.tableView = self.tableView;
    self.tableView.dataSource = self.eventsDataSource;
    
    self.tableViewController.tableView = self.tableView;
    [self addChildViewController:self.tableViewController];
}

#pragma mark - Update TableView Methods
- (void)createRefreshControl
{
    self.tableViewController.refreshControl = [UIRefreshControl new];
    [self.tableViewController.refreshControl addTarget:self action:@selector(updateEventsTable) forControlEvents:UIControlEventValueChanged];
}

- (void)updateEventsTable
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshRequested" object:self];
}

- (void)finishedWithNoEvents:(NSNotification *)notification
{
    [self.tableViewController.refreshControl endRefreshing];
    UIAlertView *noEventsAlert = [[UIAlertView alloc] initWithTitle:@"No New Events" message:@"" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [noEventsAlert show];
}

- (void)queryFinished:(NSNotification *)notification
{
    [self.tableViewController.refreshControl endRefreshing];
    [self.tableViewController.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.eventsDataSource.self.queryArray count] == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.userInteractionEnabled = NO;

    } else {
        PFObject *event = [self.eventsDataSource.self.queryArray objectAtIndex:indexPath.row];
        NSString *detailsString = [[NSString alloc] initWithString:[event objectForKey:@"detailsKey"]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Details" message:detailsString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
    }
}
@end
