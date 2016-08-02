//
//  ChildViewController.h
//  GoEuroTest
//
//  Created by ADDC on 8/2/16.
//  Copyright © 2016 sureshkumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *arrayValues;

@end
