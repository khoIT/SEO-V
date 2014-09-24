//
//  CompanyViewController.h
//  JSQMessages
//
//  Created by khoi on 9/24/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CompanyViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *companies;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
