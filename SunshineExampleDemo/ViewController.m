//
//  ViewController.m
//  SunshineExampleDemo
//
//  Created by hui on 16/8/19.
//  Copyright © 2016年 hui. All rights reserved.
//

#import "ViewController.h"

#import "GHNetWorkingManager.h"
#import "UIView+BlankPageView.h"
#import "MJRefresh.h"
#import "BlankPageView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tab;
@property (nonatomic,strong)NSMutableArray *arr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = [NSMutableArray array];
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.tableFooterView = [UIView new];
    
    //[self.view addSubview:self.tab];

    
   // self.tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //模拟加载服务端数据
        [self loadMyTableData];
  //  }];
    
   // [self.tab.mj_header beginRefreshing];

    //
    
}
#pragma mark UITableViewDataSource, UITableViewDelegate相关内容

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.accessoryType    = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text   = self.arr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)loadMyTableData
{
    //请求服务端接口并返回数据
   // __weak typeof(self)weakSelf = self;
    
    //成功时
   // [self.tab reloadData];
   // [self.tab.mj_header endRefreshing];
    //增加无数据展现
    
//    [self.view configBlankPage:BlankPageViewType hasData:self.arr.count hasError:(self.arr.count>0) reloadButtonBlock:^(id sender) {
//        //[MBProgressHUD showInfo:@"重新加载的数据" ToView:self.view];
////        [weakSelf.tab.mj_header beginRefreshing];
//        [self loadMyTableData];
//        
//        
//    }];
    GWeakSelf(self);
    //失败时
        [self.view configBlankPage:BlankPageViewType hasData:(self.arr.count>0) hasError:YES reloadButtonBlock:^(id sender) {
//            [MBProgressHUD showInfo:@"重新加载的数据" ToView:self.view];
//            [weakSelf.myTableView reloadData];
                //  [self loadMyTableData];
            [weakself loadMyTableData];
            
        }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
