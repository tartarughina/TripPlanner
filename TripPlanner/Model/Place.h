//
//  Place.h
//  TripPlanner
//
//  Created by Riccardo Strina on 05/07/21.
//

#ifndef Place_h
#define Place_h

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Place : NSObject<MKAnnotation>

-(instancetype) initWithName:(NSString*)name;
-(instancetype) initWithName:(NSString *)name latitude:(double) latitude longitude:(double) longitude;

-(NSString*) getDetails;

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* desc;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end


#endif /* Place_h */
