//
//  SecondPopViewController.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/5.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "SecondPopViewController.h"
#import "CityGroupModel.h"
#import "ChangeCityViewController.h"
#import "MyNavController.h"
#import "DPAPI.h"
#import "popView.h"
#import "regionModel.h"

@interface SecondPopViewController ()<DPRequestDelegate,MyPopViewDataSource,MyPopViewDelegate>
{
    regionModel *_selectedModel;
    NSArray *_regionArray;
    popView *_pv;
}
@property (weak, nonatomic) IBOutlet UIButton *changeCityBtn;
@property (weak, nonatomic) IBOutlet UIView *regionView;

@end

@implementation SecondPopViewController
- (IBAction)changeCityBtnClicked:(id)sender {
//    ChangeCityViewController *ccvc = [[ChangeCityViewController alloc]initWithNibName:@"ChangeCityViewController" bundle:nil];
//    MyNavController *nav = [[MyNavController alloc]initWithRootViewController:ccvc];
//    nav.modalPresentationStyle = UIModalPresentationCurrentContext;
//    [self presentViewController:nav animated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(changeCityOnClicked:)]) {
        [self.delegate changeCityOnClicked:sender];
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getRegion];
    _pv = [popView makePopView];
    _pv.dataSource = self;
    _pv.delegate = self;
//    _pv.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [_pv setFrame:CGRectMake(0, 0, _regionView.frame.size.width, _regionView.frame.size.height)];
    [self.regionView addSubview:_pv];
//    self.regionView = _pv;
    // Do any additional setup after loading the view from its nib.
}

- (void)getRegion
{
    DPAPI *api = [[DPAPI alloc]init];
    if (_selectedCity) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        [params setValue:_selectedCity forKey:@"city"];
        [api requestWithURL:@"v1/metadata/get_regions_with_deals" params:params delegate:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissPop
{
    if ([self.delegate respondsToSelector:@selector(dismissPopover)]) {
        [self.delegate dismissPopover];
    }
}

#pragma mark - DPRequestDelegate
-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
//    NSLog(@"%@",result);
    NSDictionary *res = result;
    NSDictionary *city = [res objectForKey:@"cities"][0];
    NSArray *arr = [city objectForKey:@"districts"];
    _regionArray = [regionModel createWithArray:arr];
//    NSLog(@"%@",_regionArray);
    [_pv reloadData];
}

-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

#pragma mark - MyPopViewDataSource
-(NSInteger)numberOfRowsInLeftTable:(popView *)popView
{
    if (_regionArray) {
        return _regionArray.count;
    }
    else{
        return 0;
    }
}

-(NSString *)popView:(popView *)popView textForRowAtIndexPath:(NSInteger)row
{
    return [[_regionArray objectAtIndex:row] district_name];
}

-(NSArray *)popView:(popView *)popView subcategoriesForRowAtIndexPath:(NSInteger)row
{
    return [[_regionArray objectAtIndex:row] neighborhoods];
}


#pragma mark - MyPopViewDelegate
-(void)popView:(popView *)popView didSelectRowAtLeftTable:(NSInteger)row
{
    _selectedModel = _regionArray[row];
}

-(void)popView:(popView *)popView didSelectRowAtRightTable:(NSInteger)row
{
    NSString *neighborhood = ((row == 0)?@"全部":_selectedModel.neighborhoods[row - 1]);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"regionDidChanged" object:nil userInfo:@{@"fatherRegion" : [_selectedModel district_name], @"region":neighborhood}];
    [self dismissPop];
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
