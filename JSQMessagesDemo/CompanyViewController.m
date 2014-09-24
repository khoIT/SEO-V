//
//  CompanyViewController.m
//  JSQMessages
//
//  Created by khoi on 9/24/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//
#import "CompanyViewController.h"
#import "Company.h"
#import "OneCompanyViewController.h"
//#import "LoginViewController.h"


@implementation CompanyViewController
@synthesize companies;


- (void)viewDidLoad{
    
    //Load from company table
    companies = [NSMutableArray array];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Company"];
    [query orderByAscending:@"seo_id"];
    [query setLimit: 1000];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                Company *company = [[Company alloc]init];
                company.name = object[@"Name"];
                company.info = object[@"Info"];
                NSNumber *num = object[@"seo_id"];
                company.number = num;
                [companies addObject:company];
            }
            [self.tableView reloadData];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
//    LoginViewController *loginVC = (LoginViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//    if(loginVC){
//        [self presentViewController:loginVC animated:NO completion:nil];
//    }
}


-(void)viewWillAppear:(BOOL)animated{
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([sender isKindOfClass:[UITableViewCell class]]){
        if ([segue.destinationViewController isKindOfClass:[OneCompanyViewController class]]){
            OneCompanyViewController *nextViewController = segue.destinationViewController;
            NSIndexPath *index = [self.tableView indexPathForCell:sender];
            Company *selectedCompany = self.companies[index.row];
            nextViewController.company = selectedCompany;
            [self.tableView deselectRowAtIndexPath:index animated:NO];
        }
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return companies.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    //configure the cell
    
    Company *comp = [companies objectAtIndex:indexPath.row];
    cell.textLabel.text = comp.name;
    return cell;
}

@end
