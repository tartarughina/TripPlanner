//
//  StopsBarController.h
//  TripPlanner
//
//  Created by Riccardo Strina on 16/07/21.
//

#import <UIKit/UIKit.h>
#import "Trip.h"

NS_ASSUME_NONNULL_BEGIN

@interface StopsBarController : UITabBarController

@property (strong, nonatomic) Trip* trip;

@end

NS_ASSUME_NONNULL_END
