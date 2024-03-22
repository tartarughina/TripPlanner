//
//  NewMovingView.h
//  TripPlanner
//
//  Created by Riccardo Strina on 16/07/21.
//

#import <UIKit/UIKit.h>
#import "Trip.h"
#import "Moving.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewMovingView : UITableViewController

@property (strong, nonatomic) Trip* trip;
@property (weak, nonatomic) UIViewController* parentView;
@property (weak, nonatomic) UIViewController* twoTypeView;
@property (weak, nonatomic) Moving* moving;

@end

NS_ASSUME_NONNULL_END
