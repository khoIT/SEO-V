//
//  OneCompanyViewController.m
//  JSQMessages
//
//  Created by khoi on 9/24/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import "OneCompanyViewController.h"


@implementation OneCompanyViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.textView.editable = NO;
    self.textView.text = self.company.info ;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat: @"%@.png",self.company.number]];
    [self.titleLabel setText:self.company.name];
    
}

@end
