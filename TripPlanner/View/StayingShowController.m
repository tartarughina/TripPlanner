//
//  StayingShowController.m
//  TripPlanner
//
//  Created by Riccardo Strina on 17/07/21.
//

#import "StayingShowController.h"
#import "NewStayingView.h"

@interface StayingShowController ()

@end

@implementation StayingShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationLable.text = _stop.location.name;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_UK"];
    _departureLable.text = [dateFormatter stringFromDate:_stop.departure];
    _arrivalLable.text = [dateFormatter stringFromDate:_stop.arrival];
    
    _accomodationLable.text = _stop.accomodation;
    
    MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
    pa.coordinate = _stop.location.coordinate;
    pa.title = _stop.location.name;
    
    [self.map setCenterCoordinate:[pa coordinate] animated:YES];
    [self.map addAnnotation:pa];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 1)
        return 2;
    
    return 1;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
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
        
        NewStayingView* view = (NewStayingView*) navController.topViewController;
        
        view.twoTypeView = nil;
        view.staying = _stop;
        view.parentView = self;
        view.trip = _trip;
    }
}


@end
