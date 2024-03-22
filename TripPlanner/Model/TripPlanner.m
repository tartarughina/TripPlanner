//
//  TripPlanner.m
//  TripPlanner
//
//  Created by Riccardo Strina on 07/07/21.
//

#import <Foundation/Foundation.h>
#import "TripPlanner.h"
#import "Stop.h"

@interface TripPlanner ()

@property (nonatomic, readonly) NSMutableArray* trips;

@end

@implementation TripPlanner

-(instancetype) init{
    if(self = [super init]){
        _trips = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(instancetype) initWithTrips:(NSMutableArray *)trips{
    if(self = [super init]){
        _trips = trips;
    }
    
    return self;
}

-(void) addTrip:(Trip *)trip{
    if(trip != nil){
        [_trips addObject:trip];
    }
}

-(Trip*) replaceTrip:(Trip *)trip withTrip:(Trip *)newTrip{
    if(newTrip != nil && trip != nil){
        NSUInteger index = [_trips indexOfObject:trip];
        
        [_trips replaceObjectAtIndex:index withObject:newTrip];
        
        return trip;
    }
    
    return nil;
}

-(Trip*) deleteTripAtIndex:(NSUInteger) index{
    if(index >= 0){
        Trip* app = [_trips objectAtIndex:index];
        [_trips removeObjectAtIndex:index];
        
        return app;
    }
    
    return nil;
}

-(Trip*) getTripAtIndex:(NSUInteger)index{
    if(index >= 0 && index <= _trips.count){
        return [_trips objectAtIndex:index];
    }
    
    return nil;
}

-(Trip*) getLastTrip{
    return [_trips objectAtIndex:_trips.count - 1];
}

-(long) size{
    return self.trips.count;
}

@end
