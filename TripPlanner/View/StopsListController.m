//
//  StopsListController.m
//  TripPlanner
//
//  Created by Riccardo Strina on 15/07/21.
//

#import "StopsListController.h"
#import "Stop.h"
#import "MovingShowController.h"
#import "StayingShowController.h"
#import "MapStopsController.h"
#import "Moving.h"

@interface StopsListController ()

@end

@implementation StopsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _trip.stops.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StopCell" forIndexPath:indexPath];
    
    Stop* stop = [_trip.stops objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text = [stop getDetails];
    cell.textLabel.text = [NSString stringWithFormat:@"%ldº", (long)indexPath.row + 1];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Stop* stop = [_trip.stops objectAtIndex:indexPath.row];
    
    if([stop isKindOfClass:[Moving class]]){
        [self performSegueWithIdentifier:@"MovingListSegue" sender:stop];
    }
    else{
        [self performSegueWithIdentifier:@"StayingListSegue" sender:stop];
    }
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        Stop* stop = [_trip removeStopAtIndex:indexPath.row];
        
        NSArray* views = ((UITabBarController*) self.presentingViewController).viewControllers;
        
        MapStopsController* mapView = (MapStopsController*)[views objectAtIndex:1];
        
        if([stop isKindOfClass:[Moving class]]){
            Moving* moving = (Moving*)stop;
            
            [mapView.map removeAnnotation:moving.arrival_loc];
            [mapView.map removeAnnotation:moving.departure_loc];
        }
        else{
            Staying* staying = (Staying*)stop;
            
            [mapView.map removeAnnotation: staying.location];
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[MovingShowController class]]){
        MovingShowController* view = (MovingShowController*)segue.destinationViewController;
        
        view.stop = (Moving*) sender;
        view.trip = _trip;
        view.parent = self.parentViewController;
    }
    
    if([segue.destinationViewController isKindOfClass:[StayingShowController class]]){
        StayingShowController* view = (StayingShowController*)segue.destinationViewController;
        
        view.stop = (Staying*) sender;
        view.trip = _trip;
        view.parent = self.parentViewController;
    }
}


@end
