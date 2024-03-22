//
//  StayingShowController.h
//  TripPlanner
//
//  Created by Riccardo Strina on 17/07/21.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Staying.h"
#import "Trip.h"

NS_ASSUME_NONNULL_BEGIN

@interface StayingShowController : UITableViewController

@property (strong, nonatomic) Staying* stop;
@property (strong, nonatomic) Trip* trip;
@property (weak, nonatomic) UIViewController* parent;
@property (weak, nonatomic) IBOutlet UILabel *locationLable;
@property (weak, nonatomic) IBOutlet UILabel *departureLable;
@property (weak, nonatomic) IBOutlet UILabel *arrivalLable;
@property (weak, nonatomic) IBOutlet UILabel *accomodationLable;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

NS_ASSUME_NONNULL_END
