//
//  StopTypeTable.m
//  TripPlanner
//
//  Created by Riccardo Strina on 16/07/21.
//

#import "StopTypeTable.h"
#import "NewMovingView.h"
#import "NewStayingView.h"

@interface StopTypeTable ()

@end

@implementation StopTypeTable

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    if([segue.identifier isEqualToString:@"NewMovingSegue"]){
        if([segue.destinationViewController isKindOfClass:[UINavigationController class]]){
            UINavigationController* navController = (UINavigationController*) segue.destinationViewController;
            
            NewMovingView* stopType = (NewMovingView*) navController.topViewController;
            stopType.trip = _trip;
            stopType.parentView = _parentView;
            stopType.twoTypeView = self;
        }
    }
    
    if([segue.identifier isEqualToString:@"NewStayingSegue"]){
        if([segue.destinationViewController isKindOfClass:[UINavigationController class]]){
            UINavigationController* navController = (UINavigationController*) segue.destinationViewController;
            
            NewStayingView* stopType = (NewStayingView*) navController.topViewController;
            stopType.trip = _trip;
            stopType.parentView = _parentView;
            stopType.twoTypeView = self;
        }
    }
}


@end
