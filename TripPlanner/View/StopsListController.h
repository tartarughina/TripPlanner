//
//  StopsListController.h
//  TripPlanner
//
//  Created by Riccardo Strina on 15/07/21.
//

#import <UIKit/UIKit.h>
#import "Trip.h"

NS_ASSUME_NONNULL_BEGIN

@interface StopsListController : UITableViewController

@property (strong, nonatomic) Trip* trip;

@end

NS_ASSUME_NONNULL_END
