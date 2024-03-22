//
//  NewTripController.h
//  TripPlanner
//
//  Created by Riccardo Strina on 15/07/21.
//

#import <UIKit/UIKit.h>
#import "TripPlanner.h"
#import "PlannedTripsController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewTripController : UITableViewController

@property (strong, nonatomic) TripPlanner* trips;
@property (strong, nonatomic) Trip* trip;
@property (weak, nonatomic) PlannedTripsController* parentView;

@end

NS_ASSUME_NONNULL_END
