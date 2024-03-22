//
//  Staying.h
//  TripPlanner
//
//  Created by Riccardo Strina on 05/07/21.
//

#ifndef Staying_h
#define Staying_h

#import <Foundation/Foundation.h>
#import "Place.h"
#import "Stop.h"

@interface Staying : Stop

-(instancetype) initWithDescription:(NSString *)description creation:(NSDate *)creation location: (Place*) location arrival:(NSDate*) arrival departure: (NSDate*) departure accomodation: (NSString*) accomodation;

@property (readonly, strong) Place* location;
@property (readonly, strong) NSDate* arrival;
@property (readonly, strong) NSDate* departure;
@property (readonly, strong) NSString* accomodation;

@end

#endif /* Staying_h */
