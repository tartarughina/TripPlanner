//
//  TripPlanner.h
//  TripPlanner
//
//  Created by Riccardo Strina on 07/07/21.
//

#ifndef TripPlanner_h
#define TripPlanner_h

#import "Trip.h"

@interface TripPlanner : NSObject

-(instancetype) init;
-(instancetype) initWithTrips:(NSMutableArray*) trips;

-(void) addTrip:(Trip*) trip;
-(Trip*) replaceTrip:(Trip*) trip withTrip:(Trip*) newTrip;
-(Trip*) deleteTripAtIndex:(NSUInteger) index;
-(Trip*) getTripAtIndex:(NSUInteger) index;
-(Trip*) getLastTrip;
-(long) size;

@end


#endif /* TripPlanner_h */
