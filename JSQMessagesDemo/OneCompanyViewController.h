//
//  OneCompanyViewController.h
//  JSQMessages
//
//  Created by khoi on 9/24/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"

@interface OneCompanyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) Company *company;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
