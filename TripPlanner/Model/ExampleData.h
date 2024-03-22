//
//  ExampleData.h
//  TripPlanner
//
//  Created by Riccardo Strina on 15/07/21.
//

#import <Foundation/Foundation.h>
#import "TripPlanner.h"
#import "Staying.h"
#import "Moving.h"
#import "Place.h"
#import "Trip.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExampleData : NSObject

@property (strong, nonatomic) TripPlanner* trips;

-(instancetype) init;
-(TripPlanner*) getTrips;

@end

NS_ASSUME_NONNULL_END
