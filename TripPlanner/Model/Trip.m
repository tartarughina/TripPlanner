//
//  Trip.m
//  TripPlanner
//
//  Created by Riccardo Strina on 06/07/21.
//

#import <Foundation/Foundation.h>
#import "Trip.h"
#import "Moving.h"
#import "Staying.h"

@interface Trip ()

-(void) sort;

@end

@implementation Trip

-(instancetype) initWithName:(NSString *)name description:(NSString *)description{
    if(self = [super init]){
        _name = [name copy];
        _desc = [description copy];
        _begin = nil;
        _end = nil;
        _stops = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(instancetype) initWithName:(NSString *)name description:(NSString *)description begin:(NSDate *)begin end:(NSDate *)end{
    if(self = [super init]){
        _name = [name copy];
        _desc = [description copy];
        _begin = [begin copy];
        _end = [end copy];
        _stops = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(instancetype) initWithName:(NSString *)name description:(NSString *)description begin:(NSDate *)begin end:(NSDate *)end stops:(NSMutableArray *)stops{
    if(self = [super init]){
        _name = [name copy];
        _desc = [description copy];
        _begin = [begin copy];
        _end = [end copy];
        _stops = stops;
    }
    
    return self;
}

-(void) addStop:(Stop *)stop{
    [self.stops addObject:stop];
    
    [self sort];
}

-(Stop*) removeStopAtIndex:(NSUInteger)index{
    if(index >= 0 && _stops.count > 0){
        Stop* ret = [_stops objectAtIndex:index];
        
        [self.stops removeObjectAtIndex:index];
        
        return ret;
    }
    
    return nil;
}

-(Stop*) replaceStop:(Stop *)stop withStop:(Stop*) newStop{
    if(newStop != nil && stop != nil){
        NSUInteger index = [self.stops indexOfObject:stop];
        
        [self.stops replaceObjectAtIndex:index withObject:newStop];
        
        [self sort];
        
        return stop;
    }
    
    return nil;
}

-(NSMutableArray*) getMapAnnotation{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    NSInteger index = 1;
    
    for (Stop* stop in _stops) {
        if([stop isKindOfClass:[Moving class]]){
            Moving* app = (Moving*) stop;
            
            app.arrival_loc.desc = [NSString stringWithFormat:@"%ldº stop: arrival location", (long)index];
            app.departure_loc.desc = [NSString stringWithFormat:@"%ldº stop: departure location", (long)index];
            
            [ret addObject:app.arrival_loc];
            [ret addObject:app.departure_loc];
        }
        else{
            Staying* app = (Staying*) stop;
            
            app.location.desc = [NSString stringWithFormat:@"%ld stop: staying location", (long)index];
            
            [ret addObject:app.location];
        }
        
        index += 1;
    }
    
    return ret;
}

-(NSMutableArray*) getMapPolylines{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    
    for (Stop* stop in _stops) {
        if([stop isKindOfClass:[Moving class]]){
            [ret addObject:[((Moving*)stop) getPolyline]];
        }
    }
    
    return ret;
}


-(void) sort{
        _stops = [NSMutableArray arrayWithArray:[_stops sortedArrayUsingComparator:^(Stop* obj1, Stop* obj2) {
        NSDate* date1 = [obj1 comparisonDate];
        NSDate* date2 = [obj2 comparisonDate];
        
        if ([date1 compare:date2] == NSOrderedDescending) {
            return NSOrderedDescending;
        } else if ([date1 compare:date2] == NSOrderedAscending) {
            return NSOrderedAscending;
        } else {
            return NSOrderedSame;
        }
    }]];
}

@end
