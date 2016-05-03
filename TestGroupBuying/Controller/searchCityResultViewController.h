//
//  searchCityResultViewController.h
//  TestGroupBuying
//
//  Created by SMartP on 16/2/12.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class searchCityResultViewController;

@protocol searchCityResultDelegate <NSObject>

-(void)tableView:(UITableView *)tableView didSelectRow:(NSInteger)row;

@end

@interface searchCityResultViewController : UITableViewController

@property (assign,nonatomic) id<searchCityResultDelegate> delegate;

@property (nonatomic,copy) NSString *searchText;
@property (nonatomic,strong) NSMutableArray *searchCitys;


@end
