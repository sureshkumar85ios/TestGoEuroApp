//
//  ChildViewController.m
//  GoEuroTest
//
//  Created by ADDC on 8/2/16.
//  Copyright © 2016 sureshkumar. All rights reserved.
//

#import "ChildViewController.h"
#import "UIImageView+Async.h"


@implementation ChildViewController




- (id)init {
    _arrayValues = [[NSMutableArray alloc]init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayValues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    NSArray *temp = [_arrayValues objectAtIndex:indexPath.row];
    UILabel *labelPrice = (UILabel *)[cell.contentView viewWithTag:3];
    [labelPrice setText:[NSString stringWithFormat:@"€ %.2f",[[temp valueForKey:@"price_in_euros"] floatValue]]];
    
    
    NSString *logoString = [temp valueForKey:@"provider_logo"];
    logoString = [logoString stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
    
    UIImageView *myImageView = (UIImageView *)[cell.contentView viewWithTag:11];
    [myImageView setImageURL:logoString placeholder:nil];
    
    
    UILabel *labelno = (UILabel *)[cell.contentView viewWithTag:2];
    int noofst = [[temp valueForKey:@"number_of_stops"] intValue];
    if (noofst == 0) {
        
        [labelno setText:@"Non-Stop"];
        
    }
    else
    {
        [labelno setText:[NSString stringWithFormat:@"%d stop",noofst]];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString *strdept = [temp valueForKey:@"departure_time"];
    NSString *strAr = [temp valueForKey:@"arrival_time"];
    
    UILabel *labelfrom = (UILabel *)[cell.contentView viewWithTag:5];
    [labelfrom setText:[NSString stringWithFormat:@"Dep:%@",strdept]];
    UILabel *labelTo = (UILabel *)[cell.contentView viewWithTag:6];
    [labelTo setText:[NSString stringWithFormat:@"Arr:%@",strAr]];
    
    NSDate *ddept = [formatter dateFromString:[temp valueForKey:@"departure_time"]];
    NSDate *dArr = [formatter dateFromString:[temp valueForKey:@"arrival_time"]];
    
    if (ddept && dArr) {
        
        UILabel *labelhr = (UILabel *)[cell.contentView viewWithTag:1];
        [labelhr setText:[self calculatehoursFromHours:ddept andToDate:dArr]];
    }
  
    return cell;
}

-(NSString *)calculatehoursFromHours:(NSDate*)ddept andToDate:(NSDate*)dArr
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitHour|NSCalendarUnitMinute
                                                        fromDate:ddept
                                                          toDate:dArr
                                                         options:0];
    
    NSString *durationString = [NSString stringWithFormat:@"%@h %@m", @(components.hour).stringValue, @(components.minute).stringValue];
    return durationString;
}
@end
