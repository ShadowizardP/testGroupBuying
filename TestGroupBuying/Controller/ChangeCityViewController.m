//
//  ChangeCityViewController.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/6.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "ChangeCityViewController.h"
#import "CityGroupModel.h"
#include "UIView+AutoLayout.h"
#import "searchCityResultViewController.h"
#import "cityModel.h"

@interface ChangeCityViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,searchCityResultDelegate>
{
    NSArray *_dataArray;
    NSArray *_titleArray;
}
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UISearchBar *citySearchBar;

@property (strong , nonatomic) searchCityResultViewController *scrvc;

@end

@implementation ChangeCityViewController

-(searchCityResultViewController *)scrvc
{
    if (!_scrvc) {
        _scrvc = [[searchCityResultViewController alloc]init];
        [self.view addSubview:_scrvc.view];
        [self.scrvc.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.scrvc.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.citySearchBar];
    }
    return _scrvc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"切换城市";
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_navigation_close"] style:UIBarButtonItemStyleDone target:self action:@selector(backToVC)];
    self.navigationItem.leftBarButtonItem = closeItem;
    CityGroupModel *md = [[CityGroupModel alloc]init];
    _dataArray = [md getCityModelArray];
    _titleArray = [md getCityTitleArray];
    _citySearchBar.tintColor = [UIColor grayColor];
}

-(void)backToVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_dataArray objectAtIndex:section] cities].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cityTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    CityGroupModel *md = [_dataArray objectAtIndex:indexPath.section];
    cell.textLabel.text = [[md cities] objectAtIndex:indexPath.row];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[_dataArray objectAtIndex:section] title];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityGroupModel *md = [_dataArray objectAtIndex:indexPath.section];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"cityDidChanged" object:nil userInfo:@{@"cityName":[[md cities] objectAtIndex:indexPath.row]}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _titleArray;
}


#pragma mark - searchBar delegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.coverView.hidden = NO;
    [self.citySearchBar setShowsCancelButton:YES animated:YES];
    for (UIView *view in [[_citySearchBar.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)view;
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.bounds = CGRectMake(0, -20 , self.view.frame.size.width, self.view.frame.size.height);
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    self.coverView.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.bounds = CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height);
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
//    self.citySearchBar.showsCancelButton = NO;
    [self.citySearchBar setShowsCancelButton:NO animated:YES];
    [self.citySearchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length) {
        self.scrvc.view.hidden = NO;
        self.scrvc.searchText = searchText;
        if(self.scrvc.delegate != self)
            self.scrvc.delegate = self;
    }
    else
    {
        self.scrvc.view.hidden = YES;
    }
}


#pragma mark - searchCityResultDelegate
-(void)tableView:(UITableView *)tableView didSelectRow:(NSInteger)row
{
    cityModel *md = [_scrvc.searchCitys objectAtIndex:row];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"cityDidChanged" object:nil userInfo:@{@"cityName":md.name}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
