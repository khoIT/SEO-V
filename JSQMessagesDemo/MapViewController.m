//
//  MapViewController.m
//  
//
//  Created by khoi on 9/24/14.
//
//

#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

#import "MapViewController.h"
#import "GeoPointAnnotation.h"

@implementation MapViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    //Loading data from table
    self.mapData = [NSMutableArray array];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Location"];
    [query orderByAscending:@"seo_id"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            
            for (PFObject *object in objects) {
                [self.mapData addObject:object];
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [self viewDidAppear:NO];
    }];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    //Adding data to map
    if (self.mapData) {
        
        double minlat = 11.0; //subject to change based on input data
        double maxlat = 10.0;
        double minlong = 107.0;
        double maxlong = 106.0;
        
        for (int i=0; i<[self.mapData count]; i++)
        {
            // obtain the geopoint
            PFGeoPoint *geoPoint = [self.mapData objectAtIndex:i][@"location"];
            
            //find the edge
            if (geoPoint.latitude < minlat)
                minlat = geoPoint.latitude;
            if (geoPoint.latitude > maxlat)
                maxlat = geoPoint.latitude;
            if (geoPoint.longitude < minlong)
                minlong = geoPoint.longitude;
            if (geoPoint.longitude > maxlong)
                maxlong = geoPoint.longitude;
        }
        double latcenter = (minlat + maxlat)/2;
        double longcenter = (minlong + maxlong)/2;
        
        // center our map view around this geopoint
        self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(latcenter, longcenter), MKCoordinateSpanMake(0.13f, 0.13f));
        
        for (int i=0; i<[self.mapData count]; i++){
            // add the annotation
            GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:[self.mapData objectAtIndex:i]];
            [self.mapView addAnnotation:annotation];
        }
    }
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationMaskPortrait);
}


#pragma mark - MKMapViewDelegate


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *GeoPointAnnotationIdentifier = @"RedPin";
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:GeoPointAnnotationIdentifier];
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:GeoPointAnnotationIdentifier];
        annotationView.pinColor = MKPinAnnotationColorRed;
        annotationView.canShowCallout = YES;
        annotationView.draggable = NO;
        annotationView.animatesDrop = YES;
        
    }
    return annotationView;
}


@end
