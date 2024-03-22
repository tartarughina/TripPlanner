//
//  MovingShowController.m
//  TripPlanner
//
//  Created by Riccardo Strina on 17/07/21.
//

#import "MovingShowController.h"
#import "NewMovingView.h"
#import <MapKit/MapKit.h>

@interface MovingShowController ()<MKMapViewDelegate>

@end

@implementation MovingShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.map.delegate = self;
    
    _departureLable.text = _stop.departure_loc.name;
    _arrivalLable.text = _stop.arrival_loc.name;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_UK"];
    _movingDateLable.text = [dateFormatter stringFromDate:_stop.moving_date];
    
    _transportLable.text = _stop.transport;
    
    MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
    pa.coordinate = _stop.departure_loc.coordinate;
    pa.title = _stop.departure_loc.name;
    
    MKPointAnnotation* pa1 = [[MKPointAnnotation alloc] init];
    pa1.coordinate = _stop.arrival_loc.coordinate;
    pa1.title = _stop.arrival_loc.name;
    
    [self.map setCenterCoordinate:[pa coordinate] animated:YES];
    
    [self.map addAnnotation:pa];
    
    [self.map addAnnotation:pa1];
    
    [self.map addOverlay: [_stop getPolyline]];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay{
    if([overlay isKindOfClass:[MKPolyline class]]){
        MKPolylineRenderer* renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        
        renderer.strokeColor = [UIColor systemYellowColor];
        renderer.lineWidth = 4;
        renderer.lineCap = kCGLineCapRound;
        
        return  renderer;
    }
    
    return nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
        return 2;
    
    return 1;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"GIO");
    
    return cell;
}

*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    if([segue.destinationViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController* navController = (UINavigationController*) segue.destinationViewController;
        
        NewMovingView* view = (NewMovingView*) navController.topViewController;
        
        view.twoTypeView = nil;
        view.moving = _stop;
        view.parentView = self;
        view.trip = _trip;
    }
}


@end
