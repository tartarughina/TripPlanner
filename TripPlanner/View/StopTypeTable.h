//
//  StopTypeTable.h
//  TripPlanner
//
//  Created by Riccardo Strina on 16/07/21.
//

#import <UIKit/UIKit.h>
#import "Trip.h"

NS_ASSUME_NONNULL_BEGIN

@interface StopTypeTable : UITableViewController

@property (nonatomic, strong) Trip* trip;
@property (weak, nonatomic) UIViewController* parentView;

@end

NS_ASSUME_NONNULL_END
