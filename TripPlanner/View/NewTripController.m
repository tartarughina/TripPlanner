//
//  NewTripController.m
//  TripPlanner
//
//  Created by Riccardo Strina on 15/07/21.
//

#import "NewTripController.h"
#import "PlannedTripsController.h"
#import <UserNotifications/UserNotifications.h>

@interface NewTripController ()

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *desc;
@property (weak, nonatomic) IBOutlet UIDatePicker *beginDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDate;
@property (nonatomic) BOOL notification;

-(void) setNotificationOnDate:(NSDate*) date;
-(void) askNotificationPermForDate:(NSDate*) date;

@end

@implementation NewTripController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _notification = NO;
    
    _beginDate.minimumDate = [NSDate date];
    _endDate.minimumDate = [NSDate date];
    
    if(_trip != nil){
        _name.text = _trip.name;
        _desc.text = _trip.desc;
        _beginDate.date = _trip.begin;
        _endDate.date = _trip.end;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

- (IBAction)navItemClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveClick:(id)sender {
    
    if(![_name.text isEqual:@""] && ![_desc.text isEqual:@""]){
        if(_trip == nil)
            [_trips addTrip:[[Trip alloc] initWithName: _name.text description: _desc.text begin:_beginDate.date end:_endDate.date]];
        else
            [_trips replaceTrip:_trip withTrip:[[Trip alloc] initWithName: _name.text description: _desc.text begin:_beginDate.date end:_endDate.date]];
        
        if(_notification == YES)
            [self setNotificationOnDate: _beginDate.date];
        else
            [self askNotificationPermForDate: _beginDate.date];
        
        [self dismissViewControllerAnimated:YES completion:^{
            [self->_parentView.tableView reloadData];
        }];
    }
    else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Attention"
                                                                       message:@"Name and description text fields must be filled before creation"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }

}

-(void) askNotificationPermForDate:(NSDate *)date{
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if(error == nil){
            self->_notification = granted;
            [self setNotificationOnDate:date];
        }
    }];
}

-(void) setNotificationOnDate:(NSDate *)date{
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    
    content.title = @"Less than a day before your trip!";
    
    content.body = [NSString stringWithFormat:@"Prepare your things, %@ it's going to start in 24 hours", _name.text];
    
    content.sound = [UNNotificationSound defaultSound];
    
    NSDate* trigger_date = [NSDate dateWithTimeIntervalSince1970:[_beginDate.date timeIntervalSince1970] - 3600*24];
    
    if([trigger_date compare:[NSDate date]] == NSOrderedDescending){
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:[trigger_date timeIntervalSinceNow] repeats:NO];
    
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:_name.text content:content      trigger:trigger];
    
        [center addNotificationRequest:request withCompletionHandler:nil];
    }
}

- (IBAction)beginDateChanged:(id)sender {
    _endDate.minimumDate = _beginDate.date;
}
- (IBAction)endDateChanged:(id)sender {
    _beginDate.maximumDate = _endDate.date;
}

@end
