//
//  MapViewController.h
//  
//
//  Created by khoi on 9/24/14.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController
@property (nonatomic, strong) NSMutableArray  *mapData;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end
