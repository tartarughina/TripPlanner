//
//  Moving.h
//  TripPlanner
//
//  Created by Riccardo Strina on 05/07/21.
//

#ifndef Moving_h
#define Moving_h

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Stop.h"
#import "Place.h"

@interface Moving : Stop

-(instancetype) initWithDescription:(NSString *)description creation:(NSDate *)creation departureLocation:(Place*) departure_loc arrivalLocation:(Place*) arrival_loc movingDate:(NSDate*) moving_date transport:(NSString*) transport;

-(MKPolyline*) getPolyline;

@property (nonatomic, strong) Place* departure_loc;
@property (nonatomic, strong) Place* arrival_loc;
@property (nonatomic, strong) NSDate* moving_date;
@property (nonatomic, strong) NSString* transport;

@end

#endif /* Moving_h */
