//
//  MapStopsController.m
//  TripPlanner
//
//  Created by Riccardo Strina on 15/07/21.
//

#import "MapStopsController.h"
#import "Place.h"

@interface MapStopsController ()<MKMapViewDelegate>

@end

@implementation MapStopsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.map.delegate = self;
    
    NSMutableArray* array = [_trip getMapAnnotation];
    
    for (Place* place in array) {
        [self.map addAnnotation:place];
    }
    
    [self.map setCenterCoordinate:[[array objectAtIndex:0] coordinate] animated:YES];
    
    [self.map addOverlays:[_trip getMapPolylines]];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay{
    if([overlay isKindOfClass:[MKPolyline class]]){
        MKPolylineRenderer* renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        
        renderer.strokeColor = [UIColor systemYellowColor];
        renderer.lineWidth = 3;
        renderer.lineCap = kCGLineCapRound;
        
        return  renderer;
    }
    
    return nil;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView
             viewForAnnotation:(id<MKAnnotation>)annotation{
    
    static NSString *AnnotationIdentifer = @"MapAnnotationView";
    
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifer];
    
    if(!view){
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:AnnotationIdentifer];
        view.canShowCallout = YES;
    }
    
    view.annotation = annotation;
    
    view.leftCalloutAccessoryView = nil;
    view.rightCalloutAccessoryView = nil;
    
    return view;
    
}

- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
}

- (void) mapView:(MKMapView *)mapView
  annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control{
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
