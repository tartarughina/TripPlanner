//
//  Staying.m
//  TripPlanner
//
//  Created by Riccardo Strina on 06/07/21.
//

#import <Foundation/Foundation.h>
#import "Staying.h"

@implementation Staying

-(instancetype) initWithDescription:(NSString *)description creation:(NSDate *)creation{
    if(self = [super initWithDescription:description creation:creation]){
        _location = nil;
        _arrival = nil;
        _departure = nil;
        _accomodation = nil;
    }
    
    return self;
}

-(instancetype) initWithDescription:(NSString *)description creation:(NSDate *)creation location:(Place *)location arrival:(NSDate *)arrival departure:(NSDate *)departure accomodation:(NSString *)accomodation{
    if(self = [super initWithDescription:description creation:creation]){
        _location = location;
        _arrival = [arrival copy];
        _departure = [departure copy];
        _accomodation = [accomodation copy];
    }
    
    return self;
}

-(NSString*) getDetails{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_UK"];
    
    return [NSString stringWithFormat:@"%@ from %@ to %@",
            self.location.name, [dateFormatter stringFromDate:self.arrival], [dateFormatter stringFromDate:self.departure]];
}

-(NSDate*) comparisonDate{
    return _arrival;
}

-(NSDate*) constraintDate{
    return _departure;
}

@end
