//
//  Stop.m
//  TripPlanner
//
//  Created by Riccardo Strina on 06/07/21.
//

#import <Foundation/Foundation.h>
#import "Stop.h"

@implementation Stop

-(instancetype) initWithDescription:(NSString *)description creation:(NSDate *)creation{
    if(self = [super init]){
        _desc = [description copy];
        _creation = [creation copy];
    }
    
    return self;
}

-(NSString*) getDetails{
    return [NSString stringWithFormat:@"Stop %@ created on %@", self.desc, self.creation];
}

-(NSDate*) comparisonDate{
    return _creation;
}

-(NSDate*) constraintDate{
    return _creation;
}

@end
