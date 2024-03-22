//
//  Trip.h
//  TripPlanner
//
//  Created by Riccardo Strina on 05/07/21.
//

#ifndef Trip_h
#define Trip_h

#import <Foundation/Foundation.h>
#import "Stop.h"

@interface Trip : NSObject

- (instancetype) initWithName: (NSString*) name
                  description: (NSString*) description;

- (instancetype) initWithName: (NSString*) name
                  description: (NSString*) description
                        begin: (NSDate*) begin
                          end: (NSDate*) end;

- (instancetype) initWithName: (NSString*) name
                  description: (NSString*) description
                        begin: (NSDate*) begin
                          end: (NSDate*) end
                        stops: (NSMutableArray*) stops;

-(void) addStop:(Stop*) stop;
-(Stop*) removeStopAtIndex:(NSUInteger) index;
-(Stop*) replaceStop:(Stop*) stop withStop:(Stop*) newStop;
-(NSMutableArray*) getMapAnnotation;
-(NSMutableArray*) getMapPolylines;

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* desc;
@property (nonatomic, strong) NSDate* begin;
@property (nonatomic, strong) NSDate* end;
@property (nonatomic, copy) NSMutableArray* stops;

@end


#endif /* Trip_h */
