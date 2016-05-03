//
//  PopViewController.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/2.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "PopViewController.h"
#import "popView.h"
#import "CategoryModel.h"
//#import "DPAPI.h"
#import "OnlineCategoryModel.h"
#define CategoriesFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contacts.data"]


@interface PopViewController ()<MyPopViewDataSource,MyPopViewDelegate>{
    CategoryModel *_selectedModel;
    NSArray *_categoryArray;
    popView *_pv;
}
//@property (nonatomic , strong) NSArray * categoryArray;

@end

@implementation PopViewController

//-(NSArray *)categoryArray
//{
//    if (!_categoryArray) {
//        NSArray *data = [NSKeyedUnarchiver unarchiveObjectWithFile:CategoriesFilePath];
//        _categoryArray = [OnlineCategoryModel createWithArray:data]];
////        _categoryArray = [self getData];
//    }
//    return _categoryArray;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _categoryArray = [self getData];
//    NSLog(@"%@",_categoryArray);
//    DPAPI *api = [[DPAPI alloc]init];
//    [api requestWithURL:@"v1/metadata/get_categories_with_deals" params:nil delegate:self];
//    NSString *path = [[NSBundle mainBundle]pathForResource:@"DLCategories.plist" ofType:nil];
//    NSArray *data = [[NSArray alloc]initWithContentsOfFile:path];
//    NSArray *data = [NSKeyedUnarchiver unarchiveObjectWithFile:CategoriesFilePath];
//    _categoryArray = [OnlineCategoryModel createWithArray:data];
    _pv = [popView makePopView];
    _pv.dataSource = self;
    _pv.delegate = self;
//    _pv.autoresizingMask = UIViewAutoresizingNone;
    [_pv setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_pv];
//    _selectedModel = [_categoryArray objectAtIndex:0];
//    [_pv firstRowSelected];
    
    // Do any additional setup after loading the view.
}

-(NSArray *)getData
{
//    CategoryModel *md = [[CategoryModel alloc]init];
//    NSArray *arr = [md loadPlistData];
//    return arr;
    NSArray *data = [NSKeyedUnarchiver unarchiveObjectWithFile:CategoriesFilePath];
    NSArray *arr = [OnlineCategoryModel createWithArray:data];
    return arr;
}

-(void)dismissPop
{
    if ([self.delegate respondsToSelector:@selector(dismissPopover)]) {
        [self.delegate dismissPopover];
    }
}

#pragma mark - DPRequestDelegate
//-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
//{
////    NSLog(@"%@",result);
//    NSDictionary *res = result;
//    NSArray *arr = [res objectForKey:@"categories"];
////    OnlineCategoryModel *md = [[OnlineCategoryModel alloc]init];
//    _categoryArray = [OnlineCategoryModel createWithArray:arr];
//    [_pv reloadData];
//}
//
//-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
//{
//    NSLog(@"%@",error);
//}


#pragma mark - MyPopViewDataSource
-(NSInteger)numberOfRowsInLeftTable:(popView *)popView
{
    return _categoryArray.count;
}

-(NSString *)popView:(popView *)popView textForRowAtIndexPath:(NSInteger)row
{
    return [[_categoryArray objectAtIndex:row] name];
}

//-(NSString *)popView:(popView *)popView imageForRowAtIndexPath:(NSInteger)row
//{
//    return [[_categoryModel objectAtIndex:row] small_icon];
//}

-(NSArray *)popView:(popView *)popView subcategoriesForRowAtIndexPath:(NSInteger)row
{
    return [[_categoryArray objectAtIndex:row] subcategories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MyPopViewDelegate
-(void)popView:(popView *)popView didSelectRowAtLeftTable:(NSInteger)row
{
    _selectedModel = [_categoryArray objectAtIndex:row];
    if (!_selectedModel.subcategories.count) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"categoryDidChanged" object:nil userInfo:@{@"categoryModel" : _selectedModel}];
        [self dismissPop];
    }
}

-(void)popView:(popView *)popView didSelectRowAtRightTable:(NSInteger)row
{
    NSArray *subArr = _selectedModel.subcategories;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"subCategoryDidChanged" object:nil userInfo:@{@"categoryModel" : _selectedModel , @"subCategory" : ((row == 0)?@"全部":subArr[row - 1])}];
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
