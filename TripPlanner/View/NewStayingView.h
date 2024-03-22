//
//  NewStayingView.h
//  TripPlanner
//
//  Created by Riccardo Strina on 16/07/21.
//

#import <UIKit/UIKit.h>
#import "Trip.h"
#import "Staying.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewStayingView : UITableViewController

@property (strong, nonatomic) Trip* trip;
@property (weak, nonatomic) UIViewController* parentView;
@property (weak, nonatomic) UIViewController* twoTypeView;
@property (weak, nonatomic) Staying* staying;

@end

NS_ASSUME_NONNULL_END
