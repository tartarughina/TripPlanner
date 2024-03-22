//
//  Moving.m
//  TripPlanner
//
//  Created by Riccardo Strina on 07/07/21.
//

#import <Foundation/Foundation.h>
#import "Moving.h"

@implementation Moving

-(instancetype) initWithDescription:(NSString *)description creation:(NSDate *)creation{
    if(self = [super initWithDescription:description creation:creation]){
        _departure_loc = nil;
        _arrival_loc = nil;
        _moving_date = nil;
        _transport = nil;
    }
    
    return self;
}

-(instancetype) initWithDescription:(NSString *)description creation:(NSDate *)creation departureLocation:(Place *)departure_loc arrivalLocation:(Place *)arrival_loc movingDate:(NSDate *)moving_date transport:(NSString *)transport{
    if(self = [super initWithDescription:description creation:creation]){
        _departure_loc = departure_loc;
        _arrival_loc = arrival_loc;
        _moving_date = [moving_date copy];
        _transport = [transport copy];
    }
    
    return self;
}

-(NSString*) getDetails{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_UK"];
    
    return [NSString stringWithFormat:@"from %@ to %@ on %@",
            self.departure_loc.name, self.arrival_loc.name, [dateFormatter stringFromDate:self.moving_date]];
}

-(NSDate*) comparisonDate{
    return _moving_date;
}

-(MKPolyline*) getPolyline{
    CLLocationCoordinate2D coordinateArray[2];
    coordinateArray[0] = CLLocationCoordinate2DMake(self.departure_loc.latitude, self.departure_loc.longitude);
    coordinateArray[1] = CLLocationCoordinate2DMake(self.arrival_loc.latitude, self.arrival_loc.longitude);
    
    
    return [MKPolyline polylineWithCoordinates:coordinateArray count:2];
}

-(NSDate*) constraintDate{
    return _moving_date;
}

@end
