//
//  GeoPointAnnotation.m
//  JSQMessages
//
//  Created by khoi on 9/24/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import "GeoPointAnnotation.h"

@interface GeoPointAnnotation()
@property (nonatomic, strong) PFObject *object;
@end

@implementation GeoPointAnnotation


#pragma mark - Initialization

- (id)initWithObject:(PFObject *)aObject {
    self = [super init];
    if (self) {
        _object = aObject;
        
        PFGeoPoint *geoPoint = self.object[@"location"];
        NSString *name = self.object[@"Name"];
        NSString *description = self.object[@"Description"];
        [self setGeoPoint:geoPoint :name :description];
    }
    return self;
}


#pragma mark - MKAnnotation

// Called when the annotation is dragged and dropped. We update the geoPoint with the new coordinates.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    NSString *name = self.object[@"Name"];
    NSString *description = self.object[@"Description"];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:newCoordinate.latitude longitude:newCoordinate.longitude];
    [self setGeoPoint:geoPoint :name :description];
    [self.object setObject:geoPoint forKey:@"location"];
    [self.object saveEventually:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // Send a notification when this geopoint has been updated. MasterViewController will be listening for this notification, and will reload its data when this notification is received.
            [[NSNotificationCenter defaultCenter] postNotificationName:@"geoPointAnnotiationUpdated" object:self.object];
        }
    }];
}


#pragma mark - ()

- (void)setGeoPoint:(PFGeoPoint *)geoPoint :(NSString *)name :(NSString *)description{
    _coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
    
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    }
    
    static NSNumberFormatter *numberFormatter = nil;
    if (numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.maximumFractionDigits = 3;
    }
    
    _title = name;
    _subtitle = description;
    //_subtitle = [NSString stringWithFormat:@"%@, %@", [numberFormatter stringFromNumber:[NSNumber numberWithDouble:geoPoint.latitude]],
    //           [numberFormatter stringFromNumber:[NSNumber numberWithDouble:geoPoint.longitude]]];
}

@end
