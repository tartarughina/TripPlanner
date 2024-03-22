//
//  MovingShowController.h
//  TripPlanner
//
//  Created by Riccardo Strina on 17/07/21.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Trip.h"
#import "Moving.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovingShowController : UITableViewController

@property (strong, nonatomic) Moving* stop;
@property (strong, nonatomic) Trip* trip;
@property (weak, nonatomic) UIViewController* parent;
@property (weak, nonatomic) IBOutlet UILabel *departureLable;
@property (weak, nonatomic) IBOutlet UILabel *arrivalLable;
@property (weak, nonatomic) IBOutlet UILabel *movingDateLable;
@property (weak, nonatomic) IBOutlet UILabel *transportLable;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

NS_ASSUME_NONNULL_END
