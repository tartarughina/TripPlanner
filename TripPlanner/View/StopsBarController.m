//
//  StopsBarController.m
//  TripPlanner
//
//  Created by Riccardo Strina on 16/07/21.
//

#import "StopsBarController.h"
#import "StopTypeTable.h"

@interface StopsBarController ()

@end

@implementation StopsBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"NewStopSegue"]){
        if([segue.destinationViewController isKindOfClass:[StopTypeTable class]]){
            
            StopTypeTable* stopType = (StopTypeTable*) segue.destinationViewController;
            stopType.trip = _trip;
            stopType.parentView = self;
        }
    }
}


@end
