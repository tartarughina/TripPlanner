//
//  ExampleData.m
//  TripPlanner
//
//  Created by Riccardo Strina on 15/07/21.
//

#import "ExampleData.h"

@implementation ExampleData

-(instancetype) init{
    if(self = [super init]){
        Place* place = [[Place alloc] initWithName:@"Test place" latitude:44 longitude:10];
        Place* secondPlace = [[Place alloc] initWithName:@"Test second place" latitude:45 longitude:12];
        
        NSDate* arrival = [NSDate date];
        NSDate* departure = [NSDate dateWithTimeIntervalSinceNow:3600*48];
        
        NSMutableArray* stops = [[NSMutableArray alloc] init];
        
        [stops addObject:[[Staying alloc] initWithDescription:@"Staying Test" creation:[NSDate date] location:place arrival:arrival departure:departure accomodation:@"Test accomodation"]];
        [stops addObject:[[Moving alloc] initWithDescription:@"Moving test" creation:[NSDate date] departureLocation:place arrivalLocation:secondPlace movingDate:departure transport:@"Test transport"]];
                                  
        
        NSMutableArray* trips = [[NSMutableArray alloc] init];
        [trips addObject:[[Trip alloc] initWithName:@"Test trip 1" description:@"Test description 1" begin:arrival end:departure stops:stops]];
        [trips addObject:[[Trip alloc] initWithName:@"Test trip 2" description:@"Test description 2" begin:arrival end:departure stops:stops]];
        
        TripPlanner* tripPlanner = [[TripPlanner alloc] initWithTrips:trips];
        
        _trips = tripPlanner;
    }
    
    return self;
}

-(TripPlanner*) getTrips{
    return _trips;
}

@end
