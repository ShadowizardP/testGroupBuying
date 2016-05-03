//
//  FirstViewController.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/1.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "FirstViewController.h"
#import "NavItem.h"
#import "PopViewController.h"
#import "SecondPopViewController.h"
#import "WYPopoverController.h"
#import "ChangeCityViewController.h"
#import "MyNavController.h"
#import "CategoryModel.h"
#import "DPAPI.h"
#import "dealModel.h"
#import "MainCollectionViewCell.h"
#import "MJRefresh.h"
#import "DetailViewController.h"


@interface FirstViewController ()<WYPopoverControllerDelegate,PopViewControllerDelegate,SecondPopViewControllerDelegate,DPRequestDelegate>
{
    UIBarButtonItem *firstItem;
    UIBarButtonItem *secondItem;
//    UIBarButtonItem *thirdItem;
    NavItem *_first;
    NavItem *_second;
//    NavItem *_third;
    
    WYPopoverController *pop;
    
    NSString *_selectedCity;
    NSString *_selectedCategory;
    NSString *_selectedRegion;
    
    NSMutableArray *_dataArray;
    
    NSInteger _page;
    BOOL _newCreate;
}

@end

@implementation FirstViewController

static NSString * const reuseIdentifier = @"MainCell";

-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/2-15, [UIScreen mainScreen].bounds.size.width/2-15);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    layout.itemSize = CGSizeMake(150, 150);
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self createNavBar];
    self.collectionView.alwaysBounceVertical = YES;
    _newCreate = YES;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"MainCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    _dataArray = [[NSMutableArray alloc]init];
    
    
    
    //添加观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(categoryChanged:) name:@"categoryDidChanged" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(subCategoryChanged:) name:@"subCategoryDidChanged" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cityChanged:) name:@"cityDidChanged" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(regionChanged:) name:@"regionDidChanged" object:nil];
    
    //下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self createRequest];
        [self.collectionView.mj_header endRefreshing];
    }];
    
    //上拉加载
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        [self.collectionView.mj_footer endRefreshing];
    }];
}
#pragma mark - 观察者事件
-(void)categoryChanged:(NSNotification *)noti
{
    CategoryModel *md = noti.userInfo[@"categoryModel"];
    NSLog(@"-----%@-----",md.name);
    [_first makeNavItemUITop:md.name];
    [_first makeNavItemUIBottom:@"全部"];
    _selectedCategory = md.name;
    [self createRequest];
}

-(void)subCategoryChanged:(NSNotification *)noti
{
    CategoryModel *md = noti.userInfo[@"categoryModel"];
    NSString *subCategory = noti.userInfo[@"subCategory"];
    NSLog(@"-----%@-----",md.name);
    NSLog(@"-----%@-----",subCategory);
    [_first makeNavItemUITop:md.name];
    [_first makeNavItemUIBottom:subCategory];
    if ([subCategory isEqualToString:@"全部"]) {
        _selectedCategory = md.name;
    }
    else
    {
        _selectedCategory = subCategory;
    }
    [self createRequest];
}

-(void)cityChanged:(NSNotification *)noti
{
    _selectedCity = noti.userInfo[@"cityName"];
    _selectedRegion = nil;
    NSLog(@"%@",_selectedCity);
    [_second makeNavItemUITop:_selectedCity];
    [_second makeNavItemUIBottom:@""];
    [self createRequest];
}

-(void)regionChanged:(NSNotification *)noti
{
    NSString *region = noti.userInfo[@"region"];
    if ([region isEqualToString:@"全部"]) {
        _selectedRegion = noti.userInfo[@"fatherRegion"];
    }
    else
    {
        _selectedRegion = region;
    }
    NSLog(@"%@",_selectedRegion);
    [_second makeNavItemUITop:_selectedCity];
    [_second makeNavItemUIBottom:_selectedRegion];
    [self createRequest];
}

#pragma mark - pop消失
-(void)dismissPop
{
    [pop dismissPopoverAnimated:NO];
}


#pragma mark - 网络请求
-(void)loadMoreData
{
    _page++;
    _newCreate = NO;
    [self sendRequest];
}

-(void)createRequest
{
    _page = 1;
    _newCreate = YES;
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
//    [_dataArray removeAllObjects];
    [self sendRequest];
}

-(void)sendRequest
{
    self.collectionView.alwaysBounceVertical = NO;
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:_selectedCity forKey:@"city"];
    [params setValue:_selectedCategory forKey:@"category"];
    [params setValue:_selectedRegion forKey:@"region"];
    [params setValue:@(_page) forKey:@"page"];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

#pragma mark - DPRequestDelegate
-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    if (_newCreate) {
        [_dataArray removeAllObjects];
    }
//    NSLog(@"%@",result);
    NSDictionary *dict = result;
    NSArray *newData = [dealModel asignModelWithDict:dict];
    [_dataArray addObjectsFromArray:newData];
//    NSLog(@"%lu----%@",(unsigned long)newData.count,[newData[0]title]);
    [self.collectionView reloadData];
    self.collectionView.alwaysBounceVertical = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建导航栏
-(void) createNavBar
{
    UIBarButtonItem *logo = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
//    self.navigationItem.leftBarButtonItem = logo;
    
    _first = [NavItem makeItem];
    _second = [NavItem makeItem];
//    _third = [NavItem makeItem];
    [_first addTarget:self action:@selector(firstClicked)];
    [_second addTarget:self action:@selector(secondClicked)];
//    [_third addTarget:self action:@selector(thirdClicked)];
    [_first makeNavItemUITop:@"全部"];
    [_first makeNavItemUIBottom:@""];
    [_second makeNavItemUITop:@"未定位"];
    [_second makeNavItemUIBottom:@""];
    
    firstItem = [[UIBarButtonItem alloc]initWithCustomView:_first];
    secondItem = [[UIBarButtonItem alloc]initWithCustomView:_second];
//    thirdItem = [[UIBarButtonItem alloc]initWithCustomView:_third];
//    self.navigationItem.leftBarButtonItems = @[logo,firstItem,secondItem,thirdItem];
    self.navigationItem.leftBarButtonItems = @[logo,firstItem,secondItem];
    
}

#pragma mark - 点击事件
-(void)firstClicked
{
//    NSLog(@"1");
    [self createPopover];
}

-(void)secondClicked
{
//    NSLog(@"2");
    [self createSecondPopover];
}

//-(void)thirdClicked
//{
////    NSLog(@"3");
//    [self createPopover];
//}

#pragma mark - WYPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)aPopoverController
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    pop.delegate = nil;
    pop = nil;
}



#pragma mark - 创建第一个下拉菜单
-(void)createPopover
{
    PopViewController *pvc = [[PopViewController alloc]init];
    pvc.delegate = self;
    pvc.preferredContentSize = CGSizeMake(300, 500);
//    UIPopoverController *pop = [[UIPopoverController alloc]initWithContentViewController:pvc];
    pop = [[WYPopoverController alloc]initWithContentViewController:pvc];
    pop.delegate = self;
//    [pop presentPopoverFromBarButtonItem:firstItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [pop presentPopoverFromBarButtonItem:firstItem permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
    
}

#pragma mark - PopViewControllerDelegate
-(void)dismissPopover
{
    [self dismissPop];
}

#pragma mark - 创建第二个下拉菜单
-(void)createSecondPopover
{
    SecondPopViewController *spvc = [[SecondPopViewController alloc]initWithNibName:@"SecondPopViewController" bundle:nil];
    if (_selectedCity) {
        spvc.selectedCity = _selectedCity;
    }
    spvc.delegate = self;
    spvc.preferredContentSize = CGSizeMake(300, 500);
    pop = [[WYPopoverController alloc]initWithContentViewController:spvc];
    pop.delegate = self;
    [pop presentPopoverFromBarButtonItem:secondItem permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
}

#pragma mark - SecondPopViewControllerDelegate
-(void)changeCityOnClicked:(UIButton *)btn
{
    ChangeCityViewController *ccvc = [[ChangeCityViewController alloc]initWithNibName:@"ChangeCityViewController" bundle:nil];
    MyNavController *nav = [[MyNavController alloc]initWithRootViewController:ccvc];
    [self dismissPop];
    [self presentViewController:nav animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    dealModel *md = _dataArray[indexPath.item];
    [cell makeUIWithModel:md];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *dvc = [[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
    dvc.md = _dataArray[indexPath.item];
    MyNavController *nav = [[MyNavController alloc]initWithRootViewController:dvc];
    [self presentViewController:nav animated:YES completion:nil];
}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
