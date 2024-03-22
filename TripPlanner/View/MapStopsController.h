//
//  MapStopsController.h
//  TripPlanner
//
//  Created by Riccardo Strina on 15/07/21.
//

#import <UIKit/UIKit.h>
#import "Trip.h"
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapStopsController : UIViewController

@property (strong, nonatomic) Trip* trip;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

NS_ASSUME_NONNULL_END
