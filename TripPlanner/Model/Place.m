//
//  Place.m
//  TripPlanner
//
//  Created by Riccardo Strina on 06/07/21.
//

#import <Foundation/Foundation.h>
#import "Place.h"

@implementation Place

-(instancetype) initWithName:(NSString*)name{
    if(self = [super init]){
        _name = [name copy];
        _desc = @"";
        _latitude = 0;
        _longitude = 0;
    }
    
    return self;
}
-(instancetype) initWithName:(NSString *)name latitude:(double) latitude longitude:(double) longitude{
    if(self = [super init]){
        _name = [name copy];
        _desc = @"";
        _latitude = latitude;
        _longitude = longitude;
    }
    
    return self;
}

-(NSString*) getDetails{
    return [NSString stringWithFormat:@"%@ -- lat: %f lng: %f", self.name, self.latitude, self.longitude];
}

- (CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
}

- (NSString *)title{
    return self.name;
}

- (NSString *)subtitle{
    return self.desc;
}

@end
