//
//  NewStayingView.m
//  TripPlanner
//
//  Created by Riccardo Strina on 16/07/21.
//

#import "NewStayingView.h"
#import <MapKit/MapKit.h>
#import "MapStopsController.h"
#import "StayingShowController.h"
#import "Place.h"
#import "Staying.h"

@interface NewStayingView ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UIDatePicker *arrivalDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *departureDate;
@property (weak, nonatomic) IBOutlet UITextField *accomodation;
@property (strong, nonatomic) MKPointAnnotation* location;

@end

@implementation NewStayingView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(_staying != nil){
        MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
        pa.coordinate = _staying.location.coordinate;
        pa.title =  _staying.location.name;
        [self.map addAnnotation:pa];
        [self.map setCenterCoordinate:[pa coordinate] animated:YES];
        _location = pa;
        
        _arrivalDate.date = _staying.arrival;
        _departureDate.date = _staying.departure;
        _accomodation.text = _staying.accomodation;
    }
    
    _location = nil;
    
    self.map.delegate = self;
    
    UITapGestureRecognizer *fingerTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(handleMapFingerTap:)];
    
    fingerTap.numberOfTapsRequired = 1;
    fingerTap.numberOfTouchesRequired = 1;
    [self.map addGestureRecognizer:fingerTap];
    
    _arrivalDate.minimumDate = ((Stop*)[_trip.stops lastObject]).constraintDate;
    _arrivalDate.maximumDate = _trip.end;
    _departureDate.minimumDate = ((Stop*)[_trip.stops lastObject]).constraintDate;
}

- (void)handleMapFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    if(_location != nil){
        [self.map removeAnnotation:_location];
    }
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.map];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.map convertPoint:touchPoint toCoordinateFromView:self.map];
    
    MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
    pa.coordinate = touchMapCoordinate;
    
    pa.title = @"Location";
    
    [self.map addAnnotation:pa];
    _location = pa;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 1)
        return 2;
    
    return 1;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)saveClick:(id)sender {
    
    if(_location != nil){
        MKPointAnnotation* app = _location;
        
        Place* location = [[Place alloc] init];
        location.latitude = app.coordinate.latitude;
        location.longitude = app.coordinate.longitude;
        location.name = @"Location";
        
        CLLocation* loc = [[CLLocation alloc] initWithLatitude:app.coordinate.latitude longitude:app.coordinate.longitude];
        
        NSArray* views = [[NSArray alloc] init];
        NSMutableArray* array = [_trip getMapAnnotation];
        
        if([_parentView isKindOfClass:[UITabBarController class]]){
            [_trip addStop:[[Staying alloc] initWithDescription:@"Staying stop" creation:[NSDate date] location:location arrival:_arrivalDate.date departure:_departureDate.date accomodation:_accomodation.text]];
            
            views = ((UITabBarController*) _parentView).viewControllers;
        }
        else{
            if([_parentView isKindOfClass:[StayingShowController class]]){
                StayingShowController* view = (StayingShowController*) _parentView;
                views = ((UITabBarController*) view.parent).viewControllers;
                
                Staying * stop = [[Staying alloc] initWithDescription:@"Staying stop" creation:[NSDate date] location:location arrival:_arrivalDate.date departure:_departureDate.date accomodation:_accomodation.text];
                
                [_trip replaceStop:_staying withStop:stop];
                
                view.locationLable.text = stop.location.name;
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateStyle = NSDateFormatterMediumStyle;
                dateFormatter.timeStyle = NSDateFormatterNoStyle;
                dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_UK"];
                view.departureLable.text = [dateFormatter stringFromDate:stop.departure];
                view.arrivalLable.text = [dateFormatter stringFromDate:stop.arrival];
                
                view.accomodationLable.text = stop.accomodation;
                
                MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
                pa.coordinate = stop.location.coordinate;
                pa.title = stop.location.name;
                
                [view.map removeAnnotation:_staying.location];
                [view.map addAnnotation:pa];
            }
        }
        
        MapStopsController* mapView = (MapStopsController*)[views objectAtIndex:1];
        
        [mapView.map removeAnnotations:array];
        
        [((UITableViewController*)[views objectAtIndex:0]).tableView reloadData];
        
        array = [_trip getMapAnnotation];
        
        for (Place* place in array) {
            [mapView.map addAnnotation:place];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        
        if(_twoTypeView != nil){
            [self->_twoTypeView dismissViewControllerAnimated:YES completion:nil];
        }
        
        [[[CLGeocoder alloc] init] reverseGeocodeLocation: loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            location.name = placemarks.firstObject.locality;
            [((UITableViewController*)[views objectAtIndex:0]).tableView reloadData];
        }];
    }
    else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Attention"
                                                                       message:@"Insert at least a location tapping on the map"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    

}
- (IBAction)arrivalDateChanged:(id)sender {
    _departureDate.minimumDate = _arrivalDate.date;
}

- (IBAction)departureDateChanged:(id)sender {
    //_arrivalDate.maximumDate = _departureDate.date;
}

@end
