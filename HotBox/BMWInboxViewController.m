//
//  BMWInboxViewController.m
//  HotBox
//
//  Created by Chad D Colby on 2/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "BMWInboxViewController.h"
#import <Parse/Parse.h>
#import "IonIcons.h"

#define TITLE_KEY @"eventTitle"
#define ON_DAY_KEY @"onDay"
#define DETAILS_KEY @"detailsKey"
#define PF_CLASS_NAME @"newEvents"

@interface BMWInboxViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backView;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *onDayField;
@property (weak, nonatomic) IBOutlet UITextView *detailsView;
@property (strong, nonatomic) PFObject *freshEvent;
@property (strong, nonatomic) NSMutableArray *arrayOfEvents;
@property (strong, nonatomic) UIColor *darkTextColor;

- (IBAction)finishPressed:(id)sender;


@property (strong, nonatomic) NSString *titleString;
@property (strong, nonatomic) NSString *onDayString;
@property (strong, nonatomic) NSString *detailsString;
@property (weak, nonatomic) IBOutlet UIButton *createEventButton;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@end

@implementation BMWInboxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialSetUp];
    self.backView.image = [UIImage imageNamed:@"background2.png"];

    self.darkTextColor = [UIColor colorWithRed:45/255.f green:45/255.f blue:61/255.f alpha:1.0f];
    [self.finishButton setTitleColor:self.darkTextColor forState:UIControlStateNormal];
    [self.finishButton setImage:[IonIcons imageWithIcon:icon_ios7_checkmark size:30.0f color:self.self.darkTextColor] forState:UIControlStateNormal];
    [self.createEventButton setTitleColor:self.darkTextColor forState:UIControlStateNormal];
    [self.createEventButton setImage:[IonIcons imageWithIcon:icon_ios7_upload size:35.0f color:self.self.darkTextColor] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    BMWMenuControllerViewController* menu = (BMWMenuControllerViewController *) [self parentViewController];
    [menu setMenubarTitle:@"New Event"];
    menu.titleLabel.textColor = [UIColor colorWithRed:243/255.f green:195/255.f blue:47/255.f alpha:1.0f];
    NSLog(@"Start: %@", self.arrayOfEvents);

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.titleField) {
        [self.onDayField becomeFirstResponder];
    } else {
        [self.detailsView becomeFirstResponder];
    }
    

    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.detailsView.text = @"";

}


- (void)initialSetUp
{
    self.titleField.delegate = self;
    self.onDayField.delegate = self;
    self.detailsView.delegate = self;
    
    self.titleField.alpha = 0.5f;
    self.onDayField.alpha = 0.5;
    self.detailsView.alpha = 0.5;
    
    self.titleString = [[NSString alloc] init];
    self.onDayString = [[NSString alloc] init];
    self.detailsString = [[NSString alloc] init];

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

#pragma mark - IBAction

- (IBAction)finishPressed:(id)sender {
    self.titleString = self.titleField.text;
    self.onDayString = self.onDayField.text;
    self.detailsString = self.detailsView.text;
    
    [self.detailsView resignFirstResponder];
    [self.titleField resignFirstResponder];
    [self.onDayField resignFirstResponder];
}

- (IBAction)createEventPressed:(id)sender {
    UIActionSheet *optionsSheet = [[UIActionSheet alloc] initWithTitle:@"You can..." delegate:self cancelButtonTitle:@"Canel" destructiveButtonTitle:nil otherButtonTitles:@"Add another", @"Finish", nil];
    
    [optionsSheet showInView:self.view];
    
    // Create new PFObject for entered event
    self.freshEvent = [PFObject objectWithClassName:@"newEvent"];
    [self.freshEvent setObject:self.titleString forKey:TITLE_KEY];
    [self.freshEvent setObject:self.onDayString forKey:ON_DAY_KEY];
    [self.freshEvent setObject:self.detailsString forKey:DETAILS_KEY];
    
    NSLog(@"Event: %@", self.freshEvent);
    
    if (!self.arrayOfEvents) {
        self.arrayOfEvents = [[NSMutableArray alloc] init];
    }

}

#pragma mark - Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([self.titleField.text length] == 0 || [self.onDayField.text length] == 0 || [self.detailsView.text length] == 0) {
        [self emptryFieldsAlert];
    } else {
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Add another"]) {
        
        [self.arrayOfEvents addObject:self.freshEvent]; // Update array containing events
        
        self.titleField.text = @"";
        self.onDayField.text = @"";
        self.detailsView.text = @"Add Details";
        
        [self.titleField becomeFirstResponder];
        
        NSLog(@"Add another %lu", (unsigned long)self.arrayOfEvents.count);
        
    }
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Finish"]) {
        
        [self.arrayOfEvents addObject:self.freshEvent];
        
        PFObject *packagedEvents = [PFObject objectWithClassName:PF_CLASS_NAME];
        packagedEvents[@"eventsArray"] = self.arrayOfEvents; //Package array of added events into single PFObject
        [packagedEvents saveInBackground];
        
        NSLog(@"results: %@", self.arrayOfEvents);
        
        NSLog(@"Finish.");
        
        }
    }
}

- (void)emptryFieldsAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hold Up!" message:@"All fields required." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
}


@end
