//
//  NewMovingView.m
//  TripPlanner
//
//  Created by Riccardo Strina on 16/07/21.
//

#import "NewMovingView.h"
#import <MapKit/MapKit.h>
#import "StopsListController.h"
#import "MapStopsController.h"
#import "MovingShowController.h"
#import "Moving.h"
#import "Place.h"

@interface NewMovingView ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;
@property (weak, nonatomic) IBOutlet UITextField *transport;
@property (strong, nonatomic) NSMutableArray* places;
@property (strong, nonatomic) MKPolyline* line;

@end

@implementation NewMovingView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _places = [[NSMutableArray alloc] init];
    
    if(_moving != nil){
        _date.date = _moving.moving_date;
        _transport.text = _moving.transport;
        
        MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
        pa.coordinate = _moving.departure_loc.coordinate;
        pa.title = _moving.departure_loc.name;
        
        MKPointAnnotation* pa1 = [[MKPointAnnotation alloc] init];
        pa1.coordinate = _moving.arrival_loc.coordinate;
        pa1.title = _moving.arrival_loc.name;
        
        [self.map setCenterCoordinate:[pa coordinate] animated:YES];
        
        [self.map addAnnotation:pa];
        [_places addObject:pa];
        
        [self.map addAnnotation:pa1];
        [_places addObject:pa1];
        
        _line = [_moving getPolyline];
        [self.map addOverlay: _line];
    }
    
    self.map.delegate = self;
    
    UITapGestureRecognizer *fingerTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(handleMapFingerTap:)];
    
    fingerTap.numberOfTapsRequired = 1;
    fingerTap.numberOfTouchesRequired = 1;
    [self.map addGestureRecognizer:fingerTap];
    
    _date.minimumDate = ((Stop*)[_trip.stops lastObject]).constraintDate;
    _date.maximumDate = ((Stop*)[_trip.stops lastObject]).constraintDate;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay{
    if([overlay isKindOfClass:[MKPolyline class]]){
        MKPolylineRenderer* renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        
        renderer.strokeColor = [UIColor systemYellowColor];
        renderer.lineWidth = 4;
        renderer.lineCap = kCGLineCapRound;
        
        return  renderer;
    }
    
    return nil;
}

- (void)handleMapFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    if(_places.count == 2){
        [_map removeAnnotations:_places];
        [_map removeOverlay: _line];
        [_places removeAllObjects];
    }
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.map];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.map convertPoint:touchPoint toCoordinateFromView:self.map];
    
    MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
    pa.coordinate = touchMapCoordinate;
    
    if(_places.count == 0)
        pa.title = @"Departure point";
    else
        pa.title = @"Arrival point";
    
    [self.map addAnnotation:pa];
    [_places addObject:pa];
    
    if(_places.count == 2){
        MKPointAnnotation* app = [_places objectAtIndex:1];
        CLLocationCoordinate2D coordinateArray[2];
        
        coordinateArray[0] = CLLocationCoordinate2DMake(app.coordinate.latitude, app.coordinate.longitude);
        
        app = [_places objectAtIndex:0];
        
        coordinateArray[1] = CLLocationCoordinate2DMake(app.coordinate.latitude, app.coordinate.longitude);
        
        _line = [MKPolyline polylineWithCoordinates:coordinateArray count:2];
        [_map addOverlay:_line];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

#pragma mark - NavBar Item click

- (IBAction)saveClick:(id)sender {
    if(_places.count == 2){
        MKPointAnnotation* app = [_places objectAtIndex:1];
        
        Place* arrival = [[Place alloc] init];
        arrival.latitude = app.coordinate.latitude;
        arrival.longitude = app.coordinate.longitude;
        arrival.name = @"Arrival";
        
        CLLocation* loc = [[CLLocation alloc] initWithLatitude:app.coordinate.latitude longitude:app.coordinate.longitude];
        
        app = [_places objectAtIndex:0];
        
        Place* departure = [[Place alloc] init];
        departure.latitude = app.coordinate.latitude;
        departure.longitude = app.coordinate.longitude;
        departure.name = @"Departure";
        
        
        CLLocation* loc1 = [[CLLocation alloc] initWithLatitude:app.coordinate.latitude longitude:app.coordinate.longitude];
        
        NSMutableArray* array = [_trip getMapAnnotation];
        NSArray* views = [[NSArray alloc] init];
        
        if([_parentView isKindOfClass:[UITabBarController class]]){
            views = ((UITabBarController*) _parentView).viewControllers;
            
            [_trip addStop:[[Moving alloc] initWithDescription:@"Moving stop" creation:[NSDate date] departureLocation:departure arrivalLocation:arrival movingDate: _date.date transport:_transport.text]];
        }
        else{
            if([_parentView isKindOfClass:[MovingShowController class]]){
                MovingShowController* view = (MovingShowController*) _parentView;
                views = ((UITabBarController*) view.parent).viewControllers;
                
                Moving* stop = [[Moving alloc] initWithDescription:@"Moving stop" creation:[NSDate date] departureLocation:departure arrivalLocation:arrival movingDate: _date.date transport:_transport.text];
                [_trip replaceStop:_moving withStop:stop];
                
                view.departureLable.text = stop.departure_loc.name;
                view.arrivalLable.text = stop.arrival_loc.name;
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateStyle = NSDateFormatterMediumStyle;
                dateFormatter.timeStyle = NSDateFormatterNoStyle;
                dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_UK"];
                view.movingDateLable.text = [dateFormatter stringFromDate:stop.moving_date];
                
                view.transportLable.text = stop.transport;
                
                MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
                pa.coordinate = stop.departure_loc.coordinate;
                pa.title = stop.departure_loc.name;
                
                MKPointAnnotation* pa1 = [[MKPointAnnotation alloc] init];
                pa1.coordinate = stop.arrival_loc.coordinate;
                pa1.title = stop.arrival_loc.name;
                
                [view.map removeAnnotation:_moving.departure_loc];
                [view.map removeAnnotation:_moving.arrival_loc];
                
                [view.map addAnnotation:pa];
                [view.map addAnnotation:pa1];
            }
        }
        
        MapStopsController* mapView = (MapStopsController*)[views objectAtIndex:1];
        [mapView.map removeAnnotations:array];
        [mapView.map removeOverlays: [_trip getMapPolylines]];
        
        [((UITableViewController*)[views objectAtIndex:0]).tableView reloadData];
        
        array = [_trip getMapAnnotation];
        
        [mapView.map addAnnotations:array];
        [mapView.map addOverlays: [_trip getMapPolylines]];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        if(_twoTypeView != nil)
            [self->_twoTypeView dismissViewControllerAnimated:YES completion:nil];
       
        [[[CLGeocoder alloc] init] reverseGeocodeLocation: loc1 completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            departure.name = placemarks.firstObject.locality;
            [((UITableViewController*)[views objectAtIndex:0]).tableView reloadData];
        }];

        [[[CLGeocoder alloc] init] reverseGeocodeLocation: loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            arrival.name = placemarks.firstObject.locality;
            [((UITableViewController*)[views objectAtIndex:0]).tableView reloadData];
        }];
    }
    else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Attention"
                                                                       message:@"Insert at least two location, insert it tapping on the map"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
