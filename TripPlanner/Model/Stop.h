//
//  Stop.h
//  TripPlanner
//
//  Created by Riccardo Strina on 05/07/21.
//

#import <Foundation/Foundation.h>

@interface Stop : NSObject

-(instancetype) initWithDescription: (NSString*) description
                           creation: (NSDate*) creation;
-(NSString*) getDetails;
-(NSDate*) comparisonDate;
-(NSDate*) constraintDate;

@property (nonatomic, strong) NSString* desc;
@property (nonatomic, readonly) NSDate* creation;

@end

