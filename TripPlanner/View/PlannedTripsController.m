//
//  PlannedTripsController.m
//  TripPlanner
//
//  Created by Riccardo Strina on 15/07/21.
//

#import "PlannedTripsController.h"
#import "StopsListController.h"
#import "MapStopsController.h"
#import "StopsBarController.h"
#import "NewTripController.h"
#import "Trip.h"
#import "TripPlanner.h"
#import "ExampleData.h"


@interface PlannedTripsController ()

@property (strong, nonatomic) TripPlanner* trips;
@property (strong, nonatomic) ExampleData* app;

@end

@implementation PlannedTripsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _app = [[ExampleData alloc] init];
    
    self.trips = [_app getTrips];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_trips size];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TripCell" forIndexPath:indexPath];
    Trip* t = [self.trips getTripAtIndex:(int)indexPath.row];
    
    cell.textLabel.text = t.name;
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [_trips deleteTripAtIndex:indexPath.row];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
*/
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                                                         title:@"Delete"
                                                                       handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        [self->_trips deleteTripAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        completionHandler(YES);
        }];
    
    
    UIContextualAction *edit = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                                                         title:@"Edit"
                                                                       handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        completionHandler(YES);
        Trip* trip = [self->_trips getTripAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"NewTripSegue" sender:trip];
    }];
    
    delete.backgroundColor = [UIColor  systemRedColor];
    edit.backgroundColor = [UIColor systemBlueColor];
    
    UISwipeActionsConfiguration *swipeActionConfig = [UISwipeActionsConfiguration configurationWithActions:@[delete, edit]];
    swipeActionConfig.performsFirstActionWithFullSwipe = YES;
    
    return swipeActionConfig;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"TripDetailSegue"]){
        if([segue.destinationViewController isKindOfClass:[StopsBarController class]]){
            StopsBarController* tabbar = (StopsBarController*) segue.destinationViewController;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            Trip* t = [self.trips getTripAtIndex:(int)indexPath.row];
            
            tabbar.navigationItem.title = t.name;
            tabbar.trip = t;
            
            NSArray* views = tabbar.viewControllers;  //#1 is the list #2 is the map
            
            StopsListController* list = (StopsListController*)[views objectAtIndex:0];
            MapStopsController* map = (MapStopsController*)[views objectAtIndex:1];
            
            list.trip = t;
            map.trip = t;
        }
    }
    
    if([segue.identifier isEqualToString:@"NewTripSegue"]){
        if([segue.destinationViewController isKindOfClass:[UINavigationController class]]){
            UINavigationController* navController = (UINavigationController*) segue.destinationViewController;
            
            NewTripController* newTripView = (NewTripController*) navController.topViewController;
            newTripView.trips = _trips;
            newTripView.parentView = self;
            
            if([sender isKindOfClass:[Trip class]]){
                newTripView.trip = (Trip*) sender;
            }
        }
    }
}


@end

